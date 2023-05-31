// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../features/home/pages/contact_page.dart' as _i6;
import '../../features/home/pages/first_page.dart' as _i2;
import '../../features/home/pages/home_page.dart' as _i3;
import '../../features/home/widgets/bottom_nav_widget.dart' as _i1;
import '../../features/profile/pages/profile_page.dart' as _i7;
import '../../features/promotion/page/promotion_page.dart' as _i4;
import '../../features/wallet/pages/wallet_page.dart' as _i5;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    NaviRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.NaviPage(),
      );
    },
    FirstRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.FirstPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    PromotionRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.PromotionPage(),
      );
    },
    WalletRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.WalletPage(),
      );
    },
    ContactRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.ContactPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.ProfilePage(),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          NaviRoute.name,
          path: '/navi',
          children: [
            _i8.RouteConfig(
              HomeRoute.name,
              path: 'home-page',
              parent: NaviRoute.name,
            ),
            _i8.RouteConfig(
              PromotionRoute.name,
              path: 'promotion-page',
              parent: NaviRoute.name,
            ),
            _i8.RouteConfig(
              WalletRoute.name,
              path: 'wallet-page',
              parent: NaviRoute.name,
            ),
            _i8.RouteConfig(
              ContactRoute.name,
              path: 'contact-page',
              parent: NaviRoute.name,
            ),
            _i8.RouteConfig(
              ProfileRoute.name,
              path: 'profile-page',
              parent: NaviRoute.name,
            ),
          ],
        ),
        _i8.RouteConfig(
          FirstRoute.name,
          path: '/',
        ),
      ];
}

/// generated route for
/// [_i1.NaviPage]
class NaviRoute extends _i8.PageRouteInfo<void> {
  const NaviRoute({List<_i8.PageRouteInfo>? children})
      : super(
          NaviRoute.name,
          path: '/navi',
          initialChildren: children,
        );

  static const String name = 'NaviRoute';
}

/// generated route for
/// [_i2.FirstPage]
class FirstRoute extends _i8.PageRouteInfo<void> {
  const FirstRoute()
      : super(
          FirstRoute.name,
          path: '/',
        );

  static const String name = 'FirstRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home-page',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.PromotionPage]
class PromotionRoute extends _i8.PageRouteInfo<void> {
  const PromotionRoute()
      : super(
          PromotionRoute.name,
          path: 'promotion-page',
        );

  static const String name = 'PromotionRoute';
}

/// generated route for
/// [_i5.WalletPage]
class WalletRoute extends _i8.PageRouteInfo<void> {
  const WalletRoute()
      : super(
          WalletRoute.name,
          path: 'wallet-page',
        );

  static const String name = 'WalletRoute';
}

/// generated route for
/// [_i6.ContactPage]
class ContactRoute extends _i8.PageRouteInfo<void> {
  const ContactRoute()
      : super(
          ContactRoute.name,
          path: 'contact-page',
        );

  static const String name = 'ContactRoute';
}

/// generated route for
/// [_i7.ProfilePage]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: 'profile-page',
        );

  static const String name = 'ProfileRoute';
}
