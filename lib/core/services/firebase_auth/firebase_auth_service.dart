import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/network_calls/dio_wrapper/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart' show Logger;

abstract class FirebaseAuthService {
  FirebaseAuthService();

  /// Triggers the Google Sign-In flow.
  Future<UserCredential?> signInWithGoogle();

  /// Signs out from both Google and Firebase.
  Future<void> signOut();

  Future<UserCredential?> signInWithEmail(String email, String password);

  Future<UserCredential?> signUpWithEmail(String email, String password);
}

@Singleton(as: FirebaseAuthService)
class FirebaseAuthServiceImp implements FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthServiceImp(this._firebaseAuth, this._googleSignIn);

  @override
  Future<UserCredential?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final cred = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
      //
    );

    return _firebaseAuth.signInWithCredential(cred);
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
        //
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      sl<Logger>().e('SIGN IN ERROR | $e');
      throw DefaultFailure(e.message ?? 'Something went wrong');
    }
  }

  @override
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
        //
      );
      await credential.user?.sendEmailVerification();
      return credential;
    } on FirebaseAuthException catch (e) {
      sl<Logger>().e('SIGN UP ERROR | $e');
      throw DefaultFailure(e.message ?? 'Could not sign up with email/password.');
    } catch (e, stack) {
      sl<Logger>().e('SIGN UP UNKNOWN ERROR | $e', stackTrace: stack);

      throw DefaultFailure(e.toString());
    }
  }
}
