import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class FireStoreService {
  Future<String> createFundraiserDraft(Fundraiser draft);

  Future<void> updateFundraiser(Fundraiser updated);

  Future<Fundraiser> getFundraiserById(String id);

  Future<void> saveUserProfile(UserProfile draft);

  Future<UserProfile> getUserProfile();

  Stream<UserProfile> watchUserProfile(String uid);

  Stream<List<Fundraiser>> watchAllFundraisers();

  Stream<List<Fundraiser>> watchMyFundraisers();
}

@LazySingleton(as: FireStoreService)
class FirebaseServiceImp implements FireStoreService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  FirebaseServiceImp(this._auth, this._db);

  CollectionReference get _fundCol => _db.collection('fundraisers');

  CollectionReference get _userCol => _db.collection('users');

  @override
  Future<String> createFundraiserDraft(Fundraiser draft) async {
    final uid = _auth.currentUser!.uid;
    final docRef = _fundCol.doc();

    final batch = _db.batch();
    batch.set(docRef, {'ownerId': uid, ...draft.toMap()});
    batch.set(_userCol.doc(uid).collection('fundraisers').doc(docRef.id), draft.toMap());

    await batch.commit();
    return docRef.id;
  }

  @override
  Future<void> updateFundraiser(Fundraiser updated) {
    final uid = _auth.currentUser!.uid;
    final batch = _db.batch();

    final topRef = _fundCol.doc(updated.id);
    final userRef = _userCol.doc(uid).collection('fundraisers').doc(updated.id);

    batch.update(topRef, updated.toMap());
    batch.update(userRef, updated.toMap());

    return batch.commit();
  }

  @override
  Future<Fundraiser> getFundraiserById(String id) async {
    final snap = await _fundCol.doc(id).get();
    return Fundraiser.fromDoc(snap);
  }

  @override
  Stream<List<Fundraiser>> watchMyFundraisers() {
    final uid = _auth.currentUser!.uid;
    return _fundCol
        .where('ownerId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((qs) => qs.docs.map(Fundraiser.fromDoc).toList());
  }

  @override
  Future<void> saveUserProfile(UserProfile profile) {
    return _userCol.doc(profile.uid).set(profile.toMap(), SetOptions(merge: true));
  }

  @override
  Future<UserProfile> getUserProfile() async {
    final uid = _auth.currentUser!.uid;
    final snap = await _userCol.doc(uid).get();
    return UserProfile.fromDoc(snap);
  }

  @override
  Stream<UserProfile> watchUserProfile(String uid) {
    return _userCol.doc(uid).snapshots().map(UserProfile.fromDoc);
  }

  @override
  Stream<List<Fundraiser>> watchAllFundraisers() {
    return _fundCol.orderBy('createdAt', descending: true).snapshots().map((qs) => qs.docs.map(Fundraiser.fromDoc).toList());
  }
}
