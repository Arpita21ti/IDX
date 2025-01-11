import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/auth_module/components/custom_stepper.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/global_widgets/text_field.dart';
import 'package:tnp_rgpv_app/providers/auth_form_providers.dart';
import 'package:tnp_rgpv_app/providers/sign_up_form_stepper_provider.dart';
import 'package:tnp_rgpv_app/routes.dart';

class SignUpFormPart1 extends ConsumerWidget {
  const SignUpFormPart1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Accessing screen size from Riverpod
    final screenSize = StyleGlobalVariables.screenSizingReference;

    // Initialize form key
    final GlobalKey<FormState> signUpFormPart1Key = GlobalKey<FormState>();

    final controllers = ref.watch(formControllersProvider);
    final enrollmentController = controllers['enrollment']!;
    final emailController = controllers['email']!;

    // Trigger autofill in debug mode
    if (kDebugMode) {
      ref
          .read(formControllersProvider.notifier)
          .autofillTestDataLoginAndSignUpFormPart1();
    }

    return Form(
      key: signUpFormPart1Key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enrollment No Field
          CustomTextField(
            label: 'Enrollment No.',
            hint: 'Enter your enrollment number',
            controller: enrollmentController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your enrollment number';
              }
              return null;
            },
          ),

          SizedBox(height: screenSize * 0.02), // Use screen size from Riverpod
          // Email field
          CustomTextField(
            label: 'Email',
            hint: 'Enter your email',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              final emailRegex =
                  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),

          SizedBox(height: screenSize * 0.03), // Use screen size from Riverpod

          // Next button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (signUpFormPart1Key.currentState?.validate() ?? false) {
                  ref
                      .read(stepperProvider.notifier)
                      .setStep(2); // Move to the next step
                  // Proceed to next screen
                  Navigator.pushNamed(
                    context,
                    AppScreenRoutes.signUpFormPart2,
                  );
                }
              },
              child: const Text('Next'),
            ),
          ),
          SizedBox(height: screenSize * 0.05),

          // Custom stepper
          const CustomStepper(),
        ],
      ),
    );
  }
}
