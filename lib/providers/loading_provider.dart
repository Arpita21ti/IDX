import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks whether the authentication form is in a loading state
final loadingProvider = StateProvider<bool>((ref) => false);
