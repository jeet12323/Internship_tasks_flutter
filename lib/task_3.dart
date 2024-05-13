import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internship_task1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'myHomePage.dart';

class Task_3 extends StatefulWidget {
  final List<dynamic> posts; // Define the parameter to hold the posts data

  const Task_3({Key? key, required this.posts}) : super(key: key);

  @override
  State<Task_3> createState() => _Task_3State();
}
class _Task_3State extends State<Task_3>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(widget.posts[index]['title']),
                          content: Text(widget.posts[index]['body']),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('close'),
                            ),
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
                          (widget.posts[index]['title'].toString().length > 20)
                              ? '${widget.posts[index]['title'].toString().substring(0, 20)}...'
                              : widget.posts[index]['title'].toString(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: Text('logout'),
              onPressed: () async {
                var sharedPref = await SharedPreferences.getInstance();
                sharedPref.setBool("login", false);
                setState(() {
                  whereToGo(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }


}

