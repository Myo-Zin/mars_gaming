import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../providers/providers.dart';
import '../widgets/logo_widget.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  late TextEditingController phoneTextController;

  @override
  void initState() {
    super.initState();
    phoneTextController = TextEditingController();
  }

  @override
  void dispose() {
    phoneTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checkPhoneController);
    ref.listen<AsyncValue>(
      checkPhoneController,
      (_, state) => "", //state.showSnackBarOnError(context),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const LogoImageWidget(),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: phoneTextController,
                    keyboardType: TextInputType.phone,
                    decoration: AppTheme.authTextFieldDecoration.copyWith(
                      hintText: AppLocalizations.of(context).phone,
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
                              if (phoneTextController.text.isNotEmpty) {
                                String? mesg = await ref
                                    .watch(checkPhoneController.notifier)
                                    .checkPhone(
                                        phone: phoneTextController.text);
                                if (mounted) {
                                  if (mesg == null) {
                                    context.showErrorSnackbar(
                                        "Phone does not exit");
                                  } else {
                                    ref
                                        .read(registerScreenController.notifier)
                                        .verifyPhoneForForgotPassword(
                                          phone: phoneTextController.text,
                                          context: context,
                                        );
                                    // goto(
                                    //   context,
                                    //   page: CodeVerifyPage(
                                    //     phoneForForgotPassword:
                                    //         phoneTextController.text,
                                    //     registerationForm: null,
                                    //     verificationId: "",
                                    //   ),
                                    // );
                                  }
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please enter phone number"),
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
                          : const Text("Request Code"),
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
