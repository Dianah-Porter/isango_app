import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isango_app/screens/auth/login_screen.dart';
import 'package:isango_app/screens/auth/signup_screen.dart';
import 'package:isango_app/screens/auth/verify_email_screen.dart';

void main() {
  Widget createTestWidget(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  Future<void> setSurfaceSize(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 1000));
  }

  group('SignupScreen Validation Tests', () {
    testWidgets('Shows email error when invalid email is entered', (WidgetTester tester) async {
      await setSurfaceSize(tester);
      await tester.pumpWidget(createTestWidget(const SignupScreen()));

      final emailField = find.byType(TextField).at(1); // University Email field
      await tester.enterText(emailField, 'invalid-email');
      await tester.pump();

      expect(find.text('Please use a valid university email address'), findsOneWidget);

      await tester.enterText(emailField, 'student@university.edu');
      await tester.pump();

      expect(find.text('Please use a valid university email address'), findsNothing);
    });

    testWidgets('Shows password mismatch error when passwords do not match', (WidgetTester tester) async {
      await setSurfaceSize(tester);
      await tester.pumpWidget(createTestWidget(const SignupScreen()));

      final passwordField = find.byType(TextField).at(2);
      final confirmPasswordField = find.byType(TextField).at(3);

      await tester.enterText(passwordField, 'password123');
      await tester.enterText(confirmPasswordField, 'password456');
      await tester.pump();

      expect(find.text('Passwords do not match'), findsOneWidget);

      await tester.enterText(confirmPasswordField, 'password123');
      await tester.pump();

      expect(find.text('Passwords do not match'), findsNothing);
    });
  });

  group('Navigation Tests', () {
    testWidgets('Navigates from Login to Signup', (WidgetTester tester) async {
      await setSurfaceSize(tester);
      await tester.pumpWidget(createTestWidget(const LoginScreen()));

      final signUpLink = find.descendant(
        of: find.byType(Row),
        matching: find.text('Sign Up'),
      );
      await tester.tap(signUpLink);
      await tester.pumpAndSettle();

      expect(find.byType(SignupScreen), findsOneWidget);
    });

    testWidgets('Navigates from Signup to VerifyEmail on successful validation', (WidgetTester tester) async {
      await setSurfaceSize(tester);
      await tester.pumpWidget(createTestWidget(const SignupScreen()));

      await tester.enterText(find.byType(TextField).at(0), 'John Doe');
      await tester.enterText(find.byType(TextField).at(1), 'student@university.edu');
      await tester.enterText(find.byType(TextField).at(2), 'password123');
      await tester.enterText(find.byType(TextField).at(3), 'password123');
      await tester.pump();

      final createAccountButton = find.descendant(
        of: find.byType(ElevatedButton),
        matching: find.text('Create Account'),
      );
      await tester.tap(createAccountButton);
      await tester.pumpAndSettle();

      expect(find.byType(VerifyEmailScreen), findsOneWidget);
    });

    testWidgets('Navigates back from Signup to Login', (WidgetTester tester) async {
      await setSurfaceSize(tester);
      await tester.pumpWidget(createTestWidget(const SignupScreen()));

      final signInLink = find.descendant(
        of: find.byType(Row),
        matching: find.text('Sign In'),
      );
      await tester.ensureVisible(signInLink);
      await tester.tap(signInLink);
      await tester.pumpAndSettle();

      expect(find.byType(SignupScreen), findsNothing);
    });
  });
}
