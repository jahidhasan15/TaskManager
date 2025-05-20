import 'package:flutter/material.dart';
import 'package:tmgpjme/ui/screen/cancelled_task_screen.dart';
import 'package:tmgpjme/ui/screen/completed_task_screen.dart';
import 'package:tmgpjme/ui/screen/new_task_screen.dart';
import 'package:tmgpjme/ui/screen/progress_task_screen.dart';
import 'package:tmgpjme/ui/widget/tmappber.dart';

class MainButtomNavScreen extends StatefulWidget {

  static const String name='/home';


  const MainButtomNavScreen({super.key});

  @override
  State<MainButtomNavScreen> createState() => _MainButtomNavScreenState();
}

class _MainButtomNavScreenState extends State<MainButtomNavScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screen = [
      const NewTaskScreen(),
      const CompletedTaskScreen(),
      const CancelledTaskScreen(),
      const ProgressTaskScreen(),
    ];

    return Scaffold(
      appBar: const TmAppBer(),
      body: _screen[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.new_label),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.offline_pin),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_presentation),
            label: 'Cancelled',
          ),
          NavigationDestination(
            icon: Icon(Icons.timelapse),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}
