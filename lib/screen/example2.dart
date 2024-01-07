import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Example2 extends StatefulWidget {
  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  @override
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getPhotos(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data![index].url.toString()),
                      ),
                      subtitle: Text(snapshot.data![index].title.toString()),
                      title:
                          Text('Nodes:' + snapshot.data![index].id.toString()),
                    );
                  });
            },
          )),
        ],
      ),
    );
  }
}

//data model for json
class Photos {
  String? title;
  String? url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
