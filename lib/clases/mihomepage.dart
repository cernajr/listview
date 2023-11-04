import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listview/clases/post.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key});
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  Future<List<Post>> postsFuture = getPosts();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: postsFuture, 
          builder: (context, snapshot){
            if (snapshot.connectionState==ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData){
              final posts = snapshot.data!;
              return buildPost(posts);
            } else {
              return const Text("No data available");
            }
          }),
      ),
    );
  }

  static Future<List<Post>> getPosts() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
    final response =
      await http.get(url,headers: {"Content-Type": "aplication/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Post.fromJson(e)).toList();
  }
}

Widget buildPost(List<Post> posts){
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (BuildContext context, int index){
      final post = posts[index];
      return Container(
        color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(children: [
            Expanded(flex: 1, child: Image.network(post.url!)),
              const SizedBox(width: 10),
              Expanded(flex: 1, child: Text(post.title!)),
          ]),
      );
    },
  );
}