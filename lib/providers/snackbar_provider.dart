import 'package:flutter_riverpod/flutter_riverpod.dart';

final snackBarProvider = StateNotifierProvider<SnackBarNotifier, SnackBarState>(
  (ref) => SnackBarNotifier(),
);

class SnackBarState {
  final String? title;
  final String message;

  SnackBarState({this.title, required this.message});
}

class SnackBarNotifier extends StateNotifier<SnackBarState> {
  SnackBarNotifier() : super(SnackBarState(message: ''));

  void showSnackBar(String? title, String message) {
    state = SnackBarState(title: title, message: message);
  }

  void clearSnackBar() {
    state = SnackBarState(message: '');
  }
}
