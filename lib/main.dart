import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app/app_constants.dart';
import 'core/init/cache/locale_manager.dart';
import 'core/init/language/language_manager.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/notifier/provider_list.dart';
import 'core/init/notifier/theme_notifier.dart';
import 'feature/splash/view/splash_view.dart';

Future<void> main() async {
  await _init();
  runApp(
    MultiProvider(
      providers: [...ApplicationProvider.instance.dependItems],
      child: EasyLocalization(
        supportedLocales: LanguageManager.instance.supportedLocales,
        path: ApplicationConstants.LANG_ASSET_PATH,
        child: const MyApp(),
      ),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  LocaleManager.prefrencesInit();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeNotifier>().currentTheme,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      home: const SplashView(),
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
