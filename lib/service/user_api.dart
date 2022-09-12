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
        //object userame
        final name = UserName(
          title: e['name']['title'],
          first: e['name']['first'],
          last: e['name']['last'],
        );
        // object dob
        final date = e['dob']['date'];
        final dob = UserDob(
          // date: e['dob']['date'],
          date: DateTime.parse(date),
          age: e['dob']['age'],
        );
        final coordinates = LocationCoordinate(
          latitude: e['location']['coordinates']['latitude'],
          longitude: e['location']['coordinates']['longitude'],
        );
        final street = LocationStreet(
          name: e['location']['street']['name'],
          number: e['location']['street']['number'],
        );
        final timezone = LocationTimezone(
          offset: e['location']['timezone']['offset'],
          description: e['location']['timezone']['description'],
        );
        final location = UserLocation(
          city: e['location']['city'],
          country: e['location']['country'],
          postcode: e['location']['postcode'].toString(),
          state: e['location']['state'],
          coordinates: coordinates,
          street: street,
          timezone: timezone,
        );
        return User(
          gender: e['gender'],
          email: e['email'],
          phone: e['phone'],
          cell: e['cell'],
          nat: e['nat'],
          dob: dob,
          name: name,
          location: location,
          // title: e['title'],
          // first: e['first'],
          // last: e['last']
        );
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
