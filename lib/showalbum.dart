import 'dart:convert';
import 'package:flutter/material.dart';
import 'album.dart';
import 'package:http/http.dart' as http;

class Showalbum extends StatefulWidget {
  final Album album;

  const Showalbum({super.key, required this.album});

  @override
  State<Showalbum> createState() => _ShowalbumState();
}

class _ShowalbumState extends State<Showalbum> {
  late Future<List<Album>> postFuture;

  @override
  void initState() {
    super.initState();
    postFuture = getPosts();
  }

  static Future<List<Album>> getPosts() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    final List body = json.decode(response.body);
    return body.map((item) => Album.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.album.title ?? 'Album')),
      body: FutureBuilder<List<Album>>(
        future: postFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return buildPosts(snapshot.data!);
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  Widget buildPosts(List<Album> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final album = posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    album.thumbnailUrl ?? 'https://via.placeholder.com/150',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(flex: 3, child: Text(album.title ?? 'No title')),
              ],
            ),
          ),
        );
      },
    );
  }
}
