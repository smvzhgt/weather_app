import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme.dart';
import 'di/injection.dart' as di;
import 'generated/l10n.dart';
import 'scenes/bottom_navigation/bottom_navigation_page.dart';
import 'scenes/location/presentation/pages/location_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(ForecastApp(savedThemeMode: savedThemeMode));
}

class ForecastApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  ForecastApp({
    Key? key,
    this.savedThemeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: kLightTheme,
      dark: kDarkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (light, dark) => MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: 'Movie App',
        theme: light,
        darkTheme: dark,
        debugShowCheckedModeBanner: false,
        initialRoute: BottomNavigationPage.routeName,
        routes: _routes,
      ),
    );
  }

  final Map<String, Widget Function(BuildContext)> _routes = {
    BottomNavigationPage.routeName: (context) => const ProviderScope(
          child: BottomNavigationPage(),
        ),
    LocationPage.routeName: (context) => const ProviderScope(
          child: LocationPage(),
        )
  };
}
