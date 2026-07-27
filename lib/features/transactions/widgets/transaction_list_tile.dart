import 'package:flutter/material.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
  });

  final String title;
  final String subtitle;
  final String amount;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text('$subtitle · $date'),
        trailing: Text(amount, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
