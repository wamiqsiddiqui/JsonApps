import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class loggedin extends StatefulWidget {
  _loggedinState createState() => _loggedinState();
}

/*
class StudentList {
  final List<Student> students;

  StudentList({
    this.students,
  });

  factory StudentList.fromJson(List<dynamic> parsedJson) {

    List<Student> students = new List<Student>();
    students = parsedJson.map((i)=>Student.fromJson(i)).toList();

    return new StudentList(
        students: students
    );
  }
}

class Student{
  final String id;
  final String survey_room_id;
  final String student;
  final String survey_room;

  Student({
    this.id,
    this.survey_room_id,
    this.student,
    this.survey_room,
  }) ;

  factory Student.fromJson(Map<String, dynamic> json){
    return new Student(
      id: json['id'].toString(),
      survey_room_id: json['survey_room_id'],
      student: json['student'],
      survey_room: json['survey_room'],
    );
  }

}
*/
class Post1 {
  final id,
      user_id,
      university_id,
      student_id,
      student_name,
      father_name,
      semester,
      year,
      student_registration_id,
      phone_no,
      is_archive,
      is_active,
      created_by,
      updated_at,
      student_survey_count,
      university,
      user;

  Post1({
    this.id,
    this.user_id,
    this.university_id,
    this.student_id,
    this.student_name,
    this.father_name,
    this.semester,
    this.year,
    this.student_registration_id,
    this.phone_no,
    this.is_archive,
    this.is_active,
    this.created_by,
    this.updated_at,
    this.student_survey_count,
    this.university,
    this.user,
  });

  factory Post1.fromJson(Map<String, dynamic> json) {
    return new Post1();
  }
}

class Post2 {
  final id,
      user_id,
      university_id,
      student_id,
      student_name,
      father_name,
      semester,
      year,
      student_registration_id,
      phone_no,
      is_archive,
      is_active,
      created_by,
      updated_at,
      student_survey_count,
      university,
      user;

  Post2({
    this.id,
    this.user_id,
    this.university_id,
    this.student_id,
    this.student_name,
    this.father_name,
    this.semester,
    this.year,
    this.student_registration_id,
    this.phone_no,
    this.is_archive,
    this.is_active,
    this.created_by,
    this.updated_at,
    this.student_survey_count,
    this.university,
    this.user,
  });

  factory Post2.fromJson(Map<String, dynamic> json) {
    return new Post2();
  }
}
class _loggedinState extends State<loggedin> {
  Map data, student;
  List userData, userStudentList, userlist1,userlist2;
  File _image, _previmage;
  var flag = 0;

  void initState() {
    super.initState();
    getData();
    //getStudentsList();
    // loadStudent();
    fetchPosts();
    fetchPosts2();
  }

  Future <List<Post2>>fetchPosts() async {
    http.Response response =
    await http.get('http://pharmevo.wishhealthsciences.com/students');
    userlist1 = json.decode(response.body);
    (userlist1 as List).map((p) => Post1.fromJson(p)).toList();
    print(userlist1.toString());
    return userlist1;
  }
  Future fetchPosts2() async {
    http.Response response =
    await http.get('http://pharmevo.wishhealthsciences.com/students-survey');
    userlist2 = json.decode(response.body);
    (userlist2 as List).map((p) => Post2.fromJson(p)).toList();
    print(userlist2.toString());
  }

/*
  Future loadStudent() async {
    http.Response response= await http.get("http://pharmevo.wishhealthsciences.com/students-survey");
    final datas = json.decode(response.body);
    Student s=new Student.fromJson(datas);
    StudentList student = new StudentList.fromJson(datas);
    print(student.students);
  }*/

  Future getData() async {
    http.Response response =
    await http.get("https://reqres.in/api/users?page=2");
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
    // print(response.body);
  }

/*
  Future getStudentsList() async {
    http.Response response= await http.get("http://pharmevo.wishhealthsciences.com/students-survey");
    print(response.body);
    var responseJson = json.decode(response.body);
    return (responseJson['metcheckData']['forecastLocation']['forecast'] as List)
        .map((p) => Student.fromJson(p))
        .toList();
 /*   student=json.decode(response.body);
    setState((){
      userStudentList=student[0]["student"];
    });
    print(userStudentList.toString()); */
  }
*/
  @override
  Widget build(BuildContext context) {
    Future getImagefromCamera() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
      });
    }

    Future getImagefromGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }

    Future uploadPic() async {
      String filename = basename(_image.path);
      StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child(filename);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print("Profile picture Uploaded");
        //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Profile picture Uploaded")));
      });
    }

    return MaterialApp(
      title: 'Flutter Google Signin APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff9C58D2),
      ),
      home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "Netflix Shows",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red.shade900,
              bottom: TabBar(isScrollable: true, tabs: [
                Tab(
                  child: Text("Peaky Blinders"),
                ),
                Tab(child: Text("Internet Data")),
                Tab(child: Text("Insert Image")),
                Tab(child: Text("Serveys"))
              ]),
            ),
            body: TabBarView(
              children: [
                new Card(
                  color: Colors.pink,
                  child: OrientationBuilder(builder: (context, orientation) {
                    return GridView.count(
                      crossAxisCount:
                      orientation == Orientation.portrait ? 2 : 3,
                      crossAxisSpacing: 2,
                      children: List.generate(
                        6,
                            (index) {
                          return Image.asset(
                            "assets/pb$index.png",
                            width: 200,
                            height: 200,
                          );
                        },
                      ),
                    );
                  }),
                ),
                new Card(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: userlist1 == null ? 0 : userlist1.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "$index",
                            ),
                            SizedBox(width: 10),
                            Text(
                              userlist1[index]["university"]["university_name"] +
                                  userlist1[index]["father_name"],
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Email:" + userlist1[index]["semester"],
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                new Card(
                  child: Builder(
                      builder: (context) => Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.pink.shade900,
                                      child: ClipOval(
                                          child: SizedBox(
                                              width: 113,
                                              height: 113,
                                              child: (_image != null)
                                                  ? Image.file(
                                                _image,
                                                fit: BoxFit.fill,
                                              )
                                                  : Icon(
                                                FontAwesomeIcons.user,
                                                size: 70,
                                                color: Colors.white,
                                              ))),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(top: 60),
                                    child: IconButton(
                                        icon: Icon(FontAwesomeIcons.camera),
                                        onPressed: getImagefromCamera)),
                                Padding(
                                    padding: EdgeInsets.only(top: 60),
                                    child: IconButton(
                                        icon: Icon(FontAwesomeIcons.images),
                                        onPressed: getImagefromGallery)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Username",
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Muhammad Wamiq Siddiqui",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                      child: Icon(
                                        FontAwesomeIcons.pen,
                                        color: Colors.blue,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Birthday",
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "21/June/1998",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.pen,
                                          color: Colors.blue,
                                        ),
                                        onPressed: null)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Location",
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 18)),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Karachi, Pakistan",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20)),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.pen,
                                          color: Colors.blue,
                                        ),
                                        onPressed: null)),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RaisedButton(
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(10.0),
                                        side: BorderSide(
                                            color: Colors.pink.shade900,
                                            width: 2)),
                                    color: Colors.pink.shade900,
                                    onPressed: uploadPic,
                                  ),
                                  RaisedButton(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(
                                            10.0)),
                                    color: Colors.pink.shade900,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ])
                          ],
                        ),
                      )),
                ),
                new Card(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      /* STUDENT LIST DATA
                      *
                      *
                      *
                      *
                      * */
                      Container(
                        width: 1500,
                        height: 600,
                        child: ListView(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(11),
                                child: Container(
                                  decoration: new BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  width: 1500,
                                  height: 33,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "No.",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Id",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Name",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Semester",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Year",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "University",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Campus",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Email",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Phone",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Registered At",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 11, left: 11, bottom: 18),
                              child: Container(
                                decoration: new BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                width: 1500,
                                height: 480,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(11),
                                  shrinkWrap: true,
                                  itemCount:
                                  userlist1 == null ? 0 : userlist1.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      color: Colors.deepPurple,
                                      elevation: 12,
                                      // child: Padding(
                                      // padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "$index",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 18),
                                          Text(
                                            userlist1[index]["id"].toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist1[index]["student_name"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist1[index]["semester"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist1[index]["year"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist1[index]["university"]
                                            ["university_name"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist1[index]["university"]
                                            ["campus"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist1[index]["user"]["email"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist1[index]["phone_no"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist1[index]["created_at"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      // ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),

                      /*        S  T  U  D  E  N  T
                                  S  U  R  V  E  Y
                                R  E  P  O  R  T
                                   D  A  T  A        */
                      Container(
                        width: 1500,
                        height: 600,
                        child: ListView(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(11),
                                child: Container(
                                  decoration: new BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  width: 1500,
                                  height: 33,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "No.",
                                        style:TextStyle(
                                            fontSize: 16,color:Colors.white
                                        ),
                                      ),
                                      Text(
                                        "Date Time",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Student",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "University",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Question Count",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Survey Code",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Room",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      Text(
                                        "Conducted By",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 11, left: 11, bottom: 18),
                              child: Container(
                                decoration: new BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                width: 1500,
                                height: 480,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(11),
                                  shrinkWrap: true,
                                  itemCount:
                                  userlist2 == null ? 0 : userlist2.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      color: Colors.blueGrey,
                                      elevation: 12,
                                      // child: Padding(
                                      // padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "$index",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 18),
                                          Text(
                                            userlist2[index]["student"]["student_survey"][index]["created_at"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist2[index]["student"]["student_name"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist2[index]["survey_room"]["room"]["university"]["university_name"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist2[index]["student"]["student_survey_count"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist2[index]["survey_room"]["unique_code"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist2[index]["survey_room"]["room"]["room_name"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            userlist2[index]["survey_room"]["conducted_by"]["name"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      // ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
