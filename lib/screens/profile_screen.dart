import 'package:flutter/material.dart';
import 'package:tnp_rgpv_app/global_widgets/my_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyScaffold(
      showAppBar: false,
      body: Center(
        child: Text('Profile Screen.'),
      ),
    );
  }
}
