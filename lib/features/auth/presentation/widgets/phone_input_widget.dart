import 'package:business_referral_app/features/auth/domain/entities/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/auth_providers.dart';
import './otp_input_widget.dart';

class PhoneInputWidget extends ConsumerStatefulWidget {
  final bool isSignIn;
  
  const PhoneInputWidget({
    super.key,
    required this.isSignIn,
  });

  @override
  ConsumerState<PhoneInputWidget> createState() => _PhoneInputWidgetState();
}

class _PhoneInputWidgetState extends ConsumerState<PhoneInputWidget> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String _selectedCountryCode = '+1';
  
  final List<Map<String, String>> _countryCodes = [
    {'code': '+1', 'country': 'US', 'flag': '🇺🇸'},
    {'code': '+44', 'country': 'UK', 'flag': '🇬🇧'},
    {'code': '+91', 'country': 'IN', 'flag': '🇮🇳'},
    {'code': '+86', 'country': 'CN', 'flag': '🇨🇳'},
    {'code': '+49', 'country': 'DE', 'flag': '🇩🇪'},
    {'code': '+33', 'country': 'FR', 'flag': '🇫🇷'},
    {'code': '+81', 'country': 'JP', 'flag': '🇯🇵'},
    {'code': '+82', 'country': 'KR', 'flag': '🇰🇷'},
    {'code': '+61', 'country': 'AU', 'flag': '🇦🇺'},
    {'code': '+55', 'country': 'BR', 'flag': '🇧🇷'},
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Phone number input
          _buildPhoneNumberField(),
          
          if (widget.isSignIn) ...[
            SizedBox(height: 16.h),
            _buildPasswordField(),
          ],
          
          SizedBox(height: 32.h),
          
          // Submit button
          _buildSubmitButton(authState),
          
          // Show error if any
          if (authState.error != null) ...[
            SizedBox(height: 16.h),
            _buildErrorCard(authState.error!),
          ],
          
          // Show OTP input if OTP was sent
          if (authState.otpSent && !widget.isSignIn) ...[
            SizedBox(height: 24.h),
            const OTPInputWidget(),
          ],
        ],
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(15),
          ],
          decoration: InputDecoration(
            hintText: 'Enter your phone number',
            prefixIcon: _buildCountryCodeSelector(),
            suffixIcon: _phoneController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _phoneController.clear();
                      setState(() {});
                    },
                  )
                : null,
          ),
          validator: _validatePhoneNumber,
          onChanged: (value) => setState(() {}),
        ),
      ],
    );
  }

  Widget _buildCountryCodeSelector() {
    return Container(
      width: 80.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCountryCode,
          isDense: true,
          items: _countryCodes.map((country) {
            return DropdownMenuItem<String>(
              value: country['code'],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    country['flag']!,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    country['code']!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => _selectedCountryCode = value);
            }
          },
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
            color: Theme.of(context).colorScheme.onSurface,
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton(AuthState authState) {
    final isLoading = authState.isLoading;
    
    return ElevatedButton(
      onPressed: isLoading ? null : _handleSubmit,
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
              widget.isSignIn ? 'Sign In' : 'Send OTP',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onPrimary,
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
          color: Theme.of(context).colorScheme.error.withAlpha(77),
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

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    
    // Basic phone number validation
    if (value.length < 6) {
      return 'Phone number is too short';
    }
    
    if (value.length > 15) {
      return 'Phone number is too long';
    }
    
    // Check if contains only digits
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Phone number should contain only digits';
    }
    
    return null;
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;
    
    final phoneNumber = '$_selectedCountryCode${_phoneController.text}';
    final authController = ref.read(authControllerProvider.notifier);
    
    if (widget.isSignIn) {
      // Sign in with phone and password
      authController.signInWithPassword(
        phoneNumber,
        _passwordController.text,
      );
    } else {
      // Send OTP for sign up
      authController.sendOTP(phoneNumber);
    }
  }
}
