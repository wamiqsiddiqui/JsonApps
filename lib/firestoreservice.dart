import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tasks.dart';
import 'package:flutter/material.dart';

final CollectionReference myCollection =Firestore.instance.collection("todolist");

class FireStoreService{

  Future<Tasks> createTODOtask(String taskName,String taskDetails,String taskDate,String taskTime,String taskType)async{
    final TransactionHandler createTransaction=(Transaction tx)async{
      final DocumentSnapshot ds=await tx.get(myCollection.document());

      final Tasks tasks=Tasks(taskName,taskDetails,taskDate,taskTime,taskType);
      final Map<String,dynamic> data=tasks.toMap();
      await tx.set(ds.reference, data);
      return data;
    };
    return Firestore.instance.runTransaction(createTransaction).then((mapData){
      return Tasks.fromMap(mapData);
    }).catchError((onError){
      print("Error:$onError");
      return null;
    });
  }
  Stream<QuerySnapshot>getTaskList({int offset,int limit}){
    Stream<QuerySnapshot> snapshots=myCollection.snapshots();
    if(offset!=null)
    {
      snapshots=snapshots.skip(offset);
    }
    if(limit!=null)
    {
      snapshots=snapshots.take(limit);
    }
    return snapshots;
  }
}