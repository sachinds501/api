import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'allusers.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String stringResponse = "";
  Map? mapResponse;
  Map? dataResponse;

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        // stringResponse = response.body;
        mapResponse = json.decode(response.body);
        dataResponse = mapResponse!['data'][2]; // Fetching 3rd user data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                color: Colors.blue,
                width: 250,
                child: dataResponse == null
                    ? const Text("Data is Loading")
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(dataResponse!['avatar'].toString()),
                          Text("Firstname : ${dataResponse!['first_name']}"),
                          Text("Id : ${dataResponse!['id'].toString()}"),
                          Text("Email : ${dataResponse!['email'].toString()}"),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => AllUsers())));
                              },
                              child: const Text(
                                "View all users",
                                style: TextStyle(color: Colors.black),
                              ))
                        ],
                      )),
          ],
        ),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
