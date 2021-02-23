import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer';

class  Database {

  static FirebaseDatabase database;

  Future<bool> addUser(String fname, String lname, String email, String password, String school, String phone, String gender) async
  {
    await database.reference().child("users").child(email.replaceAll(".", ",")).set(
        {"password": password,
          "fname=": fname,
          "lname": lname,
          "gender": gender,
          "school": school,
          "phone": phone,
          "bucks":0
        });
    return true;
  }
  Future<bool> signinUser(String email,String pass)async
  {
    DatabaseReference ref=await database.reference().child("users").child(email.replaceAll(".", ","));
    DataSnapshot ds=await ref.once();
      var values=ds.value;
      if(values["password"]==pass)
        {
          Fluttertoast.showToast(msg: "pass pass pass");
          return  true;
        }
      else
        {
          return false;
        }
  }
  Future<bool> submitReport(String email,String tcn1,String tcn2,String tcn3,String tcn4,String tcn5,int val1,int val2)async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(now);
    String type;
    String role;
    if(val1==2){
      type="physical";
    }
    if(val1==3){
      type="Verbal";
    }
    if(val1==4){
      type="cyber";
    }
    if(val2==2){
      role="witness";
    }
    if(val2==3){
      role="victim";
    }
    await database.reference().child("users").child(email.replaceAll(".", ",")).child("reports").push().set(
      {
        "bully":  tcn1,
        "victim":  tcn2,
        "location":tcn3,
        "time":tcn4,
        "description":tcn5,
        "type":type,
        "role":role,
        "verify":false,
        "currentDate":formattedDate
      }
    );
    return true;
  }
  Future<List> getVerified()async
  {
    String k;
    List list=new List();;
    DatabaseReference ref=await database.reference().child("users");
    DataSnapshot ds=await ref.once();
    var key=Map<String, dynamic>.from(ds.value).keys;
    for(k in key){
      list=list+await getHistory(k);
    }
    return list;
  }
  Future<List> getHistory(String email)async
  {
    int c=0;
    List list=new List();
    DatabaseReference refName=await database.reference().child("users").child(email.replaceAll(".", ","));
    DataSnapshot ds1=await refName.once();
    var value1=Map<String, dynamic>.from(ds1.value).values;
    DatabaseReference ref=await database.reference().child("users").child(email.replaceAll(".", ",")).child("reports");
    DataSnapshot ds=await ref.once();
    var value=Map<String, dynamic>.from(ds.value).values;
    var key=Map<String, dynamic>.from(ds.value).keys;
    log("value1  "+ value1.elementAt(7).toString());
    value.forEach((element) {
      element["id"]=key.elementAt(c);
      element["fname"]=value1.elementAt(7).toString();
      element["lname"]=value1.elementAt(1).toString();
      list.add(element);
      //log("key" + key.elementAt(c));
    });
    return list;
  }
}