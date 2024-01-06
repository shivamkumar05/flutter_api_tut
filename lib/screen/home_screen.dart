import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_api_tut/Model/posts_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postsList =
      []; //if the api we have that dont have name of array then we have to create custom array
  /*
    Json format example 
    [   //no name of this array is given
      {
      "userId": 1,
      "id": 1,
      "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
      "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
      },
      {
      "userId": 1,
      "id": 2,
      "title": "qui est esse",
      "body": "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
      },
    ]

  */

  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postsList.clear();
      for (Map i in data) {
        postsList.add(PostsModel.fromJson(i));
      }
      return postsList;
    } else {
      return postsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Tutorial'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              //this widget will wait for response to build on screen
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('Loading');
                } else {
                  return ListView.builder(
                    itemCount: postsList.length,
                    itemBuilder: (context, index) {
                      // return Text(index.toString());
                      // return Text(postsList[index].title.toString());

                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Title\n' + postsList[index].title.toString()),
                            Text(
                                '*****************************************************'),
                            SizedBox(
                              height: 3,
                            ),
                            Text('Description\n' +
                                postsList[index].body.toString()),
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



/*
  Future<List<PostsModel>> getPostApi() async {: This line defines a function named getPostApi(). The function returns a Future that eventually resolves to a list of PostsModel objects. The async keyword indicates that this function is asynchronous and can use await inside its body to wait for asynchronous operations.

final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));: This line uses the http package to make a GET request to the URL 'https://jsonplaceholder.typicode.com/posts' and awaits the response. This will return a Response object that contains information about the HTTP response.

var data = jsonDecode(response.body.toString());: Here, the body of the response is extracted and converted from a JSON string to a Dart object using jsonDecode(). This assumes that the response body contains JSON data representing a list of posts.

if (response.statusCode == 200) { ... } else { ... }: This conditional statement checks if the HTTP status code of the response is 200 (which means 'OK' - the request was successful). If it is, it proceeds with handling the retrieved data; otherwise, it returns an empty list.

postsList.clear();: This line clears a list named postsList. It seems that postsList is a variable declared elsewhere, possibly as a list of PostsModel.

for (Map i in data) { postsList.add(PostsModel.fromJson(i)); }: This loop iterates through the elements in the data variable (which was decoded from the API response). For each element (assumed to be a Map), it creates a PostsModel object using the fromJson() factory method and adds it to the postsList.

return postsList;: If the response status was 200 and the data was successfully processed, the function returns the postsList containing the fetched PostsModel objects. Otherwise, if the response status was different from 200, it returns an empty or partially filled postsList (depending on the state of postsList before the API call).

This code fetches data from an API, processes it assuming it contains a list of posts in JSON format, and creates a list of PostsModel objects from that data. Finally, it returns this list as a Future that can be awaited when calling this function elsewhere in the code.

User
postsList.clear(); why we are writing this line of code and what if we dont write this line of code
ChatGPT
The line postsList.clear(); is clearing the postsList before adding new elements to it.

When this function (getPostApi()) is called multiple times or when you want to refresh the list of posts, clearing the postsList ensures that you start with an empty list before populating it with the new data fetched from the API.

If you don't write this line of code (postsList.clear();), the postsList will keep accumulating data from multiple API calls or data fetches, essentially appending new data to the existing list. This might be the desired behavior in some scenarios (like continuously adding posts without refreshing), but in other cases, such as when you want to update the list with fresh data from the API call, it might lead to unexpected behavior, duplication of entries, or incorrect data display.

Therefore, the purpose of postsList.clear(); is to ensure that you have a clean slate to start adding the new posts fetched from the API, preventing any remnants from previous data in the list.

User
for (Map i in data) { postsList.add(PostsModel.fromJson(i)); }   explain this line because i cant understand use of fromJson as we already decode json to the dart object in the line var data = jsonDecode(response.body.toString()); then what difference in these both line of code working
ChatGPT
The line var data = jsonDecode(response.body.toString()); decodes the JSON response received from the API into a Dart object. This JSON response typically represents an array of posts or a list of JSON objects.

The line for (Map i in data) { postsList.add(PostsModel.fromJson(i)); } then processes each element of this decoded data (data) assuming it's a Map, and for each Map element, it creates a PostsModel object using the fromJson factory method.

The reason for using PostsModel.fromJson(i) is related to maintaining structured data within your Dart application. While jsonDecode helps convert the entire JSON response into a Dart object (often a List or Map), sometimes, you want to convert each specific JSON object (representing a single post, in this case) into a Dart object that matches your application's defined model.

The fromJson method within PostsModel is likely a named constructor or factory method within the PostsModel class that takes a Map (which represents the JSON object) as an argument and constructs a PostsModel object from that data.

For example, let's say your PostsModel class looks something like this:

dart
Copy code
class PostsModel {
  final int id;
  final String title;
  final String body;

  PostsModel({required this.id, required this.title, required this.body});

  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
Here, the fromJson factory method in the PostsModel class takes a Map<String, dynamic> representing a post's data and constructs a PostsModel object using specific fields like id, title, and body.

So, in the loop for (Map i in data), it's iterating over each element in data (assuming each element is a Map representing a post) and using PostsModel.fromJson(i) to convert each Map element into a PostsModel object. This helps in maintaining a list of structured PostsModel objects that your application can work with, as opposed to generic Maps or Lists that might be harder to manage and work with in your code.
*/