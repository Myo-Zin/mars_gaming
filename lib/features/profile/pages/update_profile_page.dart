import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mars_gaming/utils/async_value_ui.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/url_constants.dart';
import '../../../utils/validator.dart';
import '../models/profile_response.dart';
import '../models/update_profile_form.dart';
import '../providers/profile_image_controller.dart';
import '../providers/providers.dart';
import '../widgets/pick_profile_image_dialog.dart';

class UpdateProfilePage extends ConsumerStatefulWidget {
  const UpdateProfilePage(this.profileData, {super.key});

  final ProfileData profileData;

  @override
  ConsumerState<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends ConsumerState<UpdateProfilePage> {
  late TextEditingController nameTextController;
  late TextEditingController emailTextController;
  late TextEditingController birthDayTextController;
  late TextEditingController referralTextController;
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  String formatDate = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      setState(() {
        formatDate = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameTextController = TextEditingController();
    emailTextController = TextEditingController();
    birthDayTextController = TextEditingController();
    referralTextController = TextEditingController();
    final profile = widget.profileData;
    nameTextController.text = profile.name ?? "";
    emailTextController.text = profile.email ?? "";
    birthDayTextController.text =
        formatDate.isEmpty ? profile.birthday ?? "" : formatDate;
  }

  @override
  void dispose() {
    nameTextController.dispose();
    emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileUpdateController);
    ref.listen<AsyncValue>(
      profileUpdateController,
      (_, state) => state.showSnackBarOnError(context),
    );
    // birthDayTextController.text = "${selectedDate.toLocal()}".split(' ')[0];
    final localImageFile = ref.watch(profileImagePickControllerProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).editProfile),
        ),
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
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        // const SizedBox(height: 20),
                        Stack(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 2,
                                    color: AppColor.accentColor,
                                  ),
                                  image: localImageFile == null
                                      ? widget.profileData.image != null
                                          ? DecorationImage(
                                              image: NetworkImage(UrlConst
                                                      .imagePrefix +
                                                  widget.profileData.image!),
                                              fit: BoxFit.cover,
                                            )
                                          : null
                                      : DecorationImage(
                                          image: FileImage(localImageFile),
                                          fit: BoxFit.cover)),
                              child: widget.profileData.image == null
                                  ? localImageFile == null
                                      ? Icon(
                                          Icons.person_outline,
                                          color: AppColor.accentColor,
                                          size: 40,
                                        )
                                      : null
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  pickProfileImageDialog(
                                      context, ref, "profile");
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: AppColor.accentColor,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: const FittedBox(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: AppColor.textColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        const SizedBox(height: 30),
                        TextFormField(
                          validator: (value) => Validator.valueExists(value),
                          controller: nameTextController,
                          decoration: AppTheme.authTextFieldDecoration.copyWith(
                            hintText: "Name",
                            prefixIcon: const Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          // validator: (value) => Validator.phoneValidate(value),
                          keyboardType: TextInputType.phone,
                          controller: emailTextController,
                          decoration: AppTheme.authTextFieldDecoration.copyWith(
                            hintText: "Email",
                            prefixIcon: const Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          // validator: (value) => Validator.phoneValidate(value),
                          keyboardType: TextInputType.text,
                          controller: birthDayTextController,
                          decoration: AppTheme.authTextFieldDecoration.copyWith(
                            hintText: "Birthday",
                            prefixIcon: const Icon(Icons.date_range),
                          ),
                          onTap: () => _selectDate(context),
                          readOnly: true,
                        ),
                        const SizedBox(height: 30),
                        if (widget.profileData.referralId == null)
                          TextFormField(
                            // validator: (value) => Validator.phoneValidate(value),
                            keyboardType: TextInputType.text,
                            controller: referralTextController,
                            decoration:
                                AppTheme.authTextFieldDecoration.copyWith(
                              hintText: "Enter referral code",
                              prefixIcon:
                                  const Icon(Icons.person_add_alt_outlined),
                            ),
                          ),
                        // TextFormField(
                        //   validator: (value) => Validator.valueExists(value),
                        //   controller: passwordTextController,
                        //   obscureText: obsecure,
                        //   decoration: AppTheme.authTextFieldDecoration.copyWith(
                        //     hintText: "Password",
                        //     prefixIcon: const Icon(Icons.lock),
                        //     suffixIcon: IconButton(
                        //       onPressed: () {
                        //         setState(() {
                        //           obsecure = !obsecure;
                        //         });
                        //       },
                        //       icon: obsecure
                        //           ? const Icon(CupertinoIcons.eye)
                        //           : const Icon(CupertinoIcons.eye_slash),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 30),
                        // TextFormField(
                        //   controller: referralTextController,
                        //   decoration: AppTheme.authTextFieldDecoration.copyWith(
                        //     hintText: "Referral code",
                        //   ),
                        // ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state.isLoading
                                ? () {}
                                : () async {
                                    if (_formKey.currentState?.validate() ==
                                        true) {
                                      final isSuccess = await ref
                                          .read(
                                              profileUpdateController.notifier)
                                          .updateProfile(
                                            uf: UpdateProfileForm(
                                                token:
                                                    widget.profileData.token!,
                                                name: nameTextController.text,
                                                email: emailTextController.text,
                                                image: localImageFile,
                                                birthday:
                                                    birthDayTextController.text,
                                                referral: referralTextController
                                                    .text),
                                          );
                                      if (isSuccess) {
                                        if (mounted) {
                                          Navigator.pop(context);
                                          context.showSuccessSnackbar(
                                              "Profile update success");
                                          ref.invalidate(
                                              profileControllerProvider);
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
                                : const Text("Save"),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ));
  }
}
