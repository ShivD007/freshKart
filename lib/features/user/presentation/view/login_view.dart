import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresh_kart/components/custom_alert_message.dart';
import 'package:fresh_kart/features/user/domain/entity/login_req_entity.dart';
import 'package:fresh_kart/features/user/presentation/provider/login_providers.dart';
import 'package:fresh_kart/routes/navigation.dart';
import 'package:fresh_kart/routes/route_name.dart';
import 'package:fresh_kart/utils/app_strings.dart';
import 'package:fresh_kart/components/textfield.dart';
import 'package:fresh_kart/utils/app_regex.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(UserNotifier userProvider) async {
    if (_formKey.currentState!.validate()) {
      final result = await userProvider.loginUsecase(LoginReqEntity(
          email: _emailController.text, password: _passwordController.text));

      result.fold((result) {
        CustomNavigator.pushReplacement(
          context,
          Routes.home,
        );
      }, (failure) {
        AlertMessage.show(failure.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = ref.read(userNotifierProviders.notifier);
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.loginTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email Field
              CustomTextField(
                controller: _emailController,
                hintText: AppStrings.emailHint,
                labelText: AppStrings.emailLabel,
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(AppRegex.noSpaces),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.emailEmptyError;
                  }
                  if (!AppRegex.emailPattern.hasMatch(value)) {
                    return AppStrings.emailInvalidError;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Password Field
              CustomTextField(
                controller: _passwordController,
                hintText: AppStrings.passwordHint,
                labelText: AppStrings.passwordLabel,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(AppRegex.noSpaces),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.passwordEmptyError;
                  }
                  if (!AppRegex.passwordMinLength.hasMatch(value)) {
                    return AppStrings.passwordLengthError;
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  _login(userProvider);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(AppStrings.loginButton,
                    style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
