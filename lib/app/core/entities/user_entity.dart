import 'package:floor/floor.dart';

import 'base_entity.dart';

@Entity(tableName: 'users')
class UserEntity extends BaseEntity {
  final String email;
  final String password;
  final String token;
  final String name;
  final String birthday;
  final String cpf;
  final String zipcode;
  final String address;
  final int number;

  UserEntity({
    this.email,
    this.password,
    this.token,
    this.name,
    this.birthday,
    this.cpf,
    this.address,
    this.number,
    this.zipcode,
    int id,
    String createdAt,
    String updatedAt,
    String deletedAt,
  }) : super(id, createdAt, updatedAt, deletedAt);

  UserEntity copyWith({
    String id,
    String email,
    String password,
    String token,
    String name,
    String birthday,
    String cpf,
    String zipcode,
    String address,
    int number,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      cpf: cpf ?? this.cpf,
      zipcode: zipcode ?? this.zipcode,
      address: address ?? this.address,
      number: number ?? this.number,
    );
  }

  @override
  String toString() {
    return 'UserEntity(email: $email, password: $password, token: $token, name: $name, birthday: $birthday, cpf: $cpf, zipcode: $zipcode, address: $address, number: $number, id: $id)';
  }
}
