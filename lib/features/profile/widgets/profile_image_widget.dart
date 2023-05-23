import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/app_color.dart';
import '../../../utils/route.dart';
import '../../../utils/url_constants.dart';
import '../models/profile_response.dart';
import '../pages/upload_leve_2_photo_page.dart';
import '../providers/profile_image_controller.dart';

class ProfileImageWidget extends ConsumerWidget {
  const ProfileImageWidget({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final ProfileData profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localImage = ref.watch(profileImagePickControllerProvider);
    return Column(
      children: [
        const SizedBox(
          height: 18.0,
        ),
        Row(
          children: [
            const SizedBox(
              width: 18.0,
            ),
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: AppColor.accentColor,
                  ),
                  image: localImage == null
                      ? profile.image != null
                          ? DecorationImage(
                              image: NetworkImage(
                                  UrlConst.imagePrefix + profile.image!),
                              fit: BoxFit.cover,
                            )
                          : null
                      : DecorationImage(
                          image: FileImage(localImage), fit: BoxFit.cover)),
              child: profile.image == null
                  ? localImage == null
                      ? Icon(
                          CupertinoIcons.person,
                          color: AppColor.accentColor,
                          size: 40,
                        )
                      : null
                  : null,
            ),
            const SizedBox(
              width: 18.0,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppLocalizations.of(context).level} : ${profile.lvl2 == 0 ? 1 : 2}',
                    style: const TextStyle(
                      //color: AppColor.accentColor,
                      fontSize: 15,
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'ID : ${profile.userCode}',
                  //       style: const TextStyle(
                  //        // color: AppColor.accentColor,
                  //         fontSize: 15,
                  //       ),
                  //     ),
                  //     IconButton(
                  //       onPressed: () {
                  //         Clipboard.setData(ClipboardData(text: profile.userCode))
                  //             .then((_) {
                  //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //               content:
                  //               Text("Copied to clipboard ${profile.userCode}")));
                  //         });
                  //       },
                  //       icon: const Icon(
                  //         Icons.copy,
                  //        // color: AppColor.accentColor,
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),

          ],
        ),
        const SizedBox(
          height: 4,
        ),

        profile.lvl2 == 0
            ? InkWell(
                onTap: () {
                  goto(context, page: UploadLevelTwoPhotoPage(profile));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.accentColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 4,
                      bottom: 4,
                    ),
                    child: Text(
                      AppLocalizations.of(context).upgradeLevel,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )
            : const Text(''),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
