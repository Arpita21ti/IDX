import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/global_widgets/my_scaffold.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MyScaffold(
      appBarTitle: 'Dashboard',
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {}, // Placeholder for notifications
        ),
      ],

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            _buildProfileCard(),
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: StyleGlobalVariables.screenSizingReference * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildQuickActions(),
            Text(
              'Performance Metrics',
              style: TextStyle(
                fontSize: StyleGlobalVariables.screenSizingReference * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildPerformanceMetrics(),
            Text(
              'Social Media Channels',
              style: TextStyle(
                fontSize: StyleGlobalVariables.screenSizingReference * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildSocialHandles(),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      // color: Colors.amber,
      child: Row(
        spacing: 16,
        children: [
          CircleAvatar(
            radius: StyleGlobalVariables.screenSizingReference * 0.05,
            backgroundImage: const AssetImage('assets/rgpv_logo.png'),
          ),

          // TODO: Update to use Profile provider.

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Michael Thompson',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('EN2021CS1032'),
                Text('Computer Science & Engineering'),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: LinearProgressIndicator(
                    color: StyleGlobalVariables.primaryColor,
                    value: 0.85,
                  ),
                ),
                SizedBox(height: 4),
                Text('Profile Completion: 85%'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildQuickAction(icon: Icons.edit, label: 'Practice', onTap: () {}),
        _buildQuickAction(icon: Icons.work, label: 'Jobs', onTap: () {}),
        _buildQuickAction(
            icon: Icons.school, label: 'Certificates', onTap: () {}),
        _buildQuickAction(icon: Icons.person, label: 'Profile', onTap: () {}),
      ],
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(12),
          child: InkWell(
            onTap: onTap,
            child: Icon(
              icon,
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildPerformanceMetrics() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = constraints.maxWidth > 600 ? 4 : 2;
        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: columns == 4
                ? (constraints.maxWidth / columns + 70) / 100
                : (constraints.maxWidth / columns) / 100,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _MetricTile(label: 'CGPA', value: '8.92'),
            _MetricTile(label: 'Current SGPA', value: '9.1'),
            _MetricTile(label: 'Practice Score', value: '85%'),
            _MetricTile(label: 'College Rank', value: '#12'),
          ],
        );
      },
    );
  }

  Widget _buildSocialHandles() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = constraints.maxWidth > 600 ? 4 : 2;
        return GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: columns == 4
                ? (constraints.maxWidth / columns + 70) / 100
                : (constraints.maxWidth / columns) / 100,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _SocialHandlesTile(
              label: 'Facebook',
              value: '245K Followers',
              icon: Icons.facebook_rounded,
            ),
            _SocialHandlesTile(
              label: 'Instagram',
              value: '0.7K Followers',
              icon: Icons.abc,
            ),
            _SocialHandlesTile(
              label: 'LinkedIn',
              value: '5K Followers',
              icon: Icons.abc,
            ),
            // _SocialHandlesTile(label: 'College Rank', value: '#12', icon: Icons.abc,),
          ],
        );
      },
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;

  const _MetricTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}

class _SocialHandlesTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SocialHandlesTile(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          Icon(icon, size: 24),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
