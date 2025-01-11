import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tnp_rgpv_app/providers/api_base_url_provider.dart';
import 'package:tnp_rgpv_app/providers/snackbar_provider.dart';

class GlobalApiService {
  // Generic method for making HTTP requests
  Future<Response> makeRequest({
    required String endpoint,
    required String method,
    // Pass data for POST req body or
    // Query Params for GET req
    required Map<String, dynamic> data,
    required WidgetRef ref,
    Map<String, dynamic>? headers, // Optional headers parameter
  }) async {
    final Dio dio = Dio();

    final String apiBaseUrl = await ref.watch(apiBaseUrlProvider);

    // Log the endpoint (route) where the request is being made
    debugPrint("Making request to endpoint: $apiBaseUrl$endpoint");

    // Retrieve the token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(
        'Authorization'); // Assuming 'auth_token' is the key where the token is stored

    // Default headers
    final Map<String, dynamic> defaultHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      if (token != null)
        'Authorization': 'Bearer $token', // Add token if available
    };

    // If headers are provided, merge them with default headers
    final Map<String, dynamic> mergedHeaders = {
      ...defaultHeaders,
      if (headers != null) ...headers, // Merge provided headers if any
    };

    try {
      Response response;

      // Sending the request based on the method (GET, POST, etc.)
      switch (method) {
        case 'POST':
          response = await dio.post(
            '$apiBaseUrl$endpoint',
            data: data,
            options: Options(
              headers: mergedHeaders,
            ),
          );
          break;
        case 'GET':
          response = await dio.get(
            '$apiBaseUrl$endpoint',
            queryParameters:
                data, // For GET, send parameters via queryParameters
            options: Options(
              headers: mergedHeaders,
            ),
          );
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      // Handle successful response
      return _handleResponse(response, ref);
    } on DioException catch (e) {
      // Handle error using the centralized error handling
      return _handleError(e, ref);
    } catch (e) {
      // Catch any other unexpected errors
      ref.read(snackBarProvider.notifier).showSnackBar(
            'Error',
            'An unexpected error occurred.',
          );
      rethrow;
    }
  }

  // Method to handle the response from the server
  Response _handleResponse(Response response, WidgetRef ref) {
    // Log the response data for debugging
    debugPrint("Response Status Code: ${response.statusCode}");
    debugPrint("Response Data: ${response.data}");

    if (response.statusCode == 200) {
      // Success - Can return the response data or perform additional logic
      return response;
    } else {
      // Error response from server
      final errorMessage = _getErrorMessageFromResponse(response);
      ref.read(snackBarProvider.notifier).showSnackBar('Error', errorMessage);
      throw Exception(errorMessage);
    }
  }

  // Method to handle Dio errors (network or server-side errors)
  Response _handleError(DioException e, WidgetRef ref) {
    String errorMessage = 'An unexpected error occurred.';
    if (e.type == DioExceptionType.connectionTimeout) {
      errorMessage = 'Connection Timeout. Please try again later.';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Server took too long to respond. Please try again later.';
    } else if (e.type == DioExceptionType.badResponse) {
      errorMessage = _getErrorMessageFromResponse(e.response);
    } else if (e.type == DioExceptionType.cancel) {
      errorMessage = 'Request was canceled. Please try again.';
    } else {
      errorMessage = 'Network error. Please check your connection.';
    }

    // Log the actual error details
    debugPrint(
        "DioException: ${e.toString()}"); // Prints the entire exception details
    debugPrint(
        "DioErrorType: ${e.type}"); // Prints the type of the error (e.g., timeout, bad response)
    debugPrint(
        "DioErrorMessage: ${e.message}"); // Prints the message associated with the error

    ref.read(snackBarProvider.notifier).showSnackBar('Error', errorMessage);
    throw Exception(errorMessage);
  }

  // Helper method to extract error message from the response
  String _getErrorMessageFromResponse(Response? response) {
    if (response == null) return 'Unknown error occurred';
    try {
      final data = response.data;
      return data['msg'] ?? data['error'] ?? 'Unknown error occurred';
    } catch (_) {
      debugPrint("Failed to parse response.");
      // If the response data is available, print the response data
      if (response.data != null) {
        debugPrint("Response data: ${response.data}");
      }
      return 'Failed to parse error message';
    }
  }
}
