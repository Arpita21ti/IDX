import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/routes.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(
        context,
        AppScreenRoutes.auth,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            kIsWeb
                ? Image(
                    image: const AssetImage('rgpv_logo.png'),
                    height: StyleGlobalVariables.screenSizingReference * 0.3,
                    width: StyleGlobalVariables.screenSizingReference * 0.3,
                  )
                : Image(
                    image: const AssetImage('assets/rgpv_logo.png'),
                    fit: BoxFit.contain,
                    height: StyleGlobalVariables.screenSizingReference * 0.3,
                    width: StyleGlobalVariables.screenSizingReference * 0.3,
                  ),
            SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.01),
            Text(
              'Training And Placement Department',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ) ??
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text('RGPV Bhopal',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ) ??
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
