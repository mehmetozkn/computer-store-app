import 'package:computer_store_app/core/base/model/base_model.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable with IdModel, BaseModel<UserModel> {
  int? id;
  String? name;
  String? surname;
  String? email;

  UserModel({
    this.id,
    this.name,
    this.surname,
    this.email,
  });

  @override
  List<Object?> get props => [id, name, surname, email];

  UserModel copyWith({
    int? id,
    String? name,
    String? surname,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
    };
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      email: json['email'] as String?,
    );
  }
}
