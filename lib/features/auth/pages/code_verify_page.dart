import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/async_value_ui.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/route.dart';
import '../models/registeration_form.dart';
import '../providers/providers.dart';
import '../widgets/logo_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'change_password_page.dart';

class CodeVerifyPage extends ConsumerStatefulWidget {
  final RegisterationForm? registerationForm;
  final String? phoneForForgotPassword;
  final String verificationId;

  const CodeVerifyPage({
    super.key,
    required this.registerationForm,
    required this.phoneForForgotPassword,
    required this.verificationId,
  });

  @override
  ConsumerState<CodeVerifyPage> createState() => _CodeVerifyPageState();
}

class _CodeVerifyPageState extends ConsumerState<CodeVerifyPage> {
  late TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerScreenController);
    ref.listen<AsyncValue>(
      registerScreenController,
      (_, state) => state.showSnackBarOnError(context),
    );
    widget.phoneForForgotPassword == null
        ? ref.watch(otpSendController(widget.registerationForm!.phone))
        : ref.watch(otpSendController(widget.phoneForForgotPassword!));

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Align(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const LogoImageWidget(),
                  const Text(
                    "We sent verification code to your phone number.Please enter and verify.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: codeController,
                    decoration: AppTheme.authTextFieldDecoration
                        .copyWith(hintText: "Verification code"),
                    keyboardType: TextInputType.phone,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context).changePhone),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isLoading
                          ? () {}
                          : () async {
                              if (codeController.text.isNotEmpty) {
                                if (widget.phoneForForgotPassword != null) {

                                  ref
                                      .read(registerScreenController.notifier)
                                      .checkCodeForForgotPassword(
                                    context: context,
                                    verificationId: widget.verificationId,
                                    smsCode: codeController.text,
                                    phone: widget.phoneForForgotPassword!,
                                  );
                                  // final otpResponse = await ref
                                  //     .read(registerScreenController.notifier)
                                  //     .verifyOtp(
                                  //         phone: widget.phoneForForgotPassword
                                  //             .toString(),
                                  //         code: codeController.text);
                                  // if (mounted) {
                                  //   if (otpResponse != null) {
                                  //     if (otpResponse.isVerified == 1) {
                                  //       goto(
                                  //         context,
                                  //         page: ChangePasswordPage(
                                  //           phone: widget.phoneForForgotPassword
                                  //               .toString(),
                                  //         ),
                                  //       );
                                  //     } else {
                                  //       context.showErrorSnackbar(
                                  //           otpResponse.message);
                                  //     }
                                  //   }
                                  //   const SnackBar(
                                  //     content: Text("Error"),
                                  //   );
                                  // }

                                } else {
                                ref
                                      .read(registerScreenController.notifier)
                                      .checkCodeForRegister(
                                    verificationId: widget.verificationId,
                                    smsCode: codeController.text,
                                    rf: widget.registerationForm!,
                                  )
                                      .then((value) {
                                    if (value) {
                                      context.showSuccessSnackbar(
                                        "Register Success",
                                      );
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                  });
                                  // final otpResponse = await ref
                                  //     .read(registerScreenController.notifier)
                                  //     .verifyOtp(
                                  //         phone:
                                  //             widget.registerationForm!.phone,
                                  //         code: codeController.text);
                                  // if (mounted) {
                                  //   if (otpResponse != null) {
                                  //     if (otpResponse.isVerified == 1) {
                                  //       ref
                                  //           .read(registerScreenController
                                  //               .notifier)
                                  //           .register(
                                  //               rf: widget.registerationForm!)
                                  //           .then((value) {
                                  //         if (value) {
                                  //           context.showSuccessSnackbar(
                                  //             "Register Success",
                                  //           );
                                  //           Navigator.pop(context);
                                  //           Navigator.pop(context);
                                  //         }
                                  //       });
                                  //     } else {
                                  //       context.showErrorSnackbar(
                                  //           otpResponse.message);
                                  //     }
                                  //   }
                                  //   const SnackBar(
                                  //     content: Text("Error"),
                                  //   );
                                  // }
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Please enter verification code"),
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
                          : const Text("Verify"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
