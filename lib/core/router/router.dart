import 'package:auto_route/annotations.dart';

import '../../features/home/pages/contact_page.dart';
import '../../features/home/pages/first_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/home/widgets/bottom_nav_widget.dart';
import '../../features/profile/pages/profile_page.dart';
import '../../features/promotion/page/promotion_page.dart';
import '../../features/wallet/pages/wallet_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/navi',
      page: NaviPage,
      children: [
        AutoRoute(page: HomePage),
        AutoRoute(page: PromotionPage),
        AutoRoute(page: WalletPage),
        AutoRoute(page: ContactPage),
        AutoRoute(page: ProfilePage),
      ],
    ),
    AutoRoute(page: FirstPage, initial: true),
  ],
)
class $AppRouter {}
