import 'package:flutter/material.dart';
import 'package:isango_app/core/theme/app_colors.dart';
import 'package:isango_app/core/theme/app_spacing.dart';
import 'package:isango_app/screens/auth/verify_email_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isEmailError = false;
  bool _isPasswordMismatch = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
    _confirmPasswordController.addListener(_validatePasswordMatch);
    _passwordController.addListener(_validatePasswordMatch);
  }

  void _validateEmail() {
    final email = _emailController.text;
    final bool isValid = email.isEmpty || (email.contains('@') && (email.endsWith('.edu') || email.endsWith('.ac.za')));
    if (_isEmailError != !isValid && email.isNotEmpty) {
      setState(() {
        _isEmailError = !isValid;
      });
    } else if (email.isEmpty && _isEmailError) {
      setState(() {
        _isEmailError = false;
      });
    }
  }

  void _validatePasswordMatch() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final bool mismatch = password.isNotEmpty && confirmPassword.isNotEmpty && password != confirmPassword;
    if (_isPasswordMismatch != mismatch) {
      setState(() {
        _isPasswordMismatch = mismatch;
      });
    }
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmail);
    _confirmPasswordController.removeListener(_validatePasswordMatch);
    _passwordController.removeListener(_validatePasswordMatch);
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceContainerLowest,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.primaryContainer,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Create Account',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.primaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          SizedBox(width: AppSpacing.xl),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  // Intro text
                  Text(
                    'Join your campus community to never miss an event.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Form
                  Form(
                    child: Column(
                      children: [
                        // Full Name
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.xs,
                                left: AppSpacing.sm,
                              ),
                              child: Text(
                                'Full Name',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.outlineVariant),
                                color: AppColors.surfaceContainerLowest,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  hintText: 'John Doe',
                                  hintStyle: TextStyle(
                                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: AppColors.outline,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.md,
                                    vertical: AppSpacing.md,
                                  ),
                                ),
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // University Email (Error State)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.xs,
                                left: AppSpacing.sm,
                              ),
                              child: Text(
                                'University Email',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: _isEmailError ? AppColors.error : AppColors.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _isEmailError ? AppColors.error : AppColors.outlineVariant,
                                ),
                                color: _isEmailError
                                    ? AppColors.errorContainer.withValues(alpha: 0.2)
                                    : AppColors.surfaceContainerLowest,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'student@gmail.com',
                                  hintStyle: TextStyle(
                                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.mail_outline,
                                    color: _isEmailError ? AppColors.error : AppColors.outline,
                                  ),
                                  suffixIcon: _isEmailError
                                      ? Icon(Icons.error_outline, color: AppColors.error)
                                      : null,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.md,
                                    vertical: AppSpacing.md,
                                  ),
                                ),
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ),
                            if (_isEmailError)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: AppSpacing.base,
                                  left: AppSpacing.sm,
                                ),
                                child: Text(
                                  'Please use a valid university email address',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.error,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Password
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.xs,
                                left: AppSpacing.sm,
                              ),
                              child: Text(
                                'Password',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.outlineVariant),
                                color: AppColors.surfaceContainerLowest,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: '••••••••',
                                  hintStyle: TextStyle(
                                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: AppColors.outline,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                    child: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off_outlined,
                                      color: AppColors.outline,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.md,
                                    vertical: AppSpacing.md,
                                  ),
                                ),
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Confirm Password
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.xs,
                                left: AppSpacing.sm,
                              ),
                              child: Text(
                                'Confirm Password',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: _isPasswordMismatch ? AppColors.error : AppColors.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _isPasswordMismatch ? AppColors.error : AppColors.outlineVariant,
                                ),
                                color: _isPasswordMismatch
                                    ? AppColors.errorContainer.withValues(alpha: 0.2)
                                    : AppColors.surfaceContainerLowest,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _confirmPasswordController,
                                obscureText: !_isConfirmPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: '••••••••',
                                  hintStyle: TextStyle(
                                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock_reset_outlined,
                                    color: _isPasswordMismatch ? AppColors.error : AppColors.outline,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                      });
                                    },
                                    child: Icon(
                                      _isConfirmPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off_outlined,
                                      color: _isPasswordMismatch ? AppColors.error : AppColors.outline,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.md,
                                    vertical: AppSpacing.md,
                                  ),
                                ),
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ),
                            if (_isPasswordMismatch)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: AppSpacing.base,
                                  left: AppSpacing.sm,
                                ),
                                child: Text(
                                  'Passwords do not match',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.error,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),

                        // Create Account Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryContainer,
                            foregroundColor: AppColors.surfaceContainerLowest,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            elevation: 8,
                          ),
                          onPressed: () {
                            if (!_isEmailError && !_isPasswordMismatch && _emailController.text.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const VerifyEmailScreen(),
                                ),
                              );
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Create Account',
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: AppColors.surfaceContainerLowest,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.surfaceContainerLowest,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Footer note
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.lg,
              ),
              child: Text(
                'We will send you a verification link to your email after you sign up.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
            // Sign In Link
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xl),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Already have an account? ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign In',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
