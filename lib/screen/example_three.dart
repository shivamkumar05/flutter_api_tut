import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_tut/Model/users.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<Users> userList = [];

  Future<List<Users>> getUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      userList.clear();
      for (Map i in data) {
        userList.add(Users.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: getUsers(),
            builder: (context, AsyncSnapshot<List<Users>> snapshot) {
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name'),
                          Text(snapshot.data![index].name.toString()),
                          Text('UseerName'),
                          Text(snapshot.data![index].username.toString()),
                          Text('Address'),
                          Text(snapshot.data![index].address!.city.toString()),
                          Text(snapshot.data![index].address!.geo!.lat
                              .toString()),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    ));
  }
}
