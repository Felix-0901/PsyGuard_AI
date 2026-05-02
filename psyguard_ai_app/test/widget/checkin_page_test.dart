import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:psyguard_ai_app/core/storage/app_database.dart';
import 'package:psyguard_ai_app/core/storage/database_provider.dart';
import 'package:psyguard_ai_app/features/checkin/presentation/checkin_page.dart';

void main() {
  testWidgets('check-in validation blocks note over 200 chars', (tester) async {
    final db = AppDatabase.memory();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const MaterialApp(home: CheckinPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Today\'s Note'),
      300,
      scrollable: find.descendant(
        of: find.byType(ListView),
        matching: find.byType(Scrollable),
      ),
    );
    await tester.pumpAndSettle();

    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'a' * 201);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Complete Check-in').first);
    await tester.pump();

    expect(
      find.text('Please keep the note under 200 characters.'),
      findsOneWidget,
    );
    await db.close();
  });
}
