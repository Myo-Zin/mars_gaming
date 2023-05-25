import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../../auth/pages/login_page.dart';
import '../providers/providers.dart';
import '../widgets/profile_widget.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final profileController = ref.watch(profileControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).profile,
          style: TextStyle(
            color: AppColor.accentColor,
          ),
        ),
        shadowColor: Colors.transparent,
      ),
      body: profileController.map(
        unAuthenticated: (_) {
          return const LoginPage();
        },
        data: (data) {
          return ProfileWidget(profile: data.profileData);
        },
        error: (error) {
          return Center(
              child: AppErrorWidget(
            error: error.message,
            onRetry: () {
              ref.invalidate(profileControllerProvider);
            },
          ));
        },
        loading: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
