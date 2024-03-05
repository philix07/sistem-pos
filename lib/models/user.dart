import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  final String uid;
  final String email;
  final String name;
  final UserRole role;
  final DateTime createdAt;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.role,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'role': role.value,
      'createdAt' : createdAt,
    };
  }

  factory AppUser.dummy() {
    return AppUser(
      uid: 'dummy',
      email: 'abcd@gmail.com',
      name: 'anonymous',
      role: UserRole.none,
      createdAt: DateTime.now(),
    );
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    //* Convert Timestamp to DateTime (Firebase only stores Timestamp)
    var createdTimestamp = map['createdAt'] as Timestamp;
    var createdAt = createdTimestamp.toDate();
    
    return AppUser(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      role: UserRole.fromString(map['role']),
      createdAt: createdAt,
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
