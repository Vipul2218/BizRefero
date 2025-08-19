import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/auth_providers.dart';
import '../../domain/entities/auth_state.dart';

class PasswordSetupWidget extends ConsumerStatefulWidget {
  const PasswordSetupWidget({super.key});

  @override
  ConsumerState<PasswordSetupWidget> createState() => _PasswordSetupWidgetState();
}

class _PasswordSetupWidgetState extends ConsumerState<PasswordSetupWidget> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  
  // Password strength indicators
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkPasswordStrength);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_checkPasswordStrength);
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength() {
    final password = _passwordController.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider); // Changed from authController to authState
    
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 24.w,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 12.w),
                Text(
                  'Set Your Password',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 8.h),
            
            Text(
              'Create a strong password to secure your account',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Password field
            _buildPasswordField(),
            
            SizedBox(height: 16.h),
            
            // Confirm password field
            _buildConfirmPasswordField(),
            
            SizedBox(height: 16.h),
            
            // Password strength indicator
            _buildPasswordStrengthIndicator(),
            
            SizedBox(height: 24.h),
            
            // Setup password button
            _buildSetupButton(authState), // Changed parameter
            
            // Show error if any
            if (authState.error != null) ...[
              SizedBox(height: 16.h),
              _buildErrorCard(authState.error!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          validator: _validatePassword,
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Password',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            hintText: 'Confirm your password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
              onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
            ),
          ),
          validator: _validateConfirmPassword,
        ),
      ],
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    final strengthCount = [
      _hasMinLength,
      _hasUppercase,
      _hasLowercase,
      _hasNumber,
      _hasSpecialChar,
    ].where((element) => element).length;
    
    Color strengthColor;
    String strengthText;
    
    if (strengthCount <= 2) {
      strengthColor = Colors.red;
      strengthText = 'Weak';
    } else if (strengthCount <= 3) {
      strengthColor = Colors.orange;
      strengthText = 'Fair';
    } else if (strengthCount <= 4) {
      strengthColor = Colors.yellow[700]!;
      strengthText = 'Good';
    } else {
      strengthColor = Colors.green;
      strengthText = 'Strong';
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Password Strength: ',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              strengthText,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: strengthColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        
        SizedBox(height: 8.h),
        
        // Progress bar
        LinearProgressIndicator(
          value: strengthCount / 5,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
        ),
        
        SizedBox(height: 12.h),
        
        // Requirements checklist
        Column(
          children: [
            _buildRequirementItem('At least 8 characters', _hasMinLength),
            _buildRequirementItem('One uppercase letter', _hasUppercase),
            _buildRequirementItem('One lowercase letter', _hasLowercase),
            _buildRequirementItem('One number', _hasNumber),
            _buildRequirementItem('One special character', _hasSpecialChar),
          ],
        ),
      ],
    );
  }

  Widget _buildRequirementItem(String text, bool satisfied) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Icon(
            satisfied ? Icons.check_circle : Icons.circle_outlined,
            size: 16.w,
            color: satisfied 
                ? Colors.green
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: satisfied 
                  ? Colors.green
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetupButton(AuthState authState) { // Changed parameter type from AuthController to AuthState
    final isLoading = authState.isLoading; // Now accessing from AuthState
    final isFormValid = _isPasswordValid() && _passwordController.text == _confirmPasswordController.text;
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (isFormValid && !isLoading) ? _setupPassword : null,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              )
            : Text(
                'Complete Setup',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Theme.of(context).colorScheme.error.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 20.w,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              error,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    
    if (!_isPasswordValid()) {
      return 'Password does not meet requirements';
    }
    
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  bool _isPasswordValid() {
    return _hasMinLength && _hasUppercase && _hasLowercase && _hasNumber && _hasSpecialChar;
  }

  void _setupPassword() {
    if (!_formKey.currentState!.validate()) return;
    
    final authController = ref.read(authControllerProvider.notifier);
    authController.setupPassword(_passwordController.text);
  }
}