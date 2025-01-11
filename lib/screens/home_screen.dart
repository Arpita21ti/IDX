import 'package:flutter/material.dart';
import 'package:tnp_rgpv_app/global_styles.dart';
import 'package:tnp_rgpv_app/global_widgets/my_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      showAppBar: false,
      body: Center(
        child: Column(
          children: [
            Text(
              'Latest for TNP',
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
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: StyleGlobalVariables.screenSizingReference * 0.3,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16), // Rounded corners
                      ),
                      clipBehavior: Clip.hardEdge,
                      elevation: 6, // Adds shadow for a floating effect
                      shadowColor: Colors.grey.shade400, // Shadow color
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFFFBB00),
                                    Color(0xFFFFCC0D),
                                    Color(0xFFFFDD1A),
                                  ],
                                  // transform: RadialGradient(
                                  //   focalRadius: 90,
                                  // ),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Post Image Here',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff9E0000),
                                    Color(0xffCF1010),
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Content Here',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          child: const Text('For More'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
