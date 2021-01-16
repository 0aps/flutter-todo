import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../lib/main.dart' as app;
import '../lib/modules/auth/screens/widgets/email_field.dart';
import '../lib/modules/auth/screens/widgets/password_field.dart';
import '../lib/modules/auth/screens/widgets/standard_button.dart';
import '../lib/modules/todo/screens/todos_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Should complete login process for valid credentials',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final _ = await AppLocalizations.delegate.load(Locale('en'));

      final emailField = find.byType(EmailField);
      expect(emailField, findsOneWidget);

      final passwordField = find.byType(PasswordField);
      expect(passwordField, findsOneWidget);

      await tester.enterText(emailField, 'vecic23366@lovomon.com');
      await tester.enterText(passwordField, 'abc123456');

      final loginBtn = find.byType(StandardButton);
      await tester.tap(loginBtn);
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byType(TodosScreen), findsOneWidget);
    },
  );
}
