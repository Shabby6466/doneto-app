class AppUser {
  /// UUID of the user (matches auth.uid())
  final String id;

  /// Full name
  final String name;

  /// Email address
  final String email;

  /// Hashed password on the server (you'll never populate this in the client)
  final String? passwordHash;

  /// Whether the user has confirmed their email
  final bool isVerified;

  /// When the record was created
  final DateTime createdAt;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.passwordHash,
    required this.isVerified,
    required this.createdAt,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id:           map['id'] as String,
      name:         map['name'] as String,
      email:        map['email'] as String,
      passwordHash: map['password_hash'] as String?,
      isVerified:   map['is_verified'] as bool? ?? false,
      createdAt:    DateTime.parse(map['created_at'] as String),
    );
  }

  /// Convert this user back into a map for inserts/updates
  Map<String, dynamic> toMap() {
    return {
      'id':            id,
      'name':          name,
      'email':         email,
      // you probably won't send passwordHash from the client
      'password_hash': passwordHash,
      'is_verified':   isVerified,
      'created_at':    createdAt.toIso8601String(),
    };
  }

  /// Helper for copying & modifying
  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? passwordHash,
    bool? isVerified,
    DateTime? createdAt,
  }) {
    return AppUser(
      id:           id ?? this.id,
      name:         name ?? this.name,
      email:        email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      isVerified:   isVerified ?? this.isVerified,
      createdAt:    createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'AppUser(id: $id, name: $name, email: $email, isVerified: $isVerified, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppUser && other.id == id);
  }

  @override
  int get hashCode => id.hashCode;
}
