import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  String stringResponse = "";
  Map? mapResponse;
  Map? dataResponse;
  List? users;

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
        users = mapResponse!['data']; //  fetching all users data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All Users"),
        ),
        body: dataResponse == null
            ? const Text("Data is Loading")
            : ListView.builder(
                itemCount: users!.length,
                itemBuilder: ((context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 75,
                      child: ListTile(
                        tileColor: Colors.orange,
                        leading: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                              radius: 50,
                              child: ClipOval(
                                child: Image.network(
                                  users![index]['avatar'].toString(),
                                ),
                              )),
                        ),
                        title: Text(
                            "${users![index]['first_name']} ${users![index]['last_name']}"),
                        subtitle: Text(
                          "id : ${users![index]['id']}",
                        ),
                      ),
                    ))),
              ));
  }
}
