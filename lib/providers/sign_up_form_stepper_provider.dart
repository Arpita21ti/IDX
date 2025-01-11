import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier to manage the current step in the form
class StepperNotifier extends StateNotifier<int> {
  StepperNotifier() : super(1); // Default to step 1

  // Set current step
  void setStep(int step) {
    state = step;
  }

  // Increment current step
  void nextStep() {
    if (state < 4) {
      // Assuming there are 4 steps
      state++;
    }
  }

  // Decrement current step
  void previousStep() {
    if (state > 1) {
      state--;
    }
  }
}

// Provider to access and modify current step
final stepperProvider = StateNotifierProvider<StepperNotifier, int>((ref) {
  return StepperNotifier();
});

// Provider to hold the total steps
final totalStepsProvider = Provider<int>((ref) => 4); // 4 steps for example
