import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:tnp_rgpv_app/test_data/auth_test.dart';

final formControllersProvider = StateNotifierProvider<FormControllerNotifier,
    Map<String, TextEditingController>>((ref) {
  return FormControllerNotifier();
});

class FormControllerNotifier
    extends StateNotifier<Map<String, TextEditingController>> {
  FormControllerNotifier()
      : super({
          'enrollment': TextEditingController(),
          'email': TextEditingController(),
          'password': TextEditingController(),
          'phone': TextEditingController(),
          'name': TextEditingController(),
          'classTenPercent': TextEditingController(),
          'classTwelvePercent': TextEditingController(),
          'previousSemCGPA': TextEditingController(),
          'previousSemSGPA': TextEditingController(),
        });

  // Reset the controllers
  void resetForm() {
    state.forEach((key, controller) {
      controller.clear();
    });
  }

  // Autofill data for debugging (part 1)
  void autofillTestDataLoginAndSignUpFormPart1() {
    if (kDebugMode) {
      state['enrollment']?.text = testData['enrollment']!.toString();
      state['email']?.text = testData['email']!.toString();
      state['phone']?.text = testData['phone']!.toString();
      state['password']?.text = testData['password']!.toString();
    }
  }

  // Autofill data for debugging (part 2)
  void autofillTestDataSignUpFormPart2() {
    if (kDebugMode) {
      state['name']?.text = testData['name']!.toString();
      state['classTenPercent']?.text = testData['classTenPercent']!.toString();
      state['classTwelvePercent']?.text =
          testData['classTwelvePercent']!.toString();
      state['previousSemCGPA']?.text = testData['previousSemCGPA']!.toString();
      state['previousSemSGPA']?.text = testData['previousSemSGPA']!.toString();
    }
  }
}

// Separate Providers with limited use so in this file and not in separate ones.
final selectedBranchProvider =
    StateProvider<String>((ref) => "Computer Science");
final selectedYearProvider = StateProvider<String>((ref) => "1");
