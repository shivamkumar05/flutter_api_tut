import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThreeP2 extends StatefulWidget {
  @override
  State<ExampleThreeP2> createState() => _ExampleThreeP2State();
}

class _ExampleThreeP2State extends State<ExampleThreeP2> {
  @override
  var data;
  Future<void> getUsers() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(data[index]['name'].toString()),
                            Text(data[index]['username'].toString()),
                            Text(data[index]['address']['city'].toString()),
                            Text(data[index]['address']['geo']['lat']
                                .toString()),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
