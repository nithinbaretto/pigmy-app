import 'package:flutter/material.dart';

/// Printer widgets placeholder.
class PrinterStatusBadge extends StatelessWidget {
  const PrinterStatusBadge({super.key, required this.isConnected});

  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(isConnected ? 'Connected' : 'Disconnected'),
      backgroundColor: isConnected ? Colors.green.shade100 : Colors.grey.shade200,
    );
  }
}
