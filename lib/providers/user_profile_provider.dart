// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/user_profile.dart';

// // Manages user profile state
// final userProfileProvider =
//     StateNotifierProvider<UserProfileNotifier, UserProfile?>((ref) {
//   return UserProfileNotifier();
// });

// class UserProfileNotifier extends StateNotifier<UserProfile?> {
//   UserProfileNotifier() : super(null);

//   Future<void> loadUserProfile() async {
//     // Fetch or simulate API call to get user data
//     await Future.delayed(Duration(seconds: 2));
//     state = UserProfile(name: "John Doe", email: "john.doe@example.com");
//   }
// }
