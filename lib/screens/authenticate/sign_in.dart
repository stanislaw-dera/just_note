import 'package:just_note/services/auth.dart';
import 'package:just_note/shared/constants.dart';
import 'package:just_note/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  final errSnackBar = SnackBar(
    content: Text('There was an error.'),
  );

  String email = '';
  String password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Sign in'),
        actions: [
          ElevatedButton(onPressed: () => {widget.toggleView()}, child: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextFormField(              decoration: textInputDecoration.copyWith(hintText: 'Email'),
                onChanged: (value) => {
                  setState(() => email = value)
                }),
            SizedBox(height: 20.0),
            TextFormField(              decoration: textInputDecoration.copyWith(hintText: 'Password'),
              onChanged: (value) => {
                setState(() => password = value)
              }, obscureText: true,),
            SizedBox(height: 20.0),
            ElevatedButton(onPressed: () async => {
              setState(() => loading = true),
              if(await _auth.signInWithEmailAndPassword(email, password) == null) {
                ScaffoldMessenger.of(context).showSnackBar(errSnackBar),
                setState(() => loading = false),
              }
            }, child: Text('Sign in'))
          ],
        ),
      ),
    );
  }
}
