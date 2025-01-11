import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/global_widgets/my_scaffold.dart';
import 'package:tnp_rgpv_app/providers/timer_provider.dart';

class CommonQuestionScreen extends ConsumerStatefulWidget {
  final bool resetTimer;

  const CommonQuestionScreen({super.key, this.resetTimer = true});

  @override
  ConsumerState<CommonQuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends ConsumerState<CommonQuestionScreen> {
  int currentQuestionIndex = 1;
  final int totalQuestions = 10;

  @override
  void initState() {
    super.initState();

    if (widget.resetTimer) {
      // Reset and start timer if resetTimer is true
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(timerProvider.notifier).reset();
        ref.read(timerProvider.notifier).start();
      });
    } else {
      // Show popup to ask user
      WidgetsBinding.instance.addPostFrameCallback((_) => _showRestartDialog());
    }
  }

  void _showRestartDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Resume or Restart?'),
          content: const Text(
              'Would you like to continue from where you left off or restart the timer?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Continue'),
            ),
            TextButton(
              onPressed: () {
                ref.read(timerProvider.notifier).reset();
                ref.read(timerProvider.notifier).start();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final elapsedTime = ref.watch(timerProvider); // Watch the timer state
    int minutes = elapsedTime ~/ 60;
    int seconds = elapsedTime % 60;

    return MyScaffold(
      appBarTitle: 'Attempt the Questions',
      body: Column(
        children: [
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.01),
          // Time Tracker and Question Number Tracker Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeTracker(minutes, seconds),
              _buildQuestionTracker(),
            ],
          ),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.03),
          // Question Area
          Expanded(
            flex: 7,
            child: _buildQuestionArea(),
          ),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.03),
          // Bottom Action Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (currentQuestionIndex > 1) {
                    setState(() {
                      currentQuestionIndex--;
                    });
                  }
                },
                child: const Text('Previous'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  if (currentQuestionIndex < totalQuestions) {
                    setState(() {
                      currentQuestionIndex++;
                    });
                  }
                },
                child: const Text('Next'),
              ),
            ],
          ),
          SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.01),
        ],
      ),
    );
  }

  Widget _buildTimeTracker(int minutes, int seconds) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$minutes:${seconds.toString().padLeft(2, '0')}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildQuestionTracker() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "Q$currentQuestionIndex/$totalQuestions",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildQuestionArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Q. $currentQuestionIndex: What is Flutter?",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: StyleGlobalVariables.screenSizingReference * 0.03),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (context, index) {
                return RadioListTile(
                  value: true,
                  groupValue: true,
                  onChanged: (value) {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
