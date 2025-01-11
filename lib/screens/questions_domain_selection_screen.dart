import 'package:flutter/material.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/global_widgets/my_scaffold.dart';
import 'package:tnp_rgpv_app/routes.dart';

class QuestionDomainSelectionScreen extends StatelessWidget {
  const QuestionDomainSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        "title": "Interview Prep",
        "icon": Icons.school,
        "color": Colors.blue,
        "onTap": () {
          debugPrint("Tapped on Interview Prep");
          Navigator.pushNamed(context, AppScreenRoutes.interviewPrep);
        }
      },
      {
        "title": "Aptitude Quiz",
        "icon": Icons.quiz,
        "color": Colors.green,
        "onTap": () {
          debugPrint("Tapped on Aptitude Quiz");
          Navigator.pushNamed(context, AppScreenRoutes.questionFormat);
        }
      },
      {
        "title": "PYQs",
        "icon": Icons.history_edu,
        "color": Colors.orange,
        "onTap": () {
          debugPrint("Tapped on PYQs");
        }
      },
      {
        "title": "Company Ques",
        "icon": Icons.business,
        "color": Colors.purple,
        "onTap": () {
          debugPrint("Tapped on Company Ques");
        }
      },
    ];

    return MyScaffold(
      showAppBar: false,
      body: Column(
        children: [
          Text(
            'Explore More',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ) ??
                const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.01),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 16, // Spacing between columns
                mainAxisSpacing: 16, // Spacing between rows
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return _buildCategoryTile(
                  title: category["title"],
                  icon: category["icon"],
                  color: category["color"],
                  onTap: category["onTap"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTile({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      shadowColor: Colors.grey.shade400,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.8),
                color.withValues(alpha: 0.5)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
