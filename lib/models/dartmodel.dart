import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class Users {
  String username;
  int admin;

  Users(this.username, this.admin);

  Users.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        admin = json['admin'];

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'admin': admin,
      };

//  print('Howdy, ${user.name}!');
//  print('We sent the verification link to ${user.email}.');
}