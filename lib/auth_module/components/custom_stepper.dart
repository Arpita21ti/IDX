import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/providers/sign_up_form_stepper_provider.dart';
import 'package:tnp_rgpv_app/routes.dart'; // Import your provider file

class CustomStepper extends StatelessWidget {
  const CustomStepper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentStep = ref.watch(stepperProvider); // Current step
        final totalSteps = ref.watch(totalStepsProvider); // Total steps

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            totalSteps,
            (index) {
              int stepNumber = index + 1; // Convert 0-indexed to 1-indexed
              bool isActive = stepNumber == currentStep;
              bool isCompleted = stepNumber < currentStep;

              return Row(
                children: [
                  // Circle for each step
                  GestureDetector(
                    onTap: () {
                      // Update current step when tapped
                      ref.read(stepperProvider.notifier).setStep(stepNumber);

                      // Navigate based on the selected step
                      if (stepNumber == 1) {
                        Navigator.pushNamed(context, AppScreenRoutes.auth);
                      } else if (stepNumber == 2) {
                        Navigator.pushNamed(
                            context, AppScreenRoutes.signUpFormPart2);
                      } else if (stepNumber == 3) {
                        Navigator.pushNamed(
                            context, AppScreenRoutes.signUpFormPart3);
                      } else {
                        Navigator.pushNamed(
                            context, AppScreenRoutes.signUpFormPart4);
                      }
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: isActive
                          ? Colors.blue
                          : isCompleted
                              ? Colors.green
                              : Colors.grey,
                      child: Center(
                        // Ensure text is centered inside the circle
                        child: Text(
                          '$stepNumber',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ), // Spacer between steps (except after the last step)
                  if (index < totalSteps - 1)
                    Container(
                      width: 40,
                      height: 2,
                      color: isCompleted ? Colors.green : Colors.grey,
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
