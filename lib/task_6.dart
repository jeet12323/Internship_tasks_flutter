import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Todo {
  final int id;
  final int userId;
  final String title;
  final bool completed;

  Todo({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}
class task_6 extends StatefulWidget {
  @override
  _task_6State createState() => _task_6State();
}

class _task_6State extends State<task_6> {
  late List<Todo> todos = [];
  late List<Todo> filteredTodos = [];

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    print(response.body);
    print("J");
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      print(jsonResponse);
      print("j");
      todos = jsonResponse.map((data) => Todo.fromJson(data)).toList();
      print(todos[0].id);
      print("j");
      filteredTodos = List.from(todos);
      print(filteredTodos[0].id);
      setState(() {});
    } else {
      throw Exception('Failed to load todos');
    }
  }

  void search(String query) {
    setState(() {
      filteredTodos = todos.where((todo) => todo.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void sortById() {
    setState(() {
      filteredTodos.sort((a, b) => a.id.compareTo(b.id));
    });
  }

  void toggleFilter(bool value) {
    setState(() {
      filteredTodos = value ? todos.where((todo) => todo.completed).toList() : List.from(todos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: sortById,
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Completed'),
                value: true,
              ),
              PopupMenuItem(
                child: Text('Incomplete'),
                value: false,
              ),
            ],
            onSelected: (value) {
              toggleFilter(value as bool);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            onChanged: search,
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTodos.length,
              itemBuilder: (context, index) {
                final todo = filteredTodos[index];
                return ListTile(
                  title: Text(todo.id.toString()),
                  subtitle: Text('Completed: ${todo.completed}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}