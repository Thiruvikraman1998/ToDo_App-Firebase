import 'package:flutter/material.dart';

enum SettingsItems { notifications, settings, signout }

const settingsItemsIcons = {
  SettingsItems.notifications: Icons.notifications_active_outlined,
  SettingsItems.settings: Icons.settings_suggest_rounded,
  SettingsItems.signout: Icons.logout_rounded
};
