import 'package:events_dashboard/features/categories/presentation/pages/categories_screen.dart';
import 'package:events_dashboard/features/feedback/presentation/pages/feedback_screen.dart';
import 'package:events_dashboard/features/orders/presentation/pages/orders_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var pageController = PageController(initialPage: 0);
  final index = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: index,
        builder: (context, value, _) {
          return Scaffold(
            body: PageView(
              controller: pageController,
              children: const [
                CategoriesScreen(),
                OrdersScreen(),
                FeedbackScreen(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: value,
                type: BottomNavigationBarType.shifting,
                onTap: (s) {
                  index.value = s;
                  pageController.animateToPage(s,
                      duration: Durations.medium1, curve: Curves.ease);
                },
                items: const [
                  BottomNavigationBarItem(
                      backgroundColor: Colors.deepPurple,
                      icon: Icon(Icons.category),
                      label: 'categories'),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.purple,
                    icon: Icon(Icons.list_alt),
                    label: 'Orders',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.deepPurpleAccent,
                    icon: Icon(Icons.feedback_rounded),
                    label: 'Feedbacks',
                  )
                ]),
          );
        });
  }
}
