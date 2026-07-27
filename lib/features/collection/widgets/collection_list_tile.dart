import 'package:flutter/material.dart';

class CollectionListTile extends StatelessWidget {
  const CollectionListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    this.isSynced = true,
  });

  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final bool isSynced;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text('$subtitle · $date'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(amount, style: Theme.of(context).textTheme.titleMedium),
            if (!isSynced)
              Icon(Icons.cloud_off, size: 16, color: Theme.of(context).colorScheme.error),
          ],
        ),
      ),
    );
  }
}
