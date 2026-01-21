class UserModel {
  final String id;
  final String name;
  final String email;
  final DateTime joinDate;
  final String accountType;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.joinDate,
    this.accountType = 'Free',
  });

  // Create a user from JSON (for future API integration)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      joinDate: json['joinDate'] != null
          ? DateTime.parse(json['joinDate'])
          : DateTime.now(),
      accountType: json['accountType'] ?? 'Free',
    );
  }

  // Convert user to JSON (for future API integration)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'joinDate': joinDate.toIso8601String(),
      'accountType': accountType,
    };
  }

  // Copy with method for updating user data
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? joinDate,
    String? accountType,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      joinDate: joinDate ?? this.joinDate,
      accountType: accountType ?? this.accountType,
    );
  }
}
