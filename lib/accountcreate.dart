import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jsonapp/loggedin.dart';
import 'package:jsonapp/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:jsonapp/newtask.dart';

class accountcreate extends StatefulWidget {
  @override
  _accountcreateState createState() => _accountcreateState();
}

class _accountcreateState extends State<accountcreate> {
  String _firstname,
      _lastname,
      _email,
      _password,
      _retypepass,
      _phone,
      _university;
  var formStates;
  final GlobalKey<FormState> formkeys = GlobalKey<FormState>();
  final DocumentReference documentReference =
  Firestore.instance.document("eventdata/users");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: new Text(
            "Create an Account",
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Colors.pink,
          // toolbarOpacity: 0,
        ),
        body: Stack(
          children: <Widget>[
            Form(
              key: formkeys,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  SizedBox(height: 30),
                  Theme(
                    data: new ThemeData(
                      primaryColor: Colors.black12,
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          icon: Icon(
                            Icons.account_circle,
                            color: Colors.pink,
                            size: 30,
                          ),
                          border: UnderlineInputBorder(),
                          labelText: "First Name",
                          labelStyle:
                          TextStyle(color: Colors.black, fontSize: 18),
                          contentPadding: EdgeInsets.all(9)),
                      onSaved: (input) => _firstname = input,
                      validator: (input) {
                        if (input.length == 0) {
                          return "Please enter your first name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: new ThemeData(
                      primaryColor: Colors.white,
                      primaryColorDark: Colors.yellowAccent,
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        icon: Icon(
                          Icons.account_circle,
                          color: Colors.pink,
                          size: 30,
                        ),
                        border: UnderlineInputBorder(),
                        labelText: "Last Name",
                        labelStyle:
                        TextStyle(color: Colors.black, fontSize: 18),
                        contentPadding: EdgeInsets.all(9),
                      ),
                      onSaved: (input) => _lastname = input,
                      validator: (input) {
                        if (input.length == 0) {
                          return "Please enter your last name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: new ThemeData(
                      primaryColor: Colors.black,
                      primaryColorDark: Colors.yellowAccent,
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        icon: Icon(
                          Icons.email,
                          color: Colors.pink,
                          size: 30,
                        ),
                        border: UnderlineInputBorder(),
                        labelText: "Email",
                        labelStyle:
                        TextStyle(color: Colors.black, fontSize: 18),
                        hintText: "abc@gmail.com",
                        hintStyle: TextStyle(color: Colors.black),
                        contentPadding: EdgeInsets.all(9),
                      ),
                      onSaved: (input) => _email = input,
                      validator: (input) {
                        if (input.contains("@")) {
                          return null;
                        } else {
                          return "Incorrect email format";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: new ThemeData(
                      primaryColor: Colors.black,
                      primaryColorDark: Colors.yellowAccent,
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        icon: Icon(
                          Icons.security,
                          color: Colors.pink,
                          size: 30,
                        ),
                        border: UnderlineInputBorder(),
                        labelText: "Password",
                        labelStyle:
                        TextStyle(color: Colors.black, fontSize: 18),
                        contentPadding: EdgeInsets.all(9),
                      ),
                      onSaved: (input) => _password = input,
                      validator: (input) {
                        if (input.length < 6) {
                          return "Your password must contain atleast 6 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: new ThemeData(
                      primaryColor: Colors.black,
                      primaryColorDark: Colors.yellowAccent,
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        icon: Icon(
                          Icons.star,
                          color: Colors.pink,
                          size: 30,
                        ),
                        border: UnderlineInputBorder(),
                        labelText: "Re-type Password",
                        labelStyle:
                        TextStyle(color: Colors.black, fontSize: 18),
                        contentPadding: EdgeInsets.all(9),
                      ),
                      onSaved: (input) => _retypepass = input,
                      validator: (input) {
                        keyFunc();
                        if (_password == _retypepass) {
                          return null;
                        } else {
                          return "Password didnot match";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Theme(
                    data: new ThemeData(
                      primaryColor: Colors.black,
                      primaryColorDark: Colors.yellowAccent,
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        icon: Icon(
                          Icons.phone,
                          color: Colors.pink,
                          size: 30,
                        ),
                        border: UnderlineInputBorder(),
                        labelText: "Phone No.",
                        labelStyle:
                        TextStyle(color: Colors.black, fontSize: 18),
                        contentPadding: EdgeInsets.all(9),
                      ),
                      onSaved: (input) => _phone = input,
                      validator: (input) {
                        if (input.length == 0) {
                          return "Please enter yout phone number";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Theme(
                    data: new ThemeData(
                      primaryColor: Colors.black,
                      primaryColorDark: Colors.yellowAccent,
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        icon: Icon(
                          Icons.book,
                          color: Colors.pink,
                          size: 30,
                        ),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "University",
                        labelStyle:
                        TextStyle(color: Colors.black, fontSize: 18),
                        contentPadding: EdgeInsets.all(9),
                      ),
                      onSaved: (input) => _university = input,
                      validator: (input) {
                        if (input.length == 0) {
                          return "Please enter your university name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    onPressed: create,
                    child: new Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  GoogleSignApp()));
                    },
                    child: new Text(
                      "Already have an account? SignIn",
                      style: TextStyle(color: Colors.pink, fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void keyFunc() {
    var formState = formkeys.currentState;
    formState.save();
  }

  Future<FirebaseUser> create() async {
    FirebaseUser user;
    AuthResult result;
    var formState = formkeys.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        Map<String, String> participants = <String, String>{
          "FirstName": _firstname,
          "LastName": _lastname,
          "Email": _email,
          "Password": _password,
          "PhoneNo": _phone,
          "University": _university
        };
        documentReference.setData(participants).whenComplete(() {
          print("Document added");
        }).catchError((e) => print(e));
        result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        user = result.user;
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => loggedin()));
        return user;
      } catch (e) {
        print("Wamiq" + e.message);
        return null;
      }
    } else {
      print("Didnot validate");
      return null;
    }
  }

  Widget _myAppBar() {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFFA7397),
            const Color(0xFFFDDE42),
          ],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1, 0),
          stops: [0, 1],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    child: Text(
                      "New Tasks",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
