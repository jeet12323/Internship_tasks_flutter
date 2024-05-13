import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
void whereToGo(BuildContext context) async {
  var sharedPref = await SharedPreferences.getInstance();
  var isLoggedIn = sharedPref.getBool("login");

  if (isLoggedIn != null) {
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(
          context,
        '/taskSelection');
    } else {
      Navigator.pushReplacementNamed(
          context,
         '/login');
    }
  }
  else {
    Navigator.pushReplacementNamed(
        context,
        '/login');
  }
  }

class _MyHomePageState extends State<MyHomePage> {
  var emailText = TextEditingController();
  var passText = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    whereToGo(context);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body:Center(child: Text("loading"),)

    );
  }
}


