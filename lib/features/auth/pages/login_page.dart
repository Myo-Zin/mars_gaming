import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mars_gaming/utils/async_value_ui.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/route.dart';
import '../../../utils/validator.dart';
import '../providers/providers.dart';
import '../widgets/logo_widget.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key, this.isfromDialog = false});
  final bool isfromDialog;

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool obsecure = false;
  late TextEditingController phoneTextController;
  late TextEditingController passwordTextController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    phoneTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    phoneTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginScreenController);
    ref.listen<AsyncValue>(
      loginScreenController,
      (_, state) => state.showSnackBarOnError(context),
    );
    return Scaffold(
      appBar: widget.isfromDialog ? AppBar() : null,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: const LogoImageWidget()),
                  const SizedBox(height: 20),
                  Text(AppLocalizations.of(context).phone,style: TextStyle(color: AppColor.accentColor),),
                  const SizedBox(height: 8,),
                  TextFormField(
                    validator: (value) => Validator.phoneValidate(value),
                    keyboardType: TextInputType.phone,
                    controller: phoneTextController,
                    decoration: AppTheme.authTextFieldDecoration.copyWith(
                      //hintText: AppLocalizations.of(context).phone,
                     // prefixIcon: const Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(AppLocalizations.of(context).password,style: TextStyle(color: AppColor.accentColor),),
                  const SizedBox(height: 8,),
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isLoading
                          ? () {}
                          : () async {
                              if (_formKey.currentState?.validate() == true) {
                                final isSuccess = await ref
                                    .read(loginScreenController.notifier)
                                    .login(
                                      phone:
                                          int.parse(phoneTextController.text),
                                      password: passwordTextController.text,
                                    );
                                if (mounted) {
                                  if (widget.isfromDialog && isSuccess) {
                                    Navigator.pop(context);
                                  }
                                }
                              }
                            },
                      child: state.isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(3.0),
                              child: CircularProgressIndicator(
                                color: AppColor.textColor,
                              ),
                            )
                          :  Text(AppLocalizations.of(context).login),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          goto(context, page: const ForgotPasswordPage());
                        },
                        child:  Text(AppLocalizations.of(context).forgetPassword),
                      ),
                      
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              goto(context, page: const RegisterPage());
                            },
                            child:  Text(AppLocalizations.of(context).register),
                          ),
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
    );
  }
}
