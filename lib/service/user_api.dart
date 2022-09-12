import 'dart:convert';
// import 'dart:html';

import 'package:latihanhttp/model/user_dob.dart';
import 'package:latihanhttp/model/user_location.dart';

import '../model/user.dart';
import '../model/user_name.dart';

import 'package:http/http.dart' as http;

class UserApi {
  static Future<List<User>> fetchUsers() async {
    const url = "https://randomuser.me/api/?results=100";
    final uri = (Uri.parse(url));
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    // print(results);

    final users = results.map(
      (e) {
        return User.fromMap(e);
      },
    ).toList();
    return users;
    // print(results);

    // print(transformed);
    // setState(() {
    //   users = transformed;
    // });
    // print(results);

    // print(users);
    // print(transformed);
  }
}
