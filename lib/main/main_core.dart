// coverage: false
// coverage:ignore-file


import 'dart:io';

import 'package:doneto/app/my_app.dart';
import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/base_env.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../core/utils/bloc_observer/bloc_observer.dart';
import '../core/utils/resource/r.dart';

/// this used to initialize all required parameters and start the app
void initMainCore({required String enviormentPath}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: enviormentPath);
  MyFirebase firebase = FirebaseImp();
  var result = await firebase.init();
  if (result) {
    Bloc.observer = BlocObservers();
    final mediaData = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single,
    );
    R.setData(mediaData);
    BaseEnv.instance.setEnv();
    await configureDependencies();
    // await sl.isReady<SharedPreferences>();
    // debugRepaintRainbowEnabled = true;
    // debugRepaintTextRainbowEnabled = true;
    runApp(
      const MyApp(),

      // MultiBlocProvider(
      //   providers: [
      //
      //   ],
    );
    // }
  }
}
abstract class MyFirebase {
  Future<bool> init();
}

class FirebaseImp extends MyFirebase {
  @override
  Future<bool> init() async {
    var app = await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: Platform.isAndroid ? dotenv.env['ANDROID_FIREBASE_API_KEY'] ?? '' : dotenv.env['iOS_FIREBASE_API_KEY'] ?? '',
        appId: Platform.isAndroid ? dotenv.env['ANDROID_FIREBASE_APP_ID'] ?? '' : dotenv.env['iOS_FIREBASE_APP_ID'] ?? '',
        messagingSenderId: Platform.isAndroid ? dotenv.env['ANDROID_FIREBASE_MESSAGE_ID'] ?? '' : dotenv.env['iOS_FIREBASE_MESSAGE_ID'] ?? '',
        projectId: Platform.isAndroid ? dotenv.env['ANDROID_FIREBASE_PROJECT_ID'] ?? '' : dotenv.env['iOS_FIREBASE_PROJECT_ID'] ?? '',
      ),
    );
    FirebaseAuth.instance.setLanguageCode('en');
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
    );
    FirebaseAppCheck.instanceFor(app: app);
    return true;
  }
}
