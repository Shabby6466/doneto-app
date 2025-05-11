import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/network_calls/dio_wrapper/index.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart' show Logger;

abstract class FirebaseService {
  FirebaseService();

  /// Triggers the Google Sign-In flow.
  Future<UserCredential?> signInWithGoogle();

  /// Signs out from both Google and Firebase.
  Future<void> signOut();

  /// Email/password flows.
  Future<UserCredential?> signInWithEmail(String email, String password);

  Future<UserCredential?> signUpWithEmail(String email, String password);

  /// Sends a password-reset email.
  Future<void> sendPasswordResetEmail(String email);

  /// Sends an email-verification to the currently-signed-in user.
  Future<void> sendEmailVerification();

  /// Returns the currently-signed-in user (or null).
  Future<User?> getCurrentUser();

  /// Checks whether the current user’s email is verified.
  Future<bool> isEmailVerified();

  /// Update the current user’s display name and/or photo URL.
  Future<void> updateUserProfile({String? displayName, String? photoURL});

  /// Change the current user’s password.
  Future<void> updatePassword(String newPassword);

  /// Change the current user’s email.
  Future<void> updateEmail(String newEmail);

  /// Permanently deletes the current user.
  Future<void> deleteUser();

  Future<String> createFundraiserDraft(Fundraiser draft);

  Future<void> updateFundraiser(Fundraiser updated);

  Future<Fundraiser> getFundraiserById(String id);

  Stream<List<Fundraiser>> watchMyFundraisers();
}

@Singleton(as: FirebaseService)
class FirebaseServiceImp implements FirebaseService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _db;

  FirebaseServiceImp(this._firebaseAuth, this._googleSignIn, this._db);

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
      throw DefaultFailure(e.message ?? 'Something went wrong');
    } catch (e, stack) {
      sl<Logger>().e('SIGN UP UNKNOWN ERROR | $e', stackTrace: stack);

      throw DefaultFailure(e.toString());
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      sl<Logger>().e('PASSWORD RESET ERROR | $e');
      throw DefaultFailure(e.message ?? 'Failed to send password reset email');
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw const DefaultFailure('No user is currently signed in.');
    await user.sendEmailVerification();
  }

  @override
  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<bool> isEmailVerified() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return false;
    await user.reload();
    return user.emailVerified;
  }

  @override
  Future<void> updateUserProfile({String? displayName, String? photoURL}) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw const DefaultFailure('No user is currently signed in.');
    if (displayName != null) await user.updateDisplayName(displayName);
    if (photoURL != null) await user.updatePhotoURL(photoURL);
    await user.reload();
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw const DefaultFailure('No user is currently signed in.');
    await user.updatePassword(newPassword.trim());
  }

  @override
  Future<void> updateEmail(String newEmail) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw const DefaultFailure('No user is currently signed in.');
    await user.verifyBeforeUpdateEmail(newEmail.trim());
  }

  @override
  Future<void> deleteUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) throw const DefaultFailure('No user is currently signed in.');
    await user.delete();
  }

  CollectionReference get _fundCol => _db.collection('fundraisers');

  @override
  Future<String> createFundraiserDraft(Fundraiser draft) async {
    final doc = await _fundCol.add(draft.toMap());
    return doc.id;
  }

  @override
  Future<void> updateFundraiser(Fundraiser updated) {
    return _fundCol.doc(updated.id).update(updated.toMap());
  }

  @override
  Future<Fundraiser> getFundraiserById(String id) async {
    final snap = await _fundCol.doc(id).get();
    return Fundraiser.fromDoc(snap);
  }

  @override
  Stream<List<Fundraiser>> watchMyFundraisers() {
    final uid = _firebaseAuth.currentUser?.uid;
    if (uid == null) {
      return const Stream.empty();
    }

    return _fundCol
        .where('ownerId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((qs) => qs.docs.map(Fundraiser.fromDoc).toList());
  }
}
