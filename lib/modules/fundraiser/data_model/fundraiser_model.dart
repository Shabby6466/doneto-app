import 'package:cloud_firestore/cloud_firestore.dart';

enum FundraiserType { yourself, someoneElse, charity }

class Fundraiser {
  final String id;
  final String ownerId;
  final FundraiserType type;
  final double targetAmount;
  final String category;
  final GeoPoint? location;
  final bool notificationsEnabled;
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
    this.notificationsEnabled = false,
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
    'notificationsEnabled': notificationsEnabled,
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
      type: FundraiserType.values
          .firstWhere((e) => e.name == (d['type'] as String)),
      targetAmount: (d['targetAmount'] as num).toDouble(),
      category: d['category'],
      location: d['location'] as GeoPoint?,
      notificationsEnabled: d['notificationsEnabled'] as bool? ?? false,
      title: d['title'],
      description: d['description'],
      photoUrl: d['photoUrl'] as String?,
      createdAt: d['createdAt'] as Timestamp,
    );
  }
}
