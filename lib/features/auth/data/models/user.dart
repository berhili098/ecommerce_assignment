import 'package:ecommerce_assignment/features/auth/domain/entities/user.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'phone': phone, 'address': address};
  }

  User toEntity() {
    return User(id: id, name: name, email: email, phone: phone, address: address);
  }

  static UserModel fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      address: user.address,
    );
  }
}
