import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jsonapp/loggedin.dart';
import 'package:jsonapp/accountcreate.dart';
import 'package:jsonapp/alltasks.dart';
import 'package:jsonapp/serveySearch.dart';

class signinwithemail extends StatefulWidget {
  @override
  _signinwithemailState createState() => _signinwithemailState();
}

class _signinwithemailState extends State<signinwithemail> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: new Text("Sign in with Email"),
        backgroundColor: Colors.pink.shade800,
      ),
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if (input.contains("@")) {
                  return null;
                } else {
                  return "Invalid Email format";
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              validator: (input) {
                if (input.length < 6) {
                  return "Your password must have atleast 6 characters";
                } else {
                  return null;
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: signIn,
              child: Text(
                "Sign In",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.pink,
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => loggedin()));
              },
              child: Text(
                "View Netflix Shows details",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.pink,
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => alltasks()));
              },
              child: Text(
                "Add Tasks",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.pink,
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Surveysearch()));
              },
              child: Text(
                "Survey Search",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              color: Colors.pink,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => accountcreate()));
              },
              child: new Text(
                "Don't have an account? SignUp",
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> signIn() async {
    FirebaseUser user;
    AuthResult result;
    final formState = _formkey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        user = result.user;
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => alltasks()));
        return user;
      } catch (e) {
        print(e.message);
        return null;
      }
    } else {
      print("else clause");
      return null;
    }
  }
}