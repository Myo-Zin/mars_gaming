import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/route.dart';
import '../../../utils/url_constants.dart';
import '../../auth/pages/login_page.dart';
import '../../balance_transfer_history/pages/balance_transfer_history_page.dart';
import '../../balance_transfer_history/providers/balance_transfer_history_controller.dart';
import '../../cash_in_out/pages/payment_methods_page.dart';
import '../../cash_in_out_history/pages/cash_in_history_page.dart';
import '../../cash_in_out_history/pages/cash_out_history_page.dart';
import '../../profile/models/profile_response.dart';
import '../../profile/providers/providers.dart';
import '../widgets/main_balance_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WalletPage extends ConsumerStatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  ConsumerState<WalletPage> createState() => _WalletState();
}

class _WalletState extends ConsumerState<WalletPage> {
  @override
  Widget build(BuildContext context) {
    final profileController = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).wallet,
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
          return RefreshIndicator(
            onRefresh: () async {
              ref.read(profileControllerProvider.notifier).refreshProfile();
            },
            child: _BuildWalletWidget(profile: data.profileData),
          );
        },
        error: (error) {
          return AppErrorWidget(
            error: error.message,
            onRetry: () {
              ref.refresh(profileControllerProvider);
            },
          );
        },
        loading: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _BuildWalletWidget extends StatelessWidget {
  final ProfileData profile;

  const _BuildWalletWidget({required this.profile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MainBalanceCard(
              profile: profile,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      goto(context,
                          page: PaymentMethodsPage(
                            url: UrlConst.cashInPaymentMethodUrl,
                            title: AppLocalizations.of(context).cashIn,
                            isCashIn: true,
                            promoId: null,
                          ));
                    },
                    child: Text(AppLocalizations.of(context).cashIn),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      goto(context,
                          page: PaymentMethodsPage(
                            url: UrlConst.cashOutPaymentMethodUrl,
                            title: AppLocalizations.of(context).cashOut,
                            isCashIn: false,
                            promoId: null,
                          ));
                    },
                    child: Text(AppLocalizations.of(context).cashOut),
                  ),
                ),
              ],
            ),

            _HistoryListTile(
              title: AppLocalizations.of(context).cashinHistory,
              page: const CashInHistoryPage(),
            ),
            _HistoryListTile(
              title: AppLocalizations.of(context).cashoutHistory,
              page: const CashOutHistoryPage(),
            ),
            _HistoryListTile(
              title: AppLocalizations.of(context).maintoGameBalanceHistory,
              page: BalanceTransferHistoryPage(
                type: BalanceTransferType.mainToGame,
                title: AppLocalizations.of(context).maintoGameBalanceHistory,
              ),
            ),
            _HistoryListTile(
              title: AppLocalizations.of(context).gametoMainBalanceHistory,
              page: BalanceTransferHistoryPage(
                type: BalanceTransferType.gameToMain,
                title: AppLocalizations.of(context).gametoMainBalanceHistory,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryListTile extends StatelessWidget {
  final String title;
  final Widget page;

  const _HistoryListTile({
    Key? key,
    required this.title,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListTile(
        onTap: () {
          goto(
            context,
            page: page,
          );
        },
        title: Text(
          title,
          style: AppTextStyle.yellowMedium,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: AppColor.accentColor,
        ),
      ),
    );
  }
}
