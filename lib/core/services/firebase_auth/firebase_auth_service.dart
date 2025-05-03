import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseAuthService {
  FirebaseAuthService();

  /// Triggers the Google Sign-In flow.
  Future<UserCredential?>
  signInWithGoogle();

  /// Signs out from both Google and Firebase.
  Future<void> signOut();
}

@Singleton(as: FirebaseAuthService)
class FirebaseAuthServiceImp implements FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthServiceImp(
      this._firebaseAuth,
      this._googleSignIn,
      );

  @override
  Future<UserCredential?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final cred = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return _firebaseAuth.signInWithCredential(cred);
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
