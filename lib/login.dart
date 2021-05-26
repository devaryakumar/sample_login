import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'extensions.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _auth = FirebaseAuth.instance;
  var _loading = false;
  var emailCOntroller = TextEditingController();
  var pwdController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailCOntroller,
                validator: (email) {
                  // if (email!.isEmail()) {
                  //   return null;
                  // } else {
                  //   return 'Enter a valid email';
                  // }
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                controller: pwdController,
                validator: (password) {
                  return password.isPasswordValid();
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              if (!_loading)
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _loading = true;
                      });
                      await _auth
                          .createUserWithEmailAndPassword(
                            email: emailCOntroller.text,
                            password: pwdController.text,
                          )
                          .then((value) => setState(() {
                                _loading = false;
                              }));
                    }
                  },
                  child: Text(
                    'Create Account',
                  ),
                )
              else
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
