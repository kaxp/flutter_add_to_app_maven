import 'package:kapil_add_to_app_flutter/modules/dashboard/pages/dashboard_tab.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:kapil_add_to_app_flutter/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialising service locator
  di.init();

  // Initialise localization
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'i18n',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advisor SDK',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.pageBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.pageBackgroundColor,
          scrolledUnderElevation: 0.0,
          titleTextStyle: TextStyleFactory.styleNormal16(
            fontWeight: FontWeight.w500,
          ),
        ),
        useMaterial3: true,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          alignLabelWithHint: true,
          hintStyle: TextStyleFactory.styleNormal14(
            fontWeight: FontWeight.w400,
            color: AppColors.black54,
          ),
        ),
      ),
      home: const DashboardTab(),
    );
  }
}
