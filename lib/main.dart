import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// initializing dio object
// dio will be used for the network call
Dio dio = Dio();

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Reqres users'),
        ),
        body: ListOfData(),
      ),
    );
  }
}

class ListOfData extends StatefulWidget {
  const ListOfData({super.key});

  @override
  State<ListOfData> createState() => _ListOfDataState();
}

class _ListOfDataState extends State<ListOfData> {
  // state variable marked as late which will be updated with the list of data
  late List<dynamic> listOfData;

  void getData(String url) async {
    // defining Response type variable, to store the response from the network call
    Response response;

    try {
      // getting the data using get method
      response = await dio.get(url);
      // print(response.data);
      listOfData = response.data["data"];
      setState(() {});
    } on DioException catch (e) {
      print(e);
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // initializing the listOfData variable with empty list
    listOfData = [{}];

    // calling getData when state is initialized, to make sure the data gets populated onto the UI
    getData('https://reqres.in/api/users?page=1');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listOfData.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: listOfData[index]["avatar"] != null
              ? Image.network(
                listOfData[index]["avatar"],
              )
              : Text("Image"),
          trailing: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              "${listOfData[index]["id"] ?? "ID"}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          title: Text(
            listOfData[index] != null
                ? "${listOfData[index]['first_name']} ${listOfData[index]['last_name']}"
                : "First_name Last_name",
          ),
          subtitle: Text(
            listOfData[index] != null
                ? "${listOfData[index]['email']}"
                : "Email",
          ),
          contentPadding: EdgeInsets.all(12.0),
        );
      },
    );
  }
}
