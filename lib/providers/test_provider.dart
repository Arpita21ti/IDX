import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/global_services/api_services.dart';

// Providers for lists of options
final domainProvider = StateProvider<List<String>>((ref) => []);
final subDomainProvider = StateProvider<List<String>>((ref) => []);
final nicheProvider = StateProvider<List<String>>((ref) => []);
final difficultyProvider = StateProvider<List<String>>((ref) => []);
final timePeriodProvider = StateProvider<List<String>>((ref) => []);
final questionFormatProvider = StateProvider<List<String>>((ref) => []);

// Providers for selected values
final selectedDomainProvider = StateProvider<String>((ref) => 'Option 1');
final selectedSubDomainProvider = StateProvider<String>((ref) => 'Option 1');
final selectedNicheProvider = StateProvider<String>((ref) => 'Option 1');
final selectedDifficultyProvider = StateProvider<String>((ref) => 'Option 1');
final selectedTimePeriodProvider = StateProvider<String>((ref) => 'Option 1');
final selectedQuestionFormatProvider = StateProvider<String>((ref) => '');

final hierarchyProvider =
    StateNotifierProvider<HierarchyNotifier, HierarchyState>((ref) {
  return HierarchyNotifier(ref.read);
});

class HierarchyState {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic>? data;

  HierarchyState({
    this.isLoading = true,
    this.errorMessage,
    this.data,
  });
}

class HierarchyNotifier extends StateNotifier<HierarchyState> {
  final Reader read;

  HierarchyNotifier(this.read) : super(HierarchyState()) {
    _fetchHierarchyData();
  }

  Future<void> _fetchHierarchyData({
    required WidgetRef ref,
  }) async {
    try {
      final GlobalApiService apiService = GlobalApiService();
      final response = await apiService.makeRequest(
        endpoint: '/questions/hierarchy',
        method: 'GET',
        data: {},
      );

      state = HierarchyState(
        isLoading: false,
        data: response.data,
      );
    } catch (e) {
      state = HierarchyState(
        isLoading: false,
        errorMessage: 'Failed to load data: $e',
      );
    }
  }
}
