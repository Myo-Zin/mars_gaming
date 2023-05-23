import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/async_value_ui.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../providers/providers.dart';
import '../widgets/logo_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ChangePasswordPage extends ConsumerStatefulWidget {
  final String phone;
  const ChangePasswordPage({
    super.key,
    required this.phone,
  });

  @override
  ConsumerState<ChangePasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ChangePasswordPage> {
  late TextEditingController passwordTextController;
  @override
  void initState() {
    super.initState();
    passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerScreenController);
    ref.listen<AsyncValue>(
      registerScreenController,
      (_, state) => state.showSnackBarOnError(context),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const LogoImageWidget(),
                const SizedBox(height: 30),
                TextFormField(
                  controller: passwordTextController,
                  keyboardType: TextInputType.phone,
                  decoration: AppTheme.authTextFieldDecoration.copyWith(
                    hintText: AppLocalizations.of(context).newPassword,
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isLoading
                        ? () {}
                        : () async {
                            if (passwordTextController.text.isNotEmpty) {
                              final isSuccess = await ref
                                  .read(registerScreenController.notifier)
                                  .forgotPassword(
                                    phone: widget.phone,
                                    password: passwordTextController.text,
                                  );
                              if (isSuccess) {
                                if (mounted) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  log("password change = $isSuccess");
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                  content:
                                      Text(AppLocalizations.of(context).enterNewPassword),
                                ),
                              );
                            }
                          },
                    child: state.isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircularProgressIndicator(
                              color: AppColor.textColor,
                            ),
                          )
                        :  Text(AppLocalizations.of(context).changePassword),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
