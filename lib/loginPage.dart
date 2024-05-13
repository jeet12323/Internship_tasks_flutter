import 'package:flutter/material.dart';
import 'package:internship_task1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'myHomePage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isConnected=true;
  final _formKey = GlobalKey<FormState>();
  var emailText = TextEditingController();
  var passText = TextEditingController();
  // Regular expression for email validation
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  // Regular expression for password validation
  final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("hello"),
      ),
      body: Center(
        child: Container(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailText,
                  decoration: InputDecoration(
                      hintText: "Enter email",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 2,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2,
                          )),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          )),

                      prefixIcon: Icon(
                        Icons.email,
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                Container(height: 15),
                TextFormField(
                  controller: passText,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter pass",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (!passwordRegex.hasMatch(value)) {
                      return 'Password must be at least 8 characters long and contain at least one letter and one number';
                    }
                    // Add more specific password validation if needed
                    return null;
                  },
                ),
                SizedBox(height:10),
                ElevatedButton(
                  onPressed: () async {
                    print(isConnected);

                      isConnected=await InternetConnection().hasInternetAccess;


                    print(isConnected);
                    if(isConnected) {
                      if (_formKey.currentState!.validate()) {
                        var sharedPref = await SharedPreferences.getInstance();
                        sharedPref.setBool("login", true);

                        String uEmail = emailText.text.toString();
                        String uPass = passText.text;
                        print(uEmail);
                        print(uPass);
                      }

                      setState(() {
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, perform your action here
                          whereToGo(context);
                        }
                      });
                    }
                    else{

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('No Internet'),
                            content: Text('Please connect to the internet and try again.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );

                      print('no internet');

                    }

                  },
                  child: Text("login"),

                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
