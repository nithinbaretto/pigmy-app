import 'package:flutter/material.dart';

import '../../../shared/widgets/app_scaffold.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Bank Details',
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Bank Name')),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Account Number')),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'IFSC Code')),
            SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: 'Branch Name')),
          ],
        ),
      ),
    );
  }
}
