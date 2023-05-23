import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mars_gaming/utils/async_value_ui.dart';
import 'package:mars_gaming/utils/extension.dart';

import '../../../utils/app_color.dart';
import '../models/profile_response.dart';
import '../providers/level_image_controller.dart';
import '../providers/providers.dart';
import '../widgets/pick_profile_image_dialog.dart';

class UploadLevelTwoPhotoPage extends ConsumerStatefulWidget {
  final ProfileData profileData;

  const UploadLevelTwoPhotoPage(this.profileData, {Key? key}) : super(key: key);

  @override
  ConsumerState<UploadLevelTwoPhotoPage> createState() =>
      _UploadLevelTwoPhotoPageState();
}

class _UploadLevelTwoPhotoPageState
    extends ConsumerState<UploadLevelTwoPhotoPage> {
  @override
  Widget build(BuildContext context) {
    final localImageFile = ref.watch(levelImagePickControllerProvider);
    final state = ref.watch(uploadLevelTwoImageController);
    ref.listen<AsyncValue>(
      uploadLevelTwoImageController,
      (_, state) => state.showSnackBarOnError(context),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).upgradeLevel),
        actions: [
          if (localImageFile != null)
            IconButton(
              icon: Icon(
                Icons.edit,
                color: AppColor.accentColor,
              ),
              onPressed: () {
                pickProfileImageDialog(context, ref, "level");
              },
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(AppLocalizations.of(context).upgradeToLevel2),
            const Text("KBZ pay,Wave Pay level 2 account screenshot"),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 350,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.accentColor)),
              child: localImageFile == null
                  ? InkWell(
                      onTap: () {
                        pickProfileImageDialog(context, ref, "level");
                      },
                      child: Icon(
                        Icons.add,
                        size: 40,
                        color: AppColor.accentColor,
                      ))
                  : Image.file(
                      localImageFile,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(
              height: 18,
            ),
            ElevatedButton(
              onPressed: () async {
                 if (localImageFile != null) {
                   final isSuccess = await ref
                       .read(uploadLevelTwoImageController.notifier)
                       .uploadLevel2Image(
                       token: widget.profileData.token!,
                       file: localImageFile);
                   if (isSuccess) {
                     if (mounted) {
                       context.showSuccessSnackbar(
                         "Upload Success".hardCoded,
                       );
                     }
                   }
                 }
                 //if(mounted)context.showErrorSnackbar("Add Photo");
              },
              child: state.isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: CircularProgressIndicator(
                        color: AppColor.textColor,
                      ),
                    )
                  :  Text(AppLocalizations.of(context).upload),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
