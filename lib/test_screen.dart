import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/models/theme_model.dart';
import 'package:tnp_rgpv_app/providers/theme_provider.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider); // Watch for theme changes

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Customization'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
          children: [
            ElevatedButton(
              onPressed: () => ref
                  .read(themeProvider.notifier)
                  .setTheme(lightTheme, 'light'),
              child: const Text('Switch to Light Theme'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  ref.read(themeProvider.notifier).setTheme(darkTheme, 'dark'),
              child: const Text('Switch to Dark Theme'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => ref
                  .read(themeProvider.notifier)
                  .setTheme(customTheme(Colors.white), 'custom'),
              child: const Text('Switch to Custom Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
