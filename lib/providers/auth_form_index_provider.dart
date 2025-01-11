import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Manages the current form index for the authentication screen
final authFormIndexProvider = StateProvider<int>((ref) => 0);
