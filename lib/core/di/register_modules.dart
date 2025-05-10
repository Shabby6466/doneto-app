// coverage: false
// coverage:ignore-file

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Injectable is a convenient code generator for get_it.
/// All you have to do now is annotate your injectable classes with @injectable and let the generator do the work.
/// This class is use to generate code to drawer objects on app start
@module
abstract class RegisterModule {
  /// same thing works for instances that's gotten asynchronous.
  /// all you need to do is wrap your instance with a future and tell injectable how
  /// to initialize it

  @LazySingleton()
  ImagePicker get imagePicker => ImagePicker();

  /// Also, make sure you await for your configure function before running the App.
  @LazySingleton()
  Logger get logger => Logger(level: Level.all, filter: ProductionFilter());

  @LazySingleton()
  Future<SharedPreferences> get sharedPreferences async => await SharedPreferences.getInstance();

  @LazySingleton()
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @LazySingleton()
  GoogleSignIn get googleSignIn => GoogleSignIn();


  @LazySingleton()
  NumberFormat get numberFormat => NumberFormat.currency(decimalDigits: 2, symbol: '');

  @LazySingleton()
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
}
