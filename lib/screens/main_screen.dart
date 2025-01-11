import 'package:flutter/material.dart';
import 'package:tnp_rgpv_app/global_widgets/drawer.dart';
import 'package:tnp_rgpv_app/home_module/screens/home_screen.dart';
import 'package:tnp_rgpv_app/screens/questions_domain_selection_screen.dart';
import 'package:tnp_rgpv_app/screens/home_screen.dart';
import 'package:tnp_rgpv_app/screens/profile_screen.dart';
import 'package:tnp_rgpv_app/test_module/screens/test_screen_home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PageController _pageViewController = PageController();

  int _currentPage = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const HomeScreen(),
    const QuestionDomainSelectionScreen(),
    const ProfileScreen(),
    const TestHomeScreen(),
  ];

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: SafeArea(
        child: PageView.builder(
          controller: _pageViewController,
          itemCount: _screens.length,
          onPageChanged: (newPageIndex) {
            if (!mounted) return;

            setState(() {
              _currentPage = newPageIndex;
            });
          },
          itemBuilder: (context, index) {
            return _screens[index];
          },
          pageSnapping: true,
          physics: const ClampingScrollPhysics(),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey))),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Practice'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), label: 'Certificates'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          _updateCurrentPageIndex(index);
        },
      ),
    );
  }

  void _updateCurrentPageIndex(int index) {
    _currentPage = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
