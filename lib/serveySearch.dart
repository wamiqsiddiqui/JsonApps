import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SurveyReport {
  final int id;
  final String user_id,
      university_id,
      student_name,
      father_name,
      semester,
      year,
      student_registration_id,
      phone_no,
      is_archive,
      is_active,
      created_by,
      updated_by,
      created_at,
      updated_at,
      student_survey_count,
      university,
      user;

  SurveyReport({this.id, this.user_id,
        this.university_id,
        this.student_name,
        this.father_name,
        this.semester,
        this.year,
        this.student_registration_id,
        this.phone_no,
        this.is_archive,
        this.is_active,
        this.created_by,
        this.updated_by,
        this.created_at,
        this.updated_at,
        this.student_survey_count,
        this.university,
        this.user});


  factory SurveyReport.fromJson(Map<String, dynamic> json) {
    return new SurveyReport();
  }
}

class Surveysearch extends StatefulWidget {
  @override
  _SurveysearchState createState() => _SurveysearchState();
}

class _SurveysearchState extends State<Surveysearch> {
  Map data, student;
  List userData, userStudentList, userlist1, userlist2;
  var selectedType;
  List<String> userlists2;
  List surveylist;
  ScrollController _scrollController = new ScrollController();
  List sr;
  List<String> _accountType = [
    "none",
    "Savings",
    "Deposit",
    "Checking",
    "Brokerage"
  ];

  void initState() {
    super.initState();
  }

  Future <List> surveyReport() async {
    http.Response response =
    await http.get("http://pharmevo.wishhealthsciences.com/students");
    surveylist= json.decode(response.body);
    //var jsonData= json.decode(response.body);
    //print(jsonData);
    Function func=(p){
     return SurveyReport.fromJson(p);
    };
    (surveylist as List).map(func).toList();
   // print(surveylist.toString());
    /* for(var surveydata in jsonData)
      {
        print(surveydata.runtimeType);
        print("Inside for loop");
        SurveyReport surveyReports=SurveyReport(surveydata['id'], surveydata['user_id'], surveydata['university_id'], surveydata['student_name'], surveydata['father_name'], surveydata['semester'], surveydata['year'], surveydata['student_registration_id'], surveydata['phone_no'], surveydata['is_archive'], surveydata['is_active'], surveydata['created_by'], surveydata['updated_by'], surveydata['created_at'], surveydata['updated_at'], surveydata['student_survey_count'], surveydata['university'], surveydata['user']);
        surveylist.add(surveyReports);
      }*/
    print("length: ${surveylist.length}");
    return surveylist;
  }

  Widget getStudentSurveyData(id, name, semester, year, university, campus,
      email, phone, registeredat) {
    return Stack(children: <Widget>[
      // The containers in the background
      Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
            width: 350,
            height: 280.0,
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Material(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(15),
                  elevation: 14.0,
                  shadowColor: Color(0x802196F3),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        name,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Id: $id",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "semester : $semester",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Year : $year",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "University : $university",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Campus : $campus",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "email : $email",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Phone : $phone",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Registered At : $registeredat",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ])),
            ),
          ),
        ),
      ]),
    ]);
  }

  List getList(List x,type)
  {
    print(x);
    List se;
    for(int i=0;i<x.length;i++)
      {
        se=x[i][type].map((val) => SurveyReport.fromJson(val)).toList();
        //se=x[i][type];
      }
    //for(int i=0;i<x.length;i++)
       // sr[0]=x[1];
       // print(sr);
    return se;
  }
  /*
  Widget buildDropdownList()
  {
    return FutureBuilder(
      future: surveyReport(),
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if(snapshot.data!=null)
          {
            return Container(

            );
          }
        else{
          return null;
        }
      }
    );
  } */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Survey"),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FutureBuilder(
                  future: surveyReport(),
                  builder: (BuildContext context,AsyncSnapshot snapshot){
                    if(snapshot.data!=null)
                      {
                        return DropdownButton(
                          /*getList(snapshot.data,"student_name") */
                          items: _accountType.map((values) => DropdownMenuItem(
                              child: Text( values,
                              style: TextStyle(color: Colors.green),
                            ),
                            value: values,
                          ),
                          )
                              .toList(),
                          onChanged: (selectedAccountType) {
                            setState(() {
                              selectedType = selectedAccountType;
                            });
                          },
                          value: selectedType,
                          icon: Icon(Icons.arrow_drop_down),
                          hint: Text(
                            "Pick Student",
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }
                    else{
                      return Container(
                        child: Center(
                          child: Text(
                              "Loading...",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                          )
                        )
                      );
                    }
                  }
                ),
                DropdownButton(
                  items: null,
                  onChanged: null,
                  hint: Text(
                    "Pick University",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                DropdownButton(
                  items: null,
                  onChanged: null,
                  hint: Text(
                    "Questions Attempted",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                DropdownButton(
                  items: null,
                  onChanged: null,
                  hint: Text(
                    "Survey Id",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: RaisedButton(
                color: Colors.lightBlue.shade900,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Search",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        )),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    )
                  ],
                ),
                onPressed: () {}),
          ),
          FutureBuilder(
              future: surveyReport(),
              builder: (BuildContext context,AsyncSnapshot snapshot)
              {
                if(snapshot.data!=null)
                {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,int index) {
                            return getStudentSurveyData(snapshot.data[index]['id'],snapshot.data[index]['student_name'],snapshot.data[index]['semester'],snapshot.data[index]['year'],snapshot.data[index]['university']['university_name'],snapshot.data[index]['university']['campus'],snapshot.data[index]['user']['email'],snapshot.data[index]['phone_no'],snapshot.data[index]['university']['created_at']);
                            /* Text(
                              //  "Wamiq"
                              snapshot.data[index]['student_name']
                            );
                            */
                          }
                      )
                  );
                }
                else if(snapshot.hasError){
                  return Container(
                      child: Center(
                          child: Text(
                              "Error!",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                          )
                      )
                  );
                }
                else{
                  return Container(
                      child: Center(
                          child: Text(
                              "Loading...",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              )
                          )
                      )
                  );
                }
              }
          ),

          /*
          Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: 85,
                  itemBuilder: (context, int index) {
                    return Stack(children: <Widget>[
                      // The containers in the background
                      Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            width: 350,
                            height: 300.0,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Material(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(15),
                                  elevation: 14.0,
                                  shadowColor: Color(0x802196F3),
                                  child: Column(children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        // "Wamiq",
                                        surveylist[index]['student_name'],
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          //"Id :",
                                          "Id: ${surveylist[index]['id']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          // "Semester :",
                                          "semester : ${surveylist[index]['semester']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          //"Year :",
                                          "Year : ${surveylist[index]['year']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          //"University :",
                                          "University : ${surveylist[index]['university']['university_name']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          //"Campus :",
                                          "Campus : ${surveylist[index]['university']['campus']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "email :",
                                          //"email : ${surveylist[index]['user']['email']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Phone :",
                                          //"Phone : ${surveylist[index]['phone_no']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Registered At :",
                                          // "Registered At : ${surveylist[index]['university']['created_at']}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ])),
                            ),
                          ),
                        ),
                      ]),
                    ]);
                  }
                  )
          ),
          */
          Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.keyboard_arrow_left),
                        Text("To start", style: TextStyle(fontSize: 15))
                      ],
                    ),
                    onPressed: () {
                      _scrollController.animateTo(
                          _scrollController.position.minScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut);
                    },
                  ),
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Text("To end", style: TextStyle(fontSize: 15)),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                    onPressed: () {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut);
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
