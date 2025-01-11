import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/auth_module/components/custom_stepper.dart';
import 'package:tnp_rgpv_app/global_services/file_picker_service.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/global_widgets/my_scaffold.dart';
import 'package:tnp_rgpv_app/global_widgets/text_field.dart';
import 'package:tnp_rgpv_app/providers/auth_form_providers.dart';
import 'package:tnp_rgpv_app/providers/auth_provider.dart';
import 'package:tnp_rgpv_app/providers/certification_providers.dart';
import 'package:tnp_rgpv_app/providers/loading_provider.dart';
import 'package:tnp_rgpv_app/providers/media_providers.dart';
import 'package:tnp_rgpv_app/test_data/auth_test.dart';

class SignUpFormPart4 extends ConsumerWidget {
  const SignUpFormPart4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);

    void handleSignUp(
        {required BuildContext context, required WidgetRef ref}) async {
      final certifications = ref.watch(certificationProvider);

      // Ensure certifications are not empty
      if (certifications.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please add at least one certification before submitting.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: StyleGlobalVariables.primaryErrorColor,
          ),
        );
        return;
      }

      // Extract user input from controllers
      final controllers = ref.read(formControllersProvider);
      final enrollmentNo = controllers['enrollment']!.text.trim();
      final email = controllers['email']!.text.trim();
      final phone = controllers['phone']!.text.trim();
      final password = controllers['password']!.text.trim();
      final name = controllers['name']!.text.trim();
      final branch = ref.read(selectedBranchProvider).trim();
      final yearOfEnrollment =
          int.tryParse(ref.read(selectedYearProvider)) ?? 0;
      final classTenPercent =
          double.tryParse(controllers['classTenPercent']!.text.trim()) ?? 0.0;
      final classTwelvePercent =
          double.tryParse(controllers['classTwelvePercent']!.text.trim()) ??
              0.0;
      final previousSemCGPA =
          double.tryParse(controllers['previousSemCGPA']!.text.trim()) ?? 0.0;
      final previousSemSGPA =
          double.tryParse(controllers['previousSemSGPA']!.text.trim()) ?? 0.0;

      // Validate required fields
      if (enrollmentNo.isEmpty ||
          email.isEmpty ||
          phone.isEmpty ||
          password.isEmpty ||
          name.isEmpty ||
          branch.isEmpty ||
          yearOfEnrollment == 0 ||
          classTenPercent == 0.0 ||
          classTwelvePercent == 0.0 ||
          previousSemCGPA == 0.0 ||
          previousSemSGPA == 0.0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please fill out all fields before submitting.',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: StyleGlobalVariables.primaryErrorColor,
          ),
        );
        return;
      }

      // Set loading state to true
      ref.read(loadingProvider.notifier).state = true;

      try {
        // Call the signup method in AuthNotifier with proper parameters
        await ref.read(authProvider.notifier).signup(
              enrollmentNo: enrollmentNo,
              email: email,
              phone: phone,
              password: password,
              name: name,
              branch: branch,
              yearOfEnrollment: yearOfEnrollment,
              classTenPercent: classTenPercent,
              classTwelvePercent: classTwelvePercent,
              previousSemCGPA: previousSemCGPA,
              previousSemSGPA: previousSemSGPA,
              certifications: ['http://example.cert.com'],
              resume: 'http://example.resume.com',
              // ref
              //     .watch(resumeProvider)
              //     .toString(), // Ensure `resume` is defined or passed correctly
              ref: ref,
            );
      } catch (e) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error during sign-up: $e',
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: StyleGlobalVariables.primaryErrorColor,
            ),
          );
        });
        // Show error message if sign-up fails
      } finally {
        // Reset loading state
        ref.read(loadingProvider.notifier).state = false;
      }
    }

    return MyScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Certifications:',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ) ??
                    const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                onPressed: () {
                  showCertificationFullScreenSheet(context: context, ref: ref);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.02),

          // Displaying Certifications
          Expanded(
            child: certificationList(ref: ref, context: context),
          ),

          // SignUp Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () => handleSignUp(
                        context: context,
                        ref: ref,
                      ),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Submit and Sign Up'),
            ),
          ),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.03),
          const CustomStepper(),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.01),
        ],
      ),
    );
  }

  Widget certificationList({
    required WidgetRef ref,
    required BuildContext context,
  }) {
    final List<Certification> certifications = ref.watch(certificationProvider);

    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        ref.read(certificationProvider.notifier).reorderCertification(
              oldIndex,
              newIndex,
            );
      },
      children: List.generate(certifications.length, (index) {
        final certification = certifications[index];
        final filePreview = certification.file;

        return Card(
          key: ValueKey(index), // Provide a unique key for each item
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: StyleGlobalVariables.screenWidth,
                height: StyleGlobalVariables.screenSizingReference * 0.05,
                child: filePreview is String
                    ? Center(
                        child: Text(
                          filePreview
                              .split('/')
                              .last, // Show file name if it's a string path
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : filePreview,
              ),
              ListTile(
                title: Text(
                  certification.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Issued by: ${certification.issuingOrganizationName}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Year of Completion: ${certification.yearOfCompletion}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit_rounded,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        showCertificationFullScreenSheet(
                          context: context,
                          ref: ref,
                          certificationToEdit: certifications[index],
                          indexToEdit: index,
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete_rounded, color: Colors.red),
                      onPressed: () {
                        ref
                            .read(certificationProvider.notifier)
                            .removeCertification(index);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> addCertification({
    required String certificateName,
    required String issuingOrganizationName,
    required String yearOfCompletion,
    required WidgetRef ref,
    required BuildContext context,
    required dynamic file,
  }) async {
    if (file != null) {
      ref.read(certificationProvider.notifier).addCertification(
            name: certificateName,
            file: file,
            issuingOrganizationName: issuingOrganizationName,
            yearOfCompletion: yearOfCompletion,
          );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No certificate file selected',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: StyleGlobalVariables.primaryErrorColor,
          ),
        );
      });
      debugPrint('No certificate file selected');
    }
  }

  Future<Widget> addCertificationAndShowBeforeSave({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final FilePickerService filePickerService = FilePickerService();

    final file = await filePickerService.pickFile(isPhoto: false);

    if (file != null) {
      if (file is Uint8List) {
        // Update web photo bytes provider
        return filePickerService.displayFile(
          ref: ref,
          isPhoto: false,
          height: StyleGlobalVariables.screenSizingReference * 0.2,
          width: StyleGlobalVariables.screenSizingReference * 0.2,
          webPhotoBytes: file,
          photo: null,
          webNotPhotoPath: null,
          notPhoto: null,
        );
      } else if (file is File) {
        return filePickerService.displayFile(
          ref: ref,
          isPhoto: false,
          height: StyleGlobalVariables.screenSizingReference * 0.2,
          width: StyleGlobalVariables.screenSizingReference * 0.2,
          webPhotoBytes: null,
          photo: file,
          webNotPhotoPath: null,
          notPhoto: file,
        );
      } else if (file is String) {
        return filePickerService.displayFile(
          ref: ref,
          isPhoto: false,
          height: StyleGlobalVariables.screenSizingReference * 0.2,
          width: StyleGlobalVariables.screenSizingReference * 0.2,
          webPhotoBytes: null,
          photo: null,
          webNotPhotoPath: file,
          notPhoto: null,
        );
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'No certificate file selected',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: StyleGlobalVariables.primaryErrorColor,
          ),
        );
      });
      debugPrint('No certificate file selected');
    }
    return const SizedBox(height: 0, width: 0);
  }

  Future<dynamic> showCertificationFullScreenSheet({
    required BuildContext context,
    required WidgetRef ref,
    Certification? certificationToEdit,
    int? indexToEdit, // Pass the index for editing
  }) {
    final TextEditingController certificationNameController =
        TextEditingController(text: certificationToEdit?.name ?? '');
    final TextEditingController issuingOrganizationNameController =
        TextEditingController(
            text: certificationToEdit?.issuingOrganizationName ?? '');
    final TextEditingController yearOfCompletionController =
        TextEditingController(
            text: certificationToEdit?.yearOfCompletion ?? '');

    // Initialize the provider with the existing file if editing
    if (certificationToEdit?.file != null) {
      ref.read(tempFilePreviewProvider.notifier).state =
          certificationToEdit!.file;
    }

    // Prefill with test data if in debug mode
    if (kDebugMode) {
      // Provide test data in debug mode
      certificationNameController.text =
          testData['certifications']![0].toString();
      issuingOrganizationNameController.text =
          testData['issuingOrganizationNameCertificate'].toString();
      yearOfCompletionController.text =
          testData['yearOfCompletionCertificate'].toString();
    }

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.95,
          child: Scaffold(
            appBar: AppBar(
              title: Text(certificationToEdit == null
                  ? 'Add Certification'
                  : 'Edit Certification'),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(
                    label: 'Certification Name',
                    hint: 'Certification Name',
                    controller: certificationNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the Certification Name.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Year/Date of Completion',
                    hint: 'Year/Date of Completion',
                    controller: yearOfCompletionController,
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the Year/Date of Completion";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: 'Issuing Organization',
                    hint: 'Issuing Organization',
                    controller: issuingOrganizationNameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the Issuing Organization";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final filePreview =
                          await addCertificationAndShowBeforeSave(
                        ref: ref,
                        context: context,
                      );
                      // Update the provider state to trigger UI rebuild
                      ref.read(tempFilePreviewProvider.notifier).state =
                          filePreview;
                    },
                    child: Text(certificationToEdit == null
                        ? 'Upload Certificate'
                        : 'Update Certificate'),
                  ),
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, ref, _) {
                      final filePreview = ref.watch(tempFilePreviewProvider);
                      return filePreview ?? const Text('No file uploaded');
                    },
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      final currentFile = ref.watch(tempFilePreviewProvider);
                      if (certificationNameController.text.isNotEmpty &&
                          yearOfCompletionController.text.isNotEmpty &&
                          issuingOrganizationNameController.text.isNotEmpty &&
                          currentFile != null) {
                        if (certificationToEdit == null) {
                          // Add new certification
                          await addCertification(
                            certificateName: certificationNameController.text,
                            ref: ref,
                            context: context,
                            issuingOrganizationName:
                                issuingOrganizationNameController.text,
                            yearOfCompletion: yearOfCompletionController.text,
                            file: currentFile,
                          );
                        } else {
                          // Edit existing certification
                          ref
                              .read(certificationProvider.notifier)
                              .editCertification(
                                index: indexToEdit!,
                                newName: certificationNameController.text,
                                newIssuingOrganizationName:
                                    issuingOrganizationNameController.text,
                                newYearOfCompletion:
                                    yearOfCompletionController.text,
                                newFile: currentFile, // Use provider value
                              );
                        }

                        certificationNameController.clear();
                        issuingOrganizationNameController.clear();
                        yearOfCompletionController.clear();

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pop(context);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please fill out all fields and upload the certificate file.',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: StyleGlobalVariables.primaryErrorColor,
                          ),
                        );
                      }
                    },
                    child:
                        Text(certificationToEdit == null ? 'Save' : 'Update'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
