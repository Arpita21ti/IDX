import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a model for the certification
class Certification {
  final String name;
  final String issuingOrganizationName;
  final String yearOfCompletion;
  final dynamic file;

  Certification({
    required this.name,
    required this.file,
    required this.issuingOrganizationName,
    required this.yearOfCompletion,
  });
}

// Define the notifier to manage the list of certifications
class CertificationNotifier extends StateNotifier<List<Certification>> {
  CertificationNotifier() : super([]);

  // Add a new certification
  void addCertification({
    required String name,
    required dynamic file,
    required String issuingOrganizationName,
    required String yearOfCompletion,
  }) {
    state = [
      ...state,
      Certification(
        name: name,
        file: file,
        issuingOrganizationName: issuingOrganizationName,
        yearOfCompletion: yearOfCompletion,
      ),
    ];
  }

  // Update specific fields of an existing certification
  void editCertification({
    required int index,
    String? newName,
    String? newIssuingOrganizationName,
    String? newYearOfCompletion,
    dynamic newFile,
  }) {
    if (index < 0 || index >= state.length) {
      throw ArgumentError("Invalid certification index");
    }

    final current = state[index];
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Certification(
            name: newName ?? current.name, // Keep existing name if not updated
            file: newFile ?? current.file, // Keep existing file if not updated
            issuingOrganizationName: newIssuingOrganizationName ??
                current.issuingOrganizationName, // Keep existing org name
            yearOfCompletion: newYearOfCompletion ??
                current.yearOfCompletion, // Keep existing year
          )
        else
          state[i],
    ];
  }

  // Remove a certification
  void removeCertification(int index) {
    if (index < 0 || index >= state.length) {
      throw ArgumentError("Invalid certification index");
    }
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }

  // Reorder certifications
  void reorderCertification(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = state[oldIndex];
    final updated = List.of(state);
    updated.removeAt(oldIndex);
    updated.insert(newIndex, item);
    state = updated;
  }
}

final certificationProvider =
    StateNotifierProvider<CertificationNotifier, List<Certification>>(
        (ref) => CertificationNotifier());
