import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/providers/snackbar_provider.dart';

// To show Custom Snackbars across the app.
Future<void> showCustomSnackBar(
  String? title,
  String message,
  WidgetRef ref, // Pass the ref from the widget
) {
  // Update the snackBar provider with the message
  ref.read(snackBarProvider.notifier).showSnackBar(title, message);

  return Future.value();
}
