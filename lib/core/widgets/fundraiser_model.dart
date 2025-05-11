import 'package:cloud_firestore/cloud_firestore.dart';

enum FundraiserType { yourself, someoneElse, charity }

class Fundraiser {
  final String id;
  final String ownerId;
  final FundraiserType type;
  final double targetAmount;
  final String category;
  final String? location;
  final String title;
  final String description;
  final String? photoUrl;
  final Timestamp createdAt;

  Fundraiser({
    required this.id,
    required this.ownerId,
    required this.type,
    required this.targetAmount,
    required this.category,
    this.location,
    required this.title,
    required this.description,
    this.photoUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'ownerId': ownerId,
    'type': type.name,
    'targetAmount': targetAmount,
    'category': category,
    'location': location,
    'title': title,
    'description': description,
    'photoUrl': photoUrl,
    'createdAt': createdAt,
  };

  factory Fundraiser.fromDoc(DocumentSnapshot doc) {
    final d = doc.data()! as Map<String, dynamic>;
    return Fundraiser(
      id: doc.id,
      ownerId: d['ownerId'],
      type: FundraiserType.values.firstWhere((e) => e.name == (d['type'] as String)),
      targetAmount: (d['targetAmount'] as num).toDouble(),
      category: d['category'],
      location: d['location'] as String?,
      title: d['title'],
      description: d['description'],
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
    //
  });

  Map<String, dynamic> toMap() => {
    'fullName': fullName,
    'email': email,
    'imageUrl': imageUrl,
    'phoneNumber': phoneNumber,
    'instagramHandle': instagramHandle,
    //
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
}
