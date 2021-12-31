import 'package:flutter/material.dart';

import 'package:tk_pbp_uas/screen/suggestions.dart';
import 'package:tk_pbp_uas/screen/login_screen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.indigo,
        child: ListView(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              alignment: Alignment.center,
              color: Theme.of(context).colorScheme.secondary,
              child: const Text(
                'Hello there, Welcome to LeaN!',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    color: Colors.white),
              ),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Suggestions',
                    icon: Icons.note,
                    onClicked: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SuggestionsForm())),
                  ),
                  buildMenuItem(
                    text: 'Login',
                    icon: Icons.people,
                    onClicked: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const BelajarForm())),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) {
    const color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        break;
    }
  }
}
