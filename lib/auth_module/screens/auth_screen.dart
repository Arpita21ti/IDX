import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/auth_module/components/log_in_form.dart';
import 'package:tnp_rgpv_app/auth_module/components/sign_up_form_part_1.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/global_widgets/wave_box.dart';
import 'package:tnp_rgpv_app/providers/auth_form_index_provider.dart';
import 'package:tnp_rgpv_app/providers/loading_provider.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 0: SignInForm, 1: SignUpForm
    final currentIndex = ref.watch(authFormIndexProvider);
    final isLoading = ref.watch(loadingProvider);

    void toggleForm() {
      ref.read(authFormIndexProvider.notifier).state =
          currentIndex == 0 ? 1 : 0;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const WaveBackground(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            StyleGlobalVariables.screenSizingReference * 0.02,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            currentIndex == 0 ? 'Sign In' : 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            height: StyleGlobalVariables.screenSizingReference *
                                0.02,
                          ),
                          currentIndex == 0
                              ? const LogInForm()
                              : const SignUpFormPart1(),
                          SizedBox(
                            height: StyleGlobalVariables.screenSizingReference *
                                0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(currentIndex == 0
                                  ? "Don't have an account? "
                                  : "Already have an account? "),
                              GestureDetector(
                                onTap: toggleForm,
                                child: Text(
                                  currentIndex == 0 ? 'Sign Up' : 'Sign In',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // const WaveBackground(),
              ],
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
