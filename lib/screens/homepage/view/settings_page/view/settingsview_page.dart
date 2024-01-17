import 'package:flutter/material.dart';

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Restaurant Notification'),
            trailing: GestureDetector(
                onTap: () {
                  print('on');
                },
                child: const Icon(Icons.toggle_off_outlined)),
          )
        ],
      ),
    );
  }
}
