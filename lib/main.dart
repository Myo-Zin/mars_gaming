import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mars_gaming/utils/app_theme.dart';

import 'core/notification/notification_service.dart';
import 'features/home/pages/first_page.dart';
import 'l10n/l10n.dart';
import 'l10n/local_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeFirebase();

  // await Firebase.initializeApp(
  //   name: "crypto",
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  if (await FirebaseMessaging.instance.isSupported()) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      supportedLocales: L10n.all,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      home: const FirstPage(),
    );
  }
}

Future<void> initializeFirebase() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    await Firebase.initializeApp(
        //Android app ID's from firebase console of project 1
        name: 'default',
        options: const FirebaseOptions(
          apiKey: 'AIzaSyBzLaRVvxFhSCKDknNtgzJrv3obKukllW8',
          appId: '1:1090758221545:android:579f5a073bae165bf51a78',
          messagingSenderId: '1090758221545',
          projectId: 'marsgaming-40c0d',
          databaseURL:
              'https://marsgaming-40c0d-default-rtdb.asia-southeast1.firebasedatabase.app',
          storageBucket: 'marsgaming-40c0d.appspot.com',
        ));
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    await Firebase.initializeApp(
        //iOS app ID's from firebase console of project 1
        name: 'default',
        options: const FirebaseOptions(
          apiKey: 'AIzaSyAeFa1yIiqoF6qubDrf8bu4RHUi5Y0ks2k',
          appId: '1:1090758221545:ios:ffa8ab5e88f71a24f51a78',
          messagingSenderId: '1090758221545',
          projectId: 'marsgaming-40c0d',
          databaseURL:
              'https://marsgaming-40c0d-default-rtdb.asia-southeast1.firebasedatabase.app',
          storageBucket: 'marsgaming-40c0d.appspot.com',
          iosClientId:
              '1090758221545-1c2ibo8r49c25v3l7aploeavag9oqgh5.apps.googleusercontent.com',
          iosBundleId: 'com.marsgaming.marsGaming',
        ));
  }
  //initialize second app here
  if (defaultTargetPlatform == TargetPlatform.android) {
    await Firebase.initializeApp(
        //Android app ID's from firebase console of project 2
        name: 'secondApp',
        options: const FirebaseOptions(
          apiKey: 'AIzaSyALIhEuN6b1gEzd0BkMIZv--MoRy1ygUq8',
          appId: '1:873556556575:android:c9cab7927a258eac1bce2a',
          messagingSenderId: '873556556575',
          projectId: 'crypto-da28a',
          databaseURL:
              'https://crypto-da28a-default-rtdb.asia-southeast1.firebasedatabase.app',
          storageBucket: 'crypto-da28a.appspot.com',
        ));
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    await Firebase.initializeApp(
        //iOS app ID's from firebase console of project 2
        name: 'secondApp',
        options: const FirebaseOptions(
          apiKey: 'AIzaSyDNF5mzM3zslxuj09PqRsr65aSwTz-Npr8',
          appId: '1:873556556575:ios:e2ea3287dc628c131bce2a',
          messagingSenderId: '873556556575',
          projectId: 'crypto-da28a',
          databaseURL:
              'https://crypto-da28a-default-rtdb.asia-southeast1.firebasedatabase.app',
          storageBucket: 'crypto-da28a.appspot.com',
          iosClientId:
              '873556556575-qbbah302hr9eb6c3abc04193p1iekbpi.apps.googleusercontent.com',
          iosBundleId: 'com.myvipmm.myvip',
        ));
  }
}
