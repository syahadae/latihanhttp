import 'dart:convert';
import 'dart:math';
import 'package:latihanhttp/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Latihan Http",
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            // print(users.length);
            // final color =
            // user.gender == 'male' ? Colors.green : Colors.lightGreen;
            final email = user.email;
            final nat = user.nat;

            return ListTile(
              title: Text(user.name.first),
              subtitle: Text(user.phone),
              // tileColor: color,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: FetchUser,
      ),
    );
  }

  void FetchUser() async {
    const url = "https://randomuser.me/api/?results=10";
    final uri = (Uri.parse(url));
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;

    final transformed = results.map(
      (e) {
        final name = UserName(
          title: e['name']['title'],
          first: e['name']['first'],
          last: e['name']['last'],
        );
        return User(
          gender: e['gender'],
          email: e['email'],
          phone: e['phone'],
          cell: e['cell'],
          nat: e['nat'],
          name: name,
          // title: e['title'],
          // first: e['first'],
          // last: e['last']
        );
      },
    ).toList();
    // print(results);

    // print(transformed);
    setState(() {
      users = transformed;
    });
    // print(results);

    // print(users);
    // print(transformed);
  }
}
