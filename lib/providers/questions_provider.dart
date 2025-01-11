import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/global_services/api_services.dart';
import 'package:tnp_rgpv_app/models/question.dart';
import 'question_filter_provider.dart';

// StateNotifier to manage the fetching of questions based on filters
class QuestionsNotifier extends StateNotifier<AsyncValue<List<Question>>> {
  final GlobalApiService apiService;

  QuestionsNotifier({required this.apiService}) : super(const AsyncLoading());

  // Fetch questions based on the current filters
  Future<void> fetchQuestions(WidgetRef ref) async {
    try {
      state = const AsyncLoading();

      // Get the current filters from the questionFilterProvider
      final filters = ref.read(questionFilterProvider);

      // Prepare the request body with all filters (category, subcategory, etc.)
      final filterParams = {
        'subcategory': filters.subcategory,
        'tags': filters.tags,
      };

      // Prepare headers
      final headers = {
        'difficulty': filters.difficulty,
        'type': filters.type,
      };

      // Make the request to fetch questions
      final response = await apiService.makeRequest(
        endpoint:
            '/questions/${filters.category}', // Adjusted for category in URL
        method: 'POST', // Using POST to send the request body
        data: filterParams, // Pass filters in the request body
        headers: headers, // Passing headers for auth
        ref: ref,
      );

      // Parse the fetched questions
      final List<Question> questions = [];
      for (var questionData in response.data) {
        questions.add(Question.fromJson(questionData));
      }

      state = AsyncData(questions); // Update state with the fetched questions
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }
}

// Provider for fetching questions asynchronously
final questionsProvider =
    StateNotifierProvider<QuestionsNotifier, AsyncValue<List<Question>>>(
  (ref) => QuestionsNotifier(apiService: GlobalApiService()),
);
