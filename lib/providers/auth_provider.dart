import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tnp_rgpv_app/global_services/api_services.dart';
import 'package:tnp_rgpv_app/providers/snackbar_provider.dart';
import 'package:tnp_rgpv_app/routes.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
  final apiService = GlobalApiService();
  return AuthNotifier(apiService: apiService);
});

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  final GlobalApiService apiService;

  AuthNotifier({required this.apiService}) : super(const AsyncData(null));

  // Reset to initial state when necessary
  void resetState() {
    state = const AsyncData(null); // Reset state to initial state
  }

  // Login Parameters:
  // EnrollmentNo string
  // Email        string
  // Password     string
  // Phone        string
  // Consolidated sign-in method
  Future<void> login({
    required String enrollmentNo,
    required String email,
    required String phone,
    required String password,
    required WidgetRef ref,
  }) async {
    state = const AsyncLoading();

    // Navigator.pushReplacementNamed(ref.context, AppScreenRoutes.main);
    // return;

    try {
      // Prepare login request data
      final data = {
        'enrollmentNo': enrollmentNo,
        'email': email,
        'phone': phone,
        'password': password,
      };

      // Make the login API request
      final response = await apiService.makeRequest(
        endpoint: '/auth/login',
        method: 'POST',
        data: data,
        ref: ref,
      );

      // Decode the response body if it's a JSON response
      final responseBody = response.data;

      // Extract the token and message from the response
      final authorization = responseBody['Authorization'] ?? '';
      final token = authorization.startsWith('Bearer ')
          ? authorization.substring(7)
          : authorization;

      debugPrint('Token: $token');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('Authorization', token);

      // Handle successful response
      resetState();

      // Show success Snackbar.
      ref.read(snackBarProvider.notifier).showSnackBar(
            'Login Successful',
            'Welcome back!',
          );

      // Schedule navigation to happen after the current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(ref.context, AppScreenRoutes.main);
      });
    } catch (e, stackTrace) {
      // Handle error response
      state = AsyncError(e, stackTrace);
      debugPrint(e.toString());
      ref.read(snackBarProvider.notifier).showSnackBar('Error', e.toString());
    }
  }

  // Signup Parameters:
  // EnrollmentNo string
  // Email        string
  // Password     string
  // Phone        string
  // Name               string
  // Branch             string
  // YearOfEnrollment   int
  // ClassTenPercent    float32
  // ClassTwelvePercent float32
  // PreviousSemCGPA float32
  // PreviousSemSGPA float32
  // Certifications []string
  // Resume         string

  Future<void> signup({
    required String enrollmentNo,
    required String email,
    required String phone,
    required String password,
    required String name,
    required String branch,
    required int yearOfEnrollment,
    required double classTenPercent,
    required double classTwelvePercent,
    required double previousSemCGPA,
    required double previousSemSGPA,
    required List<String> certifications,
    required String resume,
    required WidgetRef ref,
  }) async {
    state = const AsyncLoading();

    try {
      // Prepare signup request data with all necessary parameters
      final data = {
        'enrollmentNo': enrollmentNo,
        'email': email,
        'phone': phone,
        'password': password,
        'name': name,
        'branch': branch,
        'yearOfEnrollment': yearOfEnrollment,
        'classTenPercent': classTenPercent,
        'classTwelvePercent': classTwelvePercent,
        'previousSemCGPA': previousSemCGPA,
        'previousSemSGPA': previousSemSGPA,
        'certifications': certifications,
        'resume': resume,
      };

      // Make the signup API request
      final response = await apiService.makeRequest(
        endpoint: '/auth/signup',
        method: 'POST',
        data: data,
        ref: ref,
      );

      // Decode the response body if it's a JSON response
      final responseBody = response.data;

      // Extract the token and message from the response
      final authorization = responseBody['Authorization'] ?? '';
      final token = authorization.startsWith('Bearer ')
          ? authorization.substring(7)
          : authorization;
      final message = responseBody['message'];

      debugPrint('Token: $token');
      debugPrint('Message: $message');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('Authorization', token);

      // Handle successful response
      resetState();

      // Show success Snackbar
      ref.read(snackBarProvider.notifier).showSnackBar(
            'Signup Successful',
            message,
          );

      // Schedule navigation to happen after the current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(ref.context, AppScreenRoutes.main);
      });
    } catch (e, stackTrace) {
      // Handle error response
      state = AsyncError(e, stackTrace);
      debugPrint(e.toString());
      ref.read(snackBarProvider.notifier).showSnackBar('Error', e.toString());
    }
  }
}
