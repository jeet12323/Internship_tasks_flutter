import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'task_3.dart';

import 'package:internship_task1/task_6.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   Future<List<dynamic>>? _futurePosts;
  Future<List<dynamic>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
      return []; // Return an empty list in case of error
    }
  }

  @override
  void initState() {
    super.initState();
    final postsFuture = fetchPosts();
    final delayFuture = Future.delayed(Duration(seconds: 3));

    _futurePosts = Future.wait([postsFuture, delayFuture]).then((List results) {
      return results[0]; // Return only the fetched posts data
    });

      _futurePosts!.then((posts) {
        if (posts.isNotEmpty) {
          // All data received, navigate to the next screen
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Task_3(posts:posts), ),);
        }
      });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          'https://cdn-icons-png.flaticon.com/512/3193/3193426.png',
          loadingBuilder: (context, child, progress) {
            return progress == null
                ? child
                : CircularProgressIndicator();
          },
          errorBuilder: (context, error, stackTrace) {
            return Text('Error loading image');
          },
        ),
      ),
    );
  }
}

