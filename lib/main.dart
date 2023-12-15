import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stocks_tracker/firebase_options.dart';
import 'package:stocks_tracker/navigation/route.dart';
import 'package:stocks_tracker/navigation/route_names.dart';
import 'package:stocks_tracker/service/service_locator.dart';
import 'package:stocks_tracker/themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initialize();
  runApp(const StocksTracker());
}

Future<void> _initialize() async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } on Exception catch (e) {
    log("Failed to initialize Firebase: $e");
  }

  await ServiceLocator.setup();
}

class StocksTracker extends StatelessWidget {
  const StocksTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StocksTracker',
      initialRoute: RouteNames.splash,
      routes: Routes.get(context),
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
    );
  }
}
