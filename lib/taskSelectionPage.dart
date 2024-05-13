import 'package:flutter/material.dart';

class TaskSelectionPage extends StatelessWidget {
  const TaskSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Selection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TaskButton(
              title: 'Task 3',
              routeName: '/task3',
            ),
            TaskButton(
              title: 'Task 4',
              routeName: '/task4',
            ),
            TaskButton(
              title: 'Task 5',
              routeName: '/task5',
            ),
            TaskButton(
              title: 'Task 6',
              routeName: '/task6',
            ),
          ],
        ),
      ),
    );
  }
}

class TaskButton extends StatelessWidget {
  final String title;
  final String routeName;

  const TaskButton({
    Key? key,
    required this.title,
    required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Text(title),
      ),
    );
  }
}
