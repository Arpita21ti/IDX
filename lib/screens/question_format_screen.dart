import 'package:flutter/material.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/global_widgets/my_scaffold.dart';
import 'package:tnp_rgpv_app/routes.dart';

class QuestionFormatScreen extends StatelessWidget {
  const QuestionFormatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> questionFormats = [
      {
        "title": "Text-based Questions",
        "icon": Icons.text_fields,
        "color": Colors.blue,
        "onTap": () {
          debugPrint("Tapped on Text-based Questions");
          Navigator.pushNamed(
            context, AppScreenRoutes.questionAttempt,
            // arguments: {'resetTimer': false}, // Passing a parameter
          );
        }
      },
      {
        "title": "MCQ",
        "icon": Icons.check_box,
        "color": Colors.green,
        "onTap": () {
          debugPrint("Tapped on MCQs");
          // Navigator.pushNamed(context, AppScreenRoutes.mcqQuestions);
        }
      },
      {
        "title": "Fill in the Blank",
        "icon": Icons.text_snippet,
        "color": Colors.orange,
        "onTap": () {
          debugPrint("Tapped on Fill in the Blank");
          // Navigator.pushNamed(context, AppScreenRoutes.fillInTheBlankQuestions);
        }
      },
      {
        "title": "True/False",
        "icon": Icons.check_circle_outline,
        "color": Colors.purple,
        "onTap": () {
          debugPrint("Tapped on True/False");
          // Navigator.pushNamed(context, AppScreenRoutes.trueFalseQuestions);
        }
      },
    ];

    return MyScaffold(
      // showAppBar: false,
      appBarTitle: 'Select Question Format',
      body: Column(
        children: [
          Text(
            'Select Question Format',
            // 'Select the Format for Question you wish to Practice',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ) ??
                const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.01),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 16, // Spacing between columns
                mainAxisSpacing: 16, // Spacing between rows
              ),
              itemCount: questionFormats.length,
              itemBuilder: (context, index) {
                final format = questionFormats[index];
                return _buildFormatTile(
                  title: format["title"],
                  icon: format["icon"],
                  color: format["color"],
                  onTap: format["onTap"],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormatTile({
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
              colors: [color.withOpacity(0.8), color.withOpacity(0.5)],
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
