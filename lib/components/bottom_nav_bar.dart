import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  final void Function(int) onTabChange;

  const MyBottomNavBar({Key? key, required this.onTabChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.grey[700],
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        tabBorderRadius: 16,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        onTabChange: (value) => onTabChange(value),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.list,
            text: 'Logs',
          ),
          GButton(
            icon: Icons.insights,
            text: 'Insights',
          ),
        ],
      ),
    );
  }
}
  