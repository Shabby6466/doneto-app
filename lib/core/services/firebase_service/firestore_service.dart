import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doneto/core/widgets/funraiser_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class FireStoreService {
  Future<String> createFundraiserDraft(Fundraiser draft);

  Future<void> updateFundraiser(Fundraiser updated);

  Future<Fundraiser> getFundraiserById(String id);

  Stream<List<Fundraiser>> watchMyFundraisers();
}

@LazySingleton(as: FireStoreService)
class FirebaseServiceImp implements FireStoreService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  FirebaseServiceImp(this._auth, this._db);

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
    final uid = _auth.currentUser?.uid;
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
