import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  final String uid;
  final String email;
  final String name;
  final UserRole role;

  // ... Dan Role Role Lainnya
  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'role': role.value,
    };
  }

  factory AppUser.dummy() {
    return AppUser(
      uid: '1234',
      email: 'abcd@gmail.com',
      name: 'anonymous',
      role: UserRole.none,
    );
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      role: UserRole.fromString(map['role']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum UserRole {
  none('None'),
  cashier('Cashier'),
  supervisor('Supervisor'),
  owner('Owner');

  final String value;
  const UserRole(this.value);

  static UserRole fromString(String role) {
    switch (role) {
      case 'Cashier':
        return UserRole.cashier;
      case 'Supervisor':
        return UserRole.supervisor;
      case 'Owner':
        return UserRole.owner;
      default:
        return UserRole.none;
    }
  }
}
