import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/extension.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/route.dart';
import '../../../utils/validator.dart';
import '../models/registeration_form.dart';
import '../providers/providers.dart';
import '../widgets/logo_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'code_verify_page.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  bool obsecure = false;
  late TextEditingController nameTextController;
  late TextEditingController phoneTextController;
  late TextEditingController passwordTextController;
  late TextEditingController referralTextController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameTextController = TextEditingController();
    phoneTextController = TextEditingController();
    passwordTextController = TextEditingController();
    referralTextController = TextEditingController();
  }

  @override
  void dispose() {
    nameTextController.dispose();
    phoneTextController.dispose();
    passwordTextController.dispose();
    referralTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checkPhoneController);
    final regState = ref.read(registerScreenController);

    ref.listen<AsyncValue>(
      checkPhoneController,
      (_, state) => "", //state.showSnackBarOnError(context),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Center(child: LogoImageWidget()),
                    const SizedBox(height: 20),
                    Text(
                      AppLocalizations.of(context).name,
                      style: TextStyle(color: AppColor.accentColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: (value) => Validator.valueExists(value),
                      controller: nameTextController,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                          // hintText: AppLocalizations.of(context).name,
                          // prefixIcon: const Icon(Icons.person),
                          ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context).phone,
                      style: TextStyle(color: AppColor.accentColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: (value) => Validator.phoneValidate(value),
                      keyboardType: TextInputType.phone,
                      controller: phoneTextController,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                          // hintText: AppLocalizations.of(context).phone,
                          // prefixIcon: const Icon(Icons.phone),
                          ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context).password,
                      style: TextStyle(color: AppColor.accentColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: (value) => Validator.valueExists(value),
                      controller: passwordTextController,
                      obscureText: obsecure,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                        // hintText: AppLocalizations.of(context).password,
                        // prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obsecure = !obsecure;
                            });
                          },
                          icon: obsecure
                              ? const Icon(CupertinoIcons.eye)
                              : const Icon(CupertinoIcons.eye_slash),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      AppLocalizations.of(context).refferalCode,
                      style: TextStyle(color: AppColor.accentColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: referralTextController,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                          // hintText: AppLocalizations.of(context).refferalCode,
                          ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.isLoading || regState.isLoading
                            ? () {}
                            : () async {

                                String? mesg = await ref
                                    .watch(checkPhoneController.notifier)
                                    .checkPhone(
                                        phone: phoneTextController.text);
                                if (mounted) {
                                  if (mesg == null) {
                                    ref
                                        .read(registerScreenController.notifier)
                                        .verifyPhoneForRegister(
                                      rf: RegisterationForm(
                                        name: nameTextController.text,
                                        phone: phoneTextController.text,
                                        password: passwordTextController.text,
                                        referral: referralTextController.text,
                                      ),
                                      context: context,
                                    );
                                    // goto(
                                    //   context,
                                    //   page: CodeVerifyPage(
                                    //     phoneForForgotPassword: null,
                                    //     registerationForm: RegisterationForm(
                                    //       name: nameTextController.text,
                                    //       phone: phoneTextController.text,
                                    //       password: passwordTextController.text,
                                    //       referral: referralTextController.text,
                                    //     ),
                                    //     verificationId: "",
                                    //   ),
                                    // );
                                  } else {
                                    context.showErrorSnackbar(mesg);
                                  }
                                }
                              },
                        child: state.isLoading || regState.isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: CircularProgressIndicator(
                                  color: AppColor.textColor,
                                ),
                              )
                            : Text(AppLocalizations.of(context).register),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context).accountAlreadyExist),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context).login),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
