import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Constants/constants.dart';
import 'MainScreens/categories_selection_screen.dart';
import 'MainScreens/landing_screen.dart';
import 'MainScreens/question_screen.dart';
import 'MainScreens/settings_screen.dart';
import 'MainScreens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.white
    ..indicatorColor = blueColor
    ..textColor = Colors.white
    ..maskColor = blueColor.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: splashScreenRoute,
      builder: EasyLoading.init(),
      routes: {
        splashScreenRoute: (context) => const SplashScreen(),
        landingScreenRoute: (context) => const LandingScreen(),
        settingsScreenRoute: (context) => const SettingsScreen(),
        questionScreenRoute: (context) {
          List<CategoryModel> i =
              ModalRoute.of(context)!.settings.arguments as List<CategoryModel>;
          return QuestionScreen(i);
        },
        categoriesSelectionScreenRoute: (context) =>
            const CategoriesSelectionScreen(),
      },
    );
  }
}
