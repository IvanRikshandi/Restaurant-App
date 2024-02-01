import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screens/homepage/view/settings_page/viewmodel/setting_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({super.key});

  Future<void> _getSwitchValue(SettingsViewModel viewModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool storedValue = prefs.getBool('isScheduled') ?? false;
    viewModel.updateScheduledValue(storedValue);
    print('Stored Switch Value: $storedValue');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<SettingsViewModel>(
        builder: (context, viewModel, _) {
          _getSwitchValue(viewModel);
          return ListView(
            children: [
              ListTile(
                title: const Text('Restaurant Notification'),
                trailing: Switch.adaptive(
                  value: viewModel.isScheduled,
                  activeTrackColor: Colors.orange,
                  inactiveTrackColor: Colors.grey.shade300,
                  onChanged: (value) async {
                    await viewModel.scheduledNews(value);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
