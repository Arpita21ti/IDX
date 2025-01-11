import 'package:flutter/material.dart';
import 'package:tnp_rgpv_app/global_styles.dart';

class MyScaffold extends StatelessWidget {
  final Widget body;
  final bool showAppBar;
  final String appBarTitle;
  final List<Widget>? actions;
  const MyScaffold({
    super.key,
    required this.body,
    this.showAppBar = true,
    this.appBarTitle = "",
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              // TODO: Use if want the RGPV logo in the app bar.
              leading: const Icon(Icons.flash_on, color: Colors.blue),
              title: appBarTitle.isEmpty
                  ? const Text('TNP RGPV')
                  : Text(appBarTitle),

              actions: actions,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: StyleGlobalVariables.screenSizingReference * 0.02,
          ),
          child: body,
        ),
      ),
    );
  }
}
