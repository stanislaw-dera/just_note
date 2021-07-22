import 'package:just_note/services/auth.dart';
import 'package:just_note/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:just_note/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final errSnackBar = SnackBar(
    content: Text('Wystąpił problem!'),
  );

  bool isEmail(String value) {
    RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (regex.hasMatch(value)) {
      return true;
    }
    else {
      return false;
    }

  }

  String email = '';
  String password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Register'),
        actions: [
          ElevatedButton(onPressed: () => {widget.toggleView()}, child: Text('Sign in'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => !isEmail(val!) ? 'Enter an email' : null,
                  onChanged: (value) => {
                setState(() => email = value)
              }),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (value) => {
                setState(() => password = value)
              }, obscureText: true,),
              SizedBox(height: 20.0),
              ElevatedButton(onPressed: () async => {
                if (_formKey.currentState!.validate()) {
                  setState(() => loading = true),
                  if(await _auth.registerWithEmailAndPassword(email, password) == null) {
                    setState(() => loading = false),
                    ScaffoldMessenger.of(context).showSnackBar(errSnackBar)
                  }
                }
              }, child: Text('Sign up'))
            ],
          ),
        ),
      ),
    );
  }
}
