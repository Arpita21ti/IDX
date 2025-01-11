import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/auth_module/components/custom_stepper.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/global_widgets/my_scaffold.dart';
import 'package:tnp_rgpv_app/global_widgets/text_field.dart';
import 'package:tnp_rgpv_app/providers/auth_form_providers.dart';
import 'package:tnp_rgpv_app/providers/sign_up_form_stepper_provider.dart';
import 'package:tnp_rgpv_app/routes.dart';

class SignUpFormPart2 extends ConsumerWidget {
  const SignUpFormPart2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branches = [
      "Computer Science",
      "Information Technology",
      "Electronics",
      "Mechanical",
      "Civil",
      "Electrical",
      "Chemical",
      "Aerospace",
      "Biotechnology",
      "Automobile"
    ];

    final years = ["1", "2", "3", "4"];

    final selectedBranch = ref.watch(selectedBranchProvider);
    final selectedYear = ref.watch(selectedYearProvider);
    final formControllers = ref.watch(formControllersProvider);

    // Access form controller values
    final nameController = formControllers['name']!;
    final sgpaController = formControllers['previousSemSGPA']!;
    final cgpaController = formControllers['previousSemCGPA']!;
    final classTenPercentController = formControllers['classTenPercent']!;
    final classTwelvePercentController = formControllers['classTwelvePercent']!;

    // Trigger autofill in debug mode
    if (kDebugMode) {
      ref
          .read(formControllersProvider.notifier)
          .autofillTestDataSignUpFormPart2();
    }

    final GlobalKey<FormState> signUpFormPart2Key = GlobalKey<FormState>();

    // Optimized rendering: Only scrollable when screen size is large enough
    final isSmallScreen = StyleGlobalVariables.screenSizingRatio <= 1.2;
    final signUpForm = buildSignUpFormPart2(
      signUpFormPart2Key,
      nameController,
      classTenPercentController,
      selectedBranch,
      branches,
      selectedYear,
      years,
      classTwelvePercentController,
      cgpaController,
      sgpaController,
      context,
      ref,
    );

    return MyScaffold(
      body:
          isSmallScreen ? signUpForm : SingleChildScrollView(child: signUpForm),
    );
  }

  Form buildSignUpFormPart2(
    GlobalKey<FormState> signUpFormPart2Key,
    TextEditingController nameController,
    TextEditingController classTenPercentController,
    String selectedBranch,
    List<String> branches,
    String selectedYear,
    List<String> years,
    TextEditingController classTwelvePercentController,
    TextEditingController cgpaController,
    TextEditingController sgpaController,
    BuildContext context,
    WidgetRef ref,
  ) {
    return Form(
      key: signUpFormPart2Key,
      child: Column(
        children: [
          CustomTextField(
            label: "Name",
            hint: "Your Name",
            controller: nameController,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your Name";
              }
              return null;
            },
          ),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.02),

          // Branch Dropdown
          _buildDropdown<String>(
            label: "Branch",
            value: selectedBranch,
            items: branches,
            onChanged: (value) {
              ref
                  .read(selectedBranchProvider.notifier)
                  .update((state) => value!);
            },
            validator: (value) => value == null || value.isEmpty
                ? "Please select a branch"
                : null,
          ),

          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.02),

          // Year Dropdown
          _buildDropdown<String>(
            label: "Year",
            value: selectedYear,
            items: years,
            onChanged: (value) {
              ref.read(selectedYearProvider.notifier).update((state) => value!);
            },
            validator: (value) =>
                value == null || value.isEmpty ? "Please select a year" : null,
          ),

          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.02),

          // Class 10th %
          CustomTextField(
            label: "Class 10th %",
            hint: "Your Class 10th %",
            controller: classTenPercentController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your Class 10th percentage";
              }
              return null;
            },
          ),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.02),

          // Class 12th %
          CustomTextField(
            label: "Class 12th %",
            hint: "Your Class 12th %",
            controller: classTwelvePercentController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your Class 12th percentage";
              }
              return null;
            },
          ),

          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.02),

          // CGPA
          CustomTextField(
            label: "CGPA",
            hint: "Your Previous Year CGPA",
            controller: cgpaController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your CGPA";
              }
              return null;
            },
          ),

          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.02),

          // SGPA
          CustomTextField(
            label: "SGPA",
            hint: "Your Previous Semister SGPA",
            controller: sgpaController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your SGPA";
              }
              return null;
            },
          ),

          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.03),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (signUpFormPart2Key.currentState?.validate() ?? false) {
                  ref
                      .read(stepperProvider.notifier)
                      .setStep(3); // Move to the next step

                  Navigator.pushNamed(
                    context,
                    AppScreenRoutes.signUpFormPart3,
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
    );
  }

  // Helper method for building dropdowns to reduce redundancy
  DropdownButtonFormField<T> _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    required String? Function(T?) validator,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
