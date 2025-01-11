import 'package:flutter/material.dart';
import 'package:tnp_rgpv_app/auth_module/components/sign_up_form_part_1.dart';
import 'package:tnp_rgpv_app/auth_module/components/sign_up_form_part_2.dart';
import 'package:tnp_rgpv_app/auth_module/components/sign_up_form_part_3.dart';
import 'package:tnp_rgpv_app/auth_module/components/sign_up_form_part_4.dart';
import 'package:tnp_rgpv_app/auth_module/screens/auth_screen.dart';

import 'package:tnp_rgpv_app/screens/home_screen.dart';
import 'package:tnp_rgpv_app/screens/interview_prep_screen.dart';
import 'package:tnp_rgpv_app/screens/main_screen.dart';
import 'package:tnp_rgpv_app/screens/question_format_screen.dart';
import 'package:tnp_rgpv_app/screens/question_screen.dart';

class AppScreenRoutes {
  // Auth Routes
  static const String auth = '/auth';

  // Sign-Up Routes
  static const String signUpFormPart1 = '/sign-up-form-part-1';
  static const String signUpFormPart2 = '/sign-up-form-part-2';
  static const String signUpFormPart3 = '/sign-up-form-part-3';
  static const String signUpFormPart4 = '/sign-up-form-part-4';

  // Main Screen Routes
  static const String main = '/main';
  static const String home = '/home';
  static const String notifications = '/notifications';
  static const String profile = '/profile';

  // Profile Screen Routes
  static const String editProfile = '/edit-profile';

  // Categories Screen Routes
  static const String interviewPrep = '/interview-prep';

  // Question Format Selection Routes
  static const String questionFormat = '/question-format';

  static const String questionAttempt = '/question-attempt';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    //  Use if needed.
    final args = settings.arguments;

    switch (settings.name) {
      // Auth Routes
      case auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());

      // Main Screen Routes
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      // Question Category Routes
      case interviewPrep:
        return MaterialPageRoute(builder: (_) => const InterviewPrepScreen());

      // Question Category Routes
      case questionFormat:
        return MaterialPageRoute(builder: (_) => const QuestionFormatScreen());

      case questionAttempt:
        // Ensure arguments are passed as a map and include the expected keys
        final Map<String, dynamic>? arguments = args as Map<String, dynamic>?;
        final bool resetTimer =
            arguments?['resetTimer'] ?? true; // Default to true
        return MaterialPageRoute(
          builder: (_) => CommonQuestionScreen(resetTimer: resetTimer),
        );

      // case notifications:
      //   return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      // case profile:
      //   return MaterialPageRoute(builder: (_) => const ProfileScreen());

      // case editProfile:
      //   return MaterialPageRoute(builder: (_) => const EditProfileScreen());

      // Sign-Up Routes
      case signUpFormPart1:
        return MaterialPageRoute(builder: (_) => const SignUpFormPart1());
      case signUpFormPart2:
        return MaterialPageRoute(builder: (_) => const SignUpFormPart2());
      case signUpFormPart3:
        return MaterialPageRoute(builder: (_) => const SignUpFormPart3());
      case signUpFormPart4:
        return MaterialPageRoute(builder: (_) => const SignUpFormPart4());

      // Default to handle errorenous navigation stack.
      default:
        return _errorRoute();
    }
  }

  // Default route to handle errorenous navigation stack with a simple screen showing error.
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('No route defined for this path'),
        ),
      ),
    );
  }
}
