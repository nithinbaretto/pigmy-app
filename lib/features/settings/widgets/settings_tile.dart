import 'package:flutter/material.dart';

/// Settings widgets placeholder.
class SettingsTile extends StatelessWidget {
  const SettingsTile({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(title), onTap: onTap);
  }
}
