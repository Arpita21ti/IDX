// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tnp_rgpv_app/global_services/api_services.dart';
// import 'package:tnp_rgpv_app/global_styles.dart';
// import 'package:tnp_rgpv_app/global_widgets/my_scaffold.dart';
// import 'package:tnp_rgpv_app/providers/test_provider.dart';

// class TestHomeScreen extends ConsumerWidget {
//   const TestHomeScreen({super.key});

// // Fetching the entire hierarchy from the backend
//   Future<void> fetchHierarchyData(WidgetRef ref) async {
//     final GlobalApiService apiService = GlobalApiService();

//     final response = await apiService.makeRequest(
//       endpoint: '/questions/hierarchy',
//       method: 'GET',
//       data: {},
//       ref: ref,
//     );

//     // Decode the response body if it's a JSON response
//     final responseBody = response.data;

//     // Parse the response and store in the respective providers
//     ref.read(domainProvider.notifier).state =
//         List<String>.from(responseBody["domains"]);
//     ref.read(subDomainProvider.notifier).state =
//         List<String>.from(responseBody["subdomains"]);
//     ref.read(nicheProvider.notifier).state =
//         List<String>.from(responseBody["niches"]);
//     ref.read(difficultyProvider.notifier).state =
//         List<String>.from(responseBody["difficulty_levels"]);
//     ref.read(timePeriodProvider.notifier).state =
//         List<String>.from(responseBody["time_periods"]);
//     ref.read(questionTypeProvider.notifier).state =
//         List<String>.from(responseBody["question_types"]);
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Sample dropdown items and question types
//     final dropdownItems = ['Option 1', 'Option 2', 'Option 3'];
//     final questionTypes = [
//       'Multiple Choice Questions',
//       'Fill in the Blanks',
//       'Text Based',
//       'True/False',
//     ];

//     // Read providers
//     final selectedDomain = ref.watch(selectedDomainProvider);
//     final selectedSubDomain = ref.watch(selectedSubDomainProvider);
//     final selectedNiche = ref.watch(selectedNicheProvider);
//     final selectedDifficulty = ref.watch(selectedDifficultyProvider);
//     final selectedTimePeriod = ref.watch(selectedTimePeriodProvider);
//     final selectedQuestionTypes = ref.watch(questionTypeProvider);

//     return MyScaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           spacing: StyleGlobalVariables.screenSizingReference * 0.02,
//           children: [
//             Text(
//               'Test Configuration',
//               style: Theme.of(context).textTheme.titleLarge ??
//                   const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             _buildDropdown(
//               context: context,
//               label: 'Domain',
//               value: selectedDomain,
//               items: dropdownItems,
//               onChanged: (value) {
//                 if (value != null) {
//                   ref.read(selectedDomainProvider.notifier).state = value;
//                 }
//               },
//             ),
//             _buildDropdown(
//               context: context,
//               label: 'Sub Domain',
//               value: selectedSubDomain,
//               items: dropdownItems,
//               onChanged: (value) {
//                 if (value != null) {
//                   ref.read(selectedSubDomainProvider.notifier).state = value;
//                 }
//               },
//             ),
//             _buildDropdown(
//               context: context,
//               label: 'Specific Niche',
//               value: selectedNiche,
//               items: dropdownItems,
//               onChanged: (value) {
//                 if (value != null) {
//                   ref.read(selectedNicheProvider.notifier).state = value;
//                 }
//               },
//             ),
//             _buildDropdown(
//               context: context,
//               label: 'Difficulty Level',
//               value: selectedDifficulty,
//               items: dropdownItems,
//               onChanged: (value) {
//                 if (value != null) {
//                   ref.read(selectedDifficultyProvider.notifier).state = value;
//                 }
//               },
//             ),
//             _buildDropdown(
//               context: context,
//               label: 'Time Period',
//               value: selectedTimePeriod,
//               items: dropdownItems,
//               onChanged: (value) {
//                 if (value != null) {
//                   ref.read(selectedTimePeriodProvider.notifier).state = value;
//                 }
//               },
//             ),
//             const Text(
//               'Question Types',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             ...questionTypes.map(
//               (type) => RadioListTile<String>(
//                 title: Text(type),
//                 value: type,
//                 groupValue: ref.watch(questionTypeProvider),
//                 onChanged: (selected) {
//                   if (selected != null) {
//                     ref.read(questionTypeProvider.notifier).state = selected;
//                   }
//                 },
//               ),
//             ),
//             const Card(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text(
//                   'Test Instructions',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 48),
//               ),
//               onPressed: () {
//                 // Placeholder for "Let's Go" action
//                 print('Start Test with configuration:');
//                 print('Domain: $selectedDomain');
//                 print('Sub Domain: $selectedSubDomain');
//                 print('Specific Niche: $selectedNiche');
//                 print('Difficulty Level: $selectedDifficulty');
//                 print('Time Period: $selectedTimePeriod');
//                 print('Question Types: $selectedQuestionTypes');
//               },
//               child: const Text("Let's Go"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown({
//     required BuildContext context,
//     required String label,
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       spacing: StyleGlobalVariables.screenSizingReference * 0.01,
//       children: [
//         Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//         DropdownButtonFormField<String>(
//           value: value,
//           items: items
//               .map((item) => DropdownMenuItem(value: item, child: Text(item)))
//               .toList(),
//           onChanged: onChanged,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/global_services/api_services.dart';
import 'package:tnp_rgpv_app/global_widgets/my_scaffold.dart';
import 'package:tnp_rgpv_app/providers/test_provider.dart';

class TestHomeScreen extends ConsumerStatefulWidget {
  const TestHomeScreen({super.key});

  @override
  ConsumerState<TestHomeScreen> createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends ConsumerState<TestHomeScreen> {
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch data when the screen loads
    _fetchHierarchyData();
  }

  // Fetching the entire hierarchy from the backend
  Future<void> _fetchHierarchyData() async {
    final GlobalApiService apiService = GlobalApiService();

    try {
      final response = await apiService.makeRequest(
        endpoint: '/questions/hierarchy',
        method: 'GET',
        data: {},
        ref: ref,
      );

      // Decode the response body if it's a JSON response
      final responseBody = response.data;

      // Parse and update the providers with the respective data
      ref.read(domainProvider.notifier).state = List<Map<String, dynamic>>.from(
        responseBody["domains"],
      ).map((domain) => domain["domainName"].toString()).toList();

      ref.read(subDomainProvider.notifier).state =
          List<Map<String, dynamic>>.from(
        responseBody["subdomains"],
      ).map((subdomain) => subdomain["subDomainName"].toString()).toList();

      ref.read(nicheProvider.notifier).state = List<Map<String, dynamic>>.from(
        responseBody["niches"],
      ).map((niche) => niche["nicheName"].toString()).toList();

      ref.read(difficultyProvider.notifier).state =
          List<Map<String, dynamic>>.from(
        responseBody["difficulty_levels"],
      ).map((difficulty) => difficulty["difficultyLevel"].toString()).toList();

      ref.read(questionFormatProvider.notifier).state =
          List<Map<String, dynamic>>.from(
        responseBody["formats"],
      ).map((format) => format["format"].toString()).toList();

      // Set default selected values for each provider
      _setDefaultSelectedValues();

      // Set loading state to false
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load data: $e';
      });
    }
  }

  void _setDefaultSelectedValues() {
    final domainList = ref.read(domainProvider);
    final subDomainList = ref.read(subDomainProvider);
    final nicheList = ref.read(nicheProvider);
    final difficultyList = ref.read(difficultyProvider);
    final questionFormatList = ref.read(questionFormatProvider);

    if (domainList.isNotEmpty) {
      ref.read(selectedDomainProvider.notifier).state = domainList.first;
    }
    if (subDomainList.isNotEmpty) {
      ref.read(selectedSubDomainProvider.notifier).state = subDomainList.first;
    }
    if (nicheList.isNotEmpty) {
      ref.read(selectedNicheProvider.notifier).state = nicheList.first;
    }
    if (difficultyList.isNotEmpty) {
      ref.read(selectedDifficultyProvider.notifier).state =
          difficultyList.first;
    }
    if (questionFormatList.isNotEmpty) {
      ref.read(selectedQuestionFormatProvider.notifier).state =
          questionFormatList.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Read providers
    final domainList = ref.watch(domainProvider);
    final subDomainList = ref.watch(subDomainProvider);
    final nicheList = ref.watch(nicheProvider);
    final difficultyList = ref.watch(difficultyProvider);
    final timePeriodList = ref.watch(timePeriodProvider);
    final questionFormatList = ref.watch(questionFormatProvider);

    final selectedDomain = ref.watch(selectedDomainProvider);
    final selectedSubDomain = ref.watch(selectedSubDomainProvider);
    final selectedNiche = ref.watch(selectedNicheProvider);
    final selectedDifficulty = ref.watch(selectedDifficultyProvider);
    final selectedTimePeriod = ref.watch(selectedTimePeriodProvider);
    final selectedQuestionTypes = ref.watch(selectedQuestionFormatProvider);

    if (_isLoading) {
      // Show a loading indicator while fetching data
      return const MyScaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage.isNotEmpty) {
      // Show an error message if data fetching fails
      return MyScaffold(
        body: Center(child: Text(_errorMessage)),
      );
    }

    return MyScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Test Configuration',
              style: Theme.of(context).textTheme.titleLarge ??
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildDropdown(
              context: context,
              label: 'Domain',
              value: selectedDomain,
              items: domainList,
              onChanged: (value) {
                if (value != null) {
                  ref.read(selectedDomainProvider.notifier).state = value;
                }
              },
            ),
            _buildDropdown(
              context: context,
              label: 'Sub Domain',
              value: selectedSubDomain,
              items: subDomainList,
              onChanged: (value) {
                if (value != null) {
                  ref.read(selectedSubDomainProvider.notifier).state = value;
                }
              },
            ),
            _buildDropdown(
              context: context,
              label: 'Specific Niche',
              value: selectedNiche,
              items: nicheList,
              onChanged: (value) {
                if (value != null) {
                  ref.read(selectedNicheProvider.notifier).state = value;
                }
              },
            ),
            _buildDropdown(
              context: context,
              label: 'Difficulty Level',
              value: selectedDifficulty,
              items: difficultyList,
              onChanged: (value) {
                if (value != null) {
                  ref.read(selectedDifficultyProvider.notifier).state = value;
                }
              },
            ),
            _buildDropdown(
              context: context,
              label: 'Time Period',
              value: selectedTimePeriod,
              items: timePeriodList,
              onChanged: (value) {
                if (value != null) {
                  ref.read(selectedTimePeriodProvider.notifier).state = value;
                }
              },
            ),
            const Text(
              'Question Types',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...questionFormatList.map(
              (type) => RadioListTile<String>(
                title: Text(type),
                value: type,
                groupValue: selectedQuestionTypes,
                onChanged: (selected) {
                  if (selected != null) {
                    ref.read(selectedQuestionFormatProvider.notifier).state =
                        selected;
                  }
                },
              ),
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Test Instructions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                // Placeholder for "Let's Go" action
                print('Start Test with configuration:');
                print('Domain: $selectedDomain');
                print('Sub Domain: $selectedSubDomain');
                print('Specific Niche: $selectedNiche');
                print('Difficulty Level: $selectedDifficulty');
                print('Time Period: $selectedTimePeriod');
                print('Question Types: $selectedQuestionTypes');
              },
              child: const Text("Let's Go"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required BuildContext context,
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }
}
