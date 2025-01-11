import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 9,
                  child: Image(
                    image: AssetImage('assets/rgpv_logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                Spacer(flex: 1),
                Text(
                  'TNP RGPV',
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          buildListTile(
            icon: Icons.home,
            title: 'Home',
            onTap: () {
              // Handle Home navigation
              Navigator.pop(context);
            },
          ),
          buildListTile(
            icon: Icons.info,
            title: 'About',
            onTap: () {
              // Handle About navigation
              Navigator.pop(context);
            },
          ),
          buildListTile(
            icon: Icons.settings,
            title: 'Settings',
            onTap: () {
              // Handle Settings navigation
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
