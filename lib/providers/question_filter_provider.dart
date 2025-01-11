import 'package:flutter_riverpod/flutter_riverpod.dart';

// Class to hold filter data
class QuestionFilters {
  final String? category;
  final List<String>? subcategory;
  final String? difficulty;
  final String? type;
  final List<String>? tags;

  QuestionFilters({
    this.category,
    this.subcategory,
    this.difficulty,
    this.type,
    this.tags = const [],
  });

  // You can add methods to copy the filter with updated values for immutability
  QuestionFilters copyWith({
    String? category,
    List<String>? subcategory,
    String? difficulty,
    String? type,
    List<String>? tags,
  }) {
    return QuestionFilters(
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      difficulty: difficulty ?? this.difficulty,
      type: type ?? this.type,
      tags: tags ?? this.tags,
    );
  }
}

// StateNotifier to manage the filter state
class QuestionFilterNotifier extends StateNotifier<QuestionFilters> {
  QuestionFilterNotifier() : super(QuestionFilters());

  void updateCategory(String? category) {
    state = state.copyWith(category: category);
  }

  void updateSubcategory(List<String> subcategory) {
    state = state.copyWith(subcategory: subcategory);
  }

  void updateDifficulty(String? difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void updateType(String? type) {
    state = state.copyWith(type: type);
  }

  void updateTags(List<String> tags) {
    state = state.copyWith(tags: tags);
  }
}

// Provider to expose the filter state
final questionFilterProvider =
    StateNotifierProvider<QuestionFilterNotifier, QuestionFilters>(
  (ref) => QuestionFilterNotifier(),
);
