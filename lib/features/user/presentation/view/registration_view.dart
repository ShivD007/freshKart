import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/components/custom_alert_message.dart';
import 'package:fresh_kart/components/textfield.dart';
import 'package:fresh_kart/features/user/domain/entity/register_user_entity.dart';
import 'package:fresh_kart/features/user/presentation/provider/login_providers.dart';
import 'package:fresh_kart/routes/navigation.dart';
import 'package:fresh_kart/utils/app_strings.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isPasswordHidden = true;

  Future<void> _submitForm(UserNotifier userProvider) async {
    if (_formKey.currentState!.validate()) {
      final result = await userProvider.registerUserUseCase(RegisterUserEntity(
        email: _emailController.text,
        password: _passwordController.text,
        fullName: _fullNameController.text,
        phoneNo: _phoneController.text,
      ));

      result.fold((result) {
        CustomNavigator.pop(context);
      }, (failure) {
        AlertMessage.show(failure.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserNotifier userProvider = ref.read(userNotifierProviders.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.registerText)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  controller: _fullNameController,
                  hintText: AppStrings.fullNameHint,
                  labelText: AppStrings.fullNameLabel,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.fullNameError;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: _emailController,
                  hintText: AppStrings.emailHint,
                  labelText: AppStrings.emailLabel,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.emailError;
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                        .hasMatch(value)) {
                      return AppStrings.emailInvalidError;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  hintText: AppStrings.passwordHint,
                  labelText: AppStrings.passwordLabel,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _isPasswordHidden,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.passwordError;
                    }
                    if (value.length < 6) {
                      return AppStrings.passwordLengthError;
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordHidden
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: _phoneController,
                  hintText: AppStrings.phoneHint,
                  labelText: AppStrings.phoneLabel,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.phoneError;
                    }
                    if (value.length < 10) {
                      return AppStrings.phoneInvalidError;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    _submitForm(userProvider);
                  },
                  child: Text(AppStrings.registerText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
