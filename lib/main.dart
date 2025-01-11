import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/home_module/screens/home_screen.dart';
import 'package:tnp_rgpv_app/providers/snackbar_provider.dart';
import 'package:tnp_rgpv_app/providers/theme_provider.dart';
import 'package:tnp_rgpv_app/routes.dart';
import 'package:tnp_rgpv_app/screens/main_screen.dart';
import 'package:tnp_rgpv_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the status bar and navigation bar colors
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.red.shade400, // Color of the status bar (top)
      statusBarIconBrightness:
          Brightness.light, // Status bar icons color (light or dark)
      systemNavigationBarColor:
          Colors.redAccent, // Color of the navigation bar (bottom)
      systemNavigationBarIconBrightness:
          Brightness.light, // Navigation bar icons color (light or dark)
    ),
  );

  await dotenv.load(fileName: "assets/.env");

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    StyleGlobalVariables.setContext(context);
    return Consumer(
      builder: (context, ref, child) {
        // Access the current theme
        final currentTheme = ref.watch(themeProvider);
        final snackBarState = ref.watch(snackBarProvider);

        if (snackBarState.message.isNotEmpty) {
          Future.delayed(Duration.zero, () {
            scaffoldMessengerKey.currentState?.showSnackBar(
              SnackBar(
                padding: const EdgeInsets.all(8.0),
                content: (snackBarState.title != null &&
                        snackBarState.title!.isNotEmpty)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snackBarState.title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(snackBarState.message),
                        ],
                      )
                    : Text(snackBarState.message),
              ),
            );
            ref.read(snackBarProvider.notifier).clearSnackBar();
          });
        }

        return MaterialApp(
          title: 'Flutter Demo',
          scaffoldMessengerKey: scaffoldMessengerKey,

          // Theme Data set in the lib/models/theme_model.dart file.
          theme: currentTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppScreenRoutes.generateRoute, // Use onGenerateRoute
          home: const MainScreen(),
        );
      },
    );
  }
}
