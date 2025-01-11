import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/auth_module/components/custom_stepper.dart';
import 'package:tnp_rgpv_app/global_services/file_picker_service.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/global_widgets/my_scaffold.dart';
import 'package:tnp_rgpv_app/providers/media_providers.dart';
import 'package:tnp_rgpv_app/providers/sign_up_form_stepper_provider.dart';
import 'package:tnp_rgpv_app/routes.dart';

class SignUpFormPart3 extends ConsumerWidget {
  const SignUpFormPart3({super.key});

  void pickFiles({
    required FilePickerService filePickerService,
    required WidgetRef ref,
    required bool isPhoto,
  }) async {
    final file = await filePickerService.pickFile(isPhoto: isPhoto);

    if (file != null) {
      if (file is Uint8List) {
        // Update web photo bytes provider
        ref.read(webPhotoProvider.notifier).state = file;
      } else if (file is File) {
        // Handle File object (mobile/desktop)
        if (isPhoto) {
          // Update photo file provider
          ref.read(photoProvider.notifier).state = File(file.path);
        } else {
          // Update resume file provider
          ref.read(resumeProvider.notifier).state = File(file.path);
        }
      } else if (file is String) {
        // Update web resume name provider
        ref.read(webResumePathProvider.notifier).state = file;
      }
    } else {
      debugPrint('No file selected');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FilePickerService filePickerService = FilePickerService();

    return MyScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Formal Photograph:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ) ??
                  const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            // Formal Photo Upload
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                filePickerService.displayFile(
                  ref: ref,
                  isPhoto: true,
                  width: StyleGlobalVariables.screenSizingReference * 0.35,
                  height: StyleGlobalVariables.screenSizingReference * 0.35,
                  webPhotoBytes: ref.watch(webPhotoProvider),
                  photo: ref.watch(photoProvider),
                  webNotPhotoPath: ref.watch(webResumePathProvider),
                  notPhoto: ref.watch(resumeProvider),
                ),
                ElevatedButton(
                  onPressed: () {
                    pickFiles(
                      filePickerService: filePickerService,
                      ref: ref,
                      isPhoto: true,
                    );
                  },
                  child: Text(
                    ref.watch(photoProvider) == null &&
                            ref.watch(webPhotoProvider) == null
                        ? 'Upload Formal Photo (JPG/PNG)'
                        : 'Change Photo',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(
              thickness: 5,
            ),

            SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.02),

            // Resume Upload
            Text(
              'Your Resume:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ) ??
                  const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                filePickerService.displayFile(
                  ref: ref,
                  isPhoto: false,
                  width: StyleGlobalVariables.screenSizingReference * 0.35,
                  height: StyleGlobalVariables.screenSizingReference * 0.35,
                  webPhotoBytes: ref.watch(webPhotoProvider),
                  photo: ref.watch(photoProvider),
                  webNotPhotoPath: ref.watch(webResumePathProvider),
                  notPhoto: ref.watch(resumeProvider),
                ),
                ElevatedButton(
                  onPressed: () {
                    pickFiles(
                      filePickerService: filePickerService,
                      ref: ref,
                      isPhoto: false,
                    );
                  },
                  child: Text(
                    ref.watch(resumeProvider) == null &&
                            ref.watch(webResumePathProvider) == null
                        ? 'Upload Resume (PDF/Word)'
                        : 'Change Resume',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(
              thickness: 5,
            ),

            SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.05),

            // Next Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Validate if photo and resume are uploaded
                  final photoUploaded =
                      ref.watch(kIsWeb ? webPhotoProvider : photoProvider) !=
                          null;
                  final resumeUploaded = ref.watch(
                          kIsWeb ? webResumePathProvider : resumeProvider) !=
                      null;

                  if (!photoUploaded && !resumeUploaded) {
                    // Show error dialog or snack bar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please upload both a formal photo and your resume before proceeding.',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: StyleGlobalVariables.primaryErrorColor,
                      ),
                    );
                  } else if (!photoUploaded && resumeUploaded) {
                    // Show error dialog or snack bar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please upload a formal photo before proceeding.',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: StyleGlobalVariables.primaryErrorColor,
                      ),
                    );
                  } else if (photoUploaded && !resumeUploaded) {
                    // Show error dialog or snack bar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please upload your resume before proceeding.',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: StyleGlobalVariables.primaryErrorColor,
                      ),
                    );
                  } else {
                    // If valid, proceed to the next step
                    ref
                        .read(stepperProvider.notifier)
                        .setStep(4); // Move to the next step
                    Navigator.pushNamed(
                      context,
                      AppScreenRoutes.signUpFormPart4,
                    );
                  }
                },
                child: const Text('Next'),
              ),
            ),
            SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.05),
            const CustomStepper(),
          ],
        ),
      ),
    );
  }
}
