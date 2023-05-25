import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/error_widget.dart';
import '../providers/providers.dart';
import '../widgets/social_link_widget.dart';

class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socialController = ref.watch(socialLinkControllerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).contact),
      ),
      body: socialController.when(
        data: (data) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(socialLinkControllerProvider);
          },
          child: SocialLinkWidget(social: data),
        ),
        error: (error, stackTrace) => AppErrorWidget(
          error: error,
          onRetry: () {
            ref.invalidate(socialLinkControllerProvider);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
