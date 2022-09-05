import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //bisa dilihat disini  deklarasi users, users disini dinamic ya
  // darimana tau dinamic?
  // bisa bukak aja datanya, bentuknya adalah list dynamic
  List<dynamic> users = [];
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
            // liat dua buah deklrasi dibawah ini, ini sebnarnya
            // dibuat supaya gampang pas benran manggilnya.
            // contohnya user ini sudah termasuk user index
            // dan email ini bisa ditemukan di list user di dalam result
            // dan di dalam usr ini ada email.

            final user = users[index];
            final email = user['email'];
            final imgUrl = user['picture']['thumbnail'];

            final firstName = user['name']['first'];

            final lastName = user['name']['last'];
            final fullName = firstName + ' ' + lastName;
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CircleAvatar(
                  child: Image.network(imgUrl),
                  // child: Text('${index + 1}'),
                ),
              ),
              title: Text(fullName),
              subtitle: Text(email),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: FetchUser,
      ),
    );
  }

  void FetchUser() async {
    // pertama pastikan dulu fungsinya bisa dipanggil dengan baik,
    // print('fetch User called');

    // lalu masukkan url dari network yang dituju
    const url = "https://randomuser.me/api/?results=10";
    // kalau http ini dia gabisa nerima url secara langsung jadi
    // harus di parse dulu jadi uri
    final uri = (Uri.parse(url));

    // disini kita harus pakai future karena setiap pengambukan api
    //butuh waktu yang lumayan lama, jadi future adlah pilihan yang tepat
    final response = await http.get(uri);

    //disini kita ingin mengambil body dari data apinya, jadi
    final body = response.body;
    //coba print dan liat hasilnya
    // print(body);

    //parses the string and return the resulting json object
    // mengubah json string jadi array
    final json = jsonDecode(body);
    // print(json);

    setState(() {
      //kenapa gini, si json result ini bentuknya list dengan tipe data dynamic, jadi kita butuh
      // jadi kita butuh variable untuk menampungnya, dan kita buatlah ini
      //   List<dynamic> users = [];
      // cba aj print  nanti udah muncul list data dari isi result
      users = json['results'];
    });

    print(users);
  }
}
