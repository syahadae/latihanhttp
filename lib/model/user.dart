import 'package:latihanhttp/model/user_dob.dart';
import 'package:latihanhttp/model/user_location.dart';
import 'package:latihanhttp/model/user_name.dart';

class User {
  final String gender;
  final String email;
  final String cell;
  final String nat;
  final String phone;
  final UserName name;
  final UserDob dob;
  final UserLocation location;

  User({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.name,
    required this.dob,
    required this.location,
  });

  factory User.fromMap(Map<String, dynamic> json) {
//object userame
    final name = UserName.fromMap(json['name']);
    // object dob
    final date = json['dob']['date'];
    final dob = UserDob.fromMap(json['dob']);
    final location = UserLocation.fromMap(json['location']);
    return User(
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      cell: json['cell'],
      nat: json['nat'],
      dob: dob,
      name: name,
      location: location,
      // title: e['title'],
      // first: e['first'],
      // last: e['last']
    );
  }

  String get fullName {
    return '${name.title} ${name.first}${name.last}';
  }
}
