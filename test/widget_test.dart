import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pigmy_app/main.dart';

void main() {
  testWidgets('App launches splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: PigmyApp()),
    );

    expect(find.byType(PigmyApp), findsOneWidget);
  });
}
