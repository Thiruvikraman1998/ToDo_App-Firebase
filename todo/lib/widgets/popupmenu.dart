import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/settings_enum.dart';
import 'package:todo/services/firebase_services.dart';

class PopUpMenuAction extends StatefulWidget {
  const PopUpMenuAction({super.key});

  @override
  State<PopUpMenuAction> createState() => _PopUpMenuActionState();
}

class _PopUpMenuActionState extends State<PopUpMenuAction> {
  SettingsItems? settingsItems;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SettingsItems>(
      onSelected: (SettingsItems items) {
        return onItemSelected(context, items);
      },
      initialValue: settingsItems,
      itemBuilder: (context) {
        return <PopupMenuEntry<SettingsItems>>[
          PopupMenuItem(
            value: SettingsItems.notifications,
            child: Row(
              children: [
                Icon(settingsItemsIcons[SettingsItems.notifications]),
                const Gap(10),
                const Text("Notifications")
              ],
            ),
          ),
          PopupMenuItem(
            value: SettingsItems.settings,
            child: Row(
              children: [
                Icon(settingsItemsIcons[SettingsItems.settings]),
                const Gap(10),
                const Text("Settings")
              ],
            ),
          ),
          PopupMenuItem(
            value: SettingsItems.signout,
            child: Row(
              children: [
                Icon(settingsItemsIcons[SettingsItems.signout]),
                const Gap(10),
                const Text("Sign out")
              ],
            ),
          )
        ];
      },
    );
  }

  void onItemSelected(BuildContext context, SettingsItems items) {
    switch (items) {
      case SettingsItems.notifications:
        print("Notification pressed");
        break;
      case SettingsItems.settings:
        print("Settings pressed");
        break;
      case SettingsItems.signout:
        context.read<FirebaseServices>().signout(context);
        break;
    }
  }
}
