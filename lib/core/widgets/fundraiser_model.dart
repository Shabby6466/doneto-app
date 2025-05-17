import 'package:cloud_firestore/cloud_firestore.dart';

enum FundraiserType { yourself, someoneElse, charity }

class Fundraiser {
  final String id;
  final String ownerId;
  final int supporters;
  final FundraiserType type;
  final bool featured;
  final bool donetoVerified;
  final double targetAmount;
  final double receivedAmount;
  final String category;
  final String? location;
  final String title;
  final String description;
  final String? photoUrl;
  final Timestamp createdAt;

  Fundraiser({
    required this.id,
    required this.supporters,
    required this.ownerId,
    required this.type,
    required this.featured,
    required this.donetoVerified,
    required this.targetAmount,
    required this.receivedAmount,
    required this.category,
    this.location,
    required this.title,
    required this.description,
    this.photoUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'ownerId': ownerId,
    'supporters': supporters,
    'type': type.name,
    'targetAmount': targetAmount,
    'receivedAmount': receivedAmount,
    'donetoVerified': donetoVerified,
    'featured': featured,
    'category': category,
    'location': location,
    'title': title,
    'description': description,
    'photoUrl': photoUrl,
    'createdAt': createdAt,
  };

  factory Fundraiser.fromDoc(DocumentSnapshot doc) {
    final d = doc.data()! as Map<String, dynamic>;
    // print(
    //   '[fromDoc] '
    //   '${doc.id} → '
    //   'supp=${d['supporters']}(${d['supporters']?.runtimeType}), '
    //   'tgt=${d['targetAmount']}(${d['targetAmount']?.runtimeType}), '
    //   'rcv=${d['receivedAmount']}(${d['receivedAmount']?.runtimeType})',
    // );
    // // ────────
    return Fundraiser(
      id: doc.id,
      ownerId: d['ownerId'] as String,
      supporters: (d['supporters'] as num).toInt(),
      type: FundraiserType.values.firstWhere((e) => e.name == (d['type'] as String), orElse: () => FundraiserType.charity),
      targetAmount: (d['targetAmount'] as num).toDouble(),
      featured: (d['featured'] as bool?) ?? false,
      donetoVerified: (d['donetoVerified'] as bool?) ?? false,
      receivedAmount: (d['receivedAmount'] as num).toDouble(),
      category: d['category'] as String,
      location: d['location'] as String?,
      title: d['title'] as String,
      description: d['description'] as String,
      photoUrl: d['photoUrl'] as String?,
      createdAt: d['createdAt'] as Timestamp,
    );
  }
}

class UserProfile {
  final String uid;
  final String fullName;
  final String phoneNumber;
  final String imageUrl;
  final String email;
  final String instagramHandle;

  UserProfile({
    required this.uid,
    required this.imageUrl,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.instagramHandle,
  });

  Map<String, dynamic> toMap() => {
    'fullName': fullName,
    'email': email,
    'imageUrl': imageUrl,
    'phoneNumber': phoneNumber,
    'instagramHandle': instagramHandle,
  };

  factory UserProfile.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return UserProfile(
      uid: doc.id,
      fullName: data['fullName'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
      email: data['email'] as String? ?? '',
      phoneNumber: data['phoneNumber'] as String? ?? '',
      instagramHandle: data['instagramHandle'] as String? ?? '',
    );
  }

  factory UserProfile.initial() => UserProfile(
    uid: '',
    fullName: '',
    imageUrl: '',
    email: '',
    phoneNumber: '',
    instagramHandle: '',
    //
  );
}
