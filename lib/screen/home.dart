import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Latihan Http",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: FetchUser,
      ),
    );
  }

  void FetchUser() {
    print('fetch User called');
  }
}
