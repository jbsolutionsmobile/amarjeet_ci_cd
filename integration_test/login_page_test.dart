import 'package:amarjeet_ci_cd/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('Login'), findsExactly(2));

      final loginBtnFinder = find.byKey(const ValueKey("LoginBtn"));
      expect(loginBtnFinder, findsOneWidget);

      await tester.tap(loginBtnFinder);
      await tester.pumpAndSettle();

      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);

      await tester.pump(const Duration(seconds: 3));

      final emailFieldFinder = find.byKey(const ValueKey("emailField"));
      await tester.pump(const Duration(seconds: 3));

      final passwordFieldFinder = find.byKey(const ValueKey("passwordField"));
      await tester.pump(const Duration(seconds: 3));

      expect(emailFieldFinder, findsOneWidget);
      expect(passwordFieldFinder, findsOneWidget);

      await tester.enterText(emailFieldFinder, "amar@gmail.com");
      await tester.pump(const Duration(seconds: 3));
      await tester.enterText(passwordFieldFinder, "amarjeet");
      await tester.pump(const Duration(seconds: 3));

      await tester.tap(loginBtnFinder);
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.text('Check your email'), findsNothing);
      expect(find.text('Password must be length 8 letter/digit'), findsNothing);
    });
  });
}
