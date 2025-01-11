import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/global_widgets/text_field.dart';
import 'package:tnp_rgpv_app/providers/auth_form_providers.dart';
import 'package:tnp_rgpv_app/providers/auth_provider.dart';
import 'package:tnp_rgpv_app/providers/loading_provider.dart';
import 'package:tnp_rgpv_app/routes.dart';

class LogInForm extends ConsumerStatefulWidget {
  const LogInForm({super.key});

  @override
  ConsumerState<LogInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<LogInForm> {
  final _formKey = GlobalKey<FormState>();

  void _handleLogIn() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(ref.context, AppScreenRoutes.main);
      });
    // if (_formKey.currentState?.validate() ?? false) {
    //   // Extract user input
    //   final controllers =
    //       ref.read(formControllersProvider); // Access controllers
    //   final enrollmentNo = controllers['enrollment']!.text.trim();
    //   final email = controllers['email']!.text.trim();
    //   final phone = controllers['phone']!.text.trim();
    //   final password = controllers['password']!.text.trim();

    //   // Set loading state
    //   ref.read(loadingProvider.notifier).state = true;

    //   // Call the login method in AuthNotifier
    //   ref
    //       .read(authProvider.notifier)
    //       .login(
    //         enrollmentNo: enrollmentNo,
    //         email: email,
    //         phone: phone,
    //         password: password,
    //         ref: ref,
    //       )
    //       .whenComplete(() {
    //     ref.read(loadingProvider.notifier).state = false; // Reset loading state
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider);

    final controllers = ref.watch(formControllersProvider);
    final enrollmentController = controllers['enrollment']!;
    final emailController = controllers['email']!;
    final passwordController = controllers['password']!;
    final phoneController = controllers['phone']!;

    // Trigger autofill in debug mode
    if (kDebugMode) {
      ref
          .read(formControllersProvider.notifier)
          .autofillTestDataLoginAndSignUpFormPart1();
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
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
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.02),
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
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.02),
          CustomTextField(
            label: 'Phone No.',
            hint: 'Enter your phone number',
            controller: phoneController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              final phoneRegex = RegExp(r'^[6-9]\d{9}$');
              if (!phoneRegex.hasMatch(value)) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.02),
          CustomTextField(
            label: 'Password',
            hint: 'Enter your password',
            controller: passwordController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.03),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : _handleLogIn,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Sign In'),
            ),
          ),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.01),
          Consumer(
            builder: (context, ref, child) {
              final authState = ref.watch(authProvider);
              return authState.when(
                data: (_) => const SizedBox.shrink(),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) {
                  //  Show error message and hide after 5 seconds
                  Future.delayed(const Duration(seconds: 5), () {
                    if (mounted) {
                      // Clear the error message after 5 seconds
                      ref.read(authProvider.notifier).resetState();
                    }
                  });
                  return Text(
                    'Error: $error',
                    style: const TextStyle(color: StyleGlobalVariables.primaryErrorColor),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
