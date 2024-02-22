import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Dio dio = Dio();


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  void getData(String url) async {
    try {
      final response = await dio.get(url);
      print(response);

    } on DioException catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            child: Text('Fetch data'),
            onPressed: () {
              getData('https://reqres.in/api/users?page=1');
            },
          ),
        ),
      ),
    );
  }
}
