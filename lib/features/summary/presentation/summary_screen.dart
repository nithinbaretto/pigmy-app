import 'package:flutter/material.dart';

import '../../../shared/widgets/app_scaffold.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Summary',
      body: const Center(child: Text('Daily / Monthly collection summary')),
    );
  }
}
