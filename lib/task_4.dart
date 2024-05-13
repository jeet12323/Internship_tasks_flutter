import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internship_task1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'myHomePage.dart';

class Task_4 extends StatefulWidget {
  const Task_4({Key? key}) : super(key: key);

  @override
  State<Task_4> createState() => _Task_4State();
}

class _Task_4State extends State<Task_4> {
  late Future<List<dynamic>> _futurePosts;
  List<dynamic> posts=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futurePosts = fetchPosts();

  }
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
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<dynamic>>(
            future:_futurePosts,
        
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
        
                return Center(
                  child: CircularProgressIndicator(), // Loading indicator
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'), // Error message
                );
              }
              else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text('No posts available'), // Message for empty list
                );
              }
              else {
                return Column(
                
                  children: [ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),



                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(context: context, builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(snapshot.data![index]['title']),
                                content: Text(snapshot.data![index]['body']),
                                actions: [
                                  TextButton(onPressed: () {
                                    Navigator.of(context).pop();
                                  }, child: Text('close'),),

                                ],
                              );
                            },
                            );
                          },

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.orange,
                              height: 50,
                              child: Center(
                                child: Text(
                                  (snapshot.data![index]['title'].toString().length > 20)
                                      ? '${snapshot.data![index]['title'].toString().substring(0, 20)}...'
                                      : snapshot.data![index]['title'].toString(),
                                ),
                              ),
                              // subtitle: Text(posts[index]['body']),
                            ),
                          ),

                        );
                      }

                  ),
              ElevatedButton(
                    child: Text('logout'),
                    onPressed: ()async{
                      var sharedPref= await SharedPreferences.getInstance();
                      sharedPref.setBool("login", false);
                      setState(() {
                        whereToGo(context);
                      });
                      }
        
        
                  ),]
                );
              }
            }
        ),
      ),
    );
    //   body: Center(
    //     child:
    //   ),
    // );
  }
}