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
  Future<int> getbullyBucks(String email)async
  {
    DatabaseReference ref=await database.reference().child("users").child(email.replaceAll(".", ","));
    DataSnapshot ds=await ref.once();
    var values=ds.value;
    int bucks=values["bucks"];
    return bucks;
  }
  Future<int> addBullyBucks(String email,int amount)async
  {
    int currentBalance=await getbullyBucks(email);
    await database.reference().child("users").child(email.replaceAll(".", ",")).update({"bucks":currentBalance+amount});
  }
  Future<int> minusBullyBucks(String email,int amount)async
  {
    int currentBalance=await getbullyBucks(email);
    await database.reference().child("users").child(email.replaceAll(".", ",")).update({"bucks":currentBalance-amount});
  }
  Future<void> verifyReport(String email,String id,int report)async {
    log(id);
    var ref=await database.reference().child("users").child(email.replaceAll(".", ",")).child("reports").child(id).
    update({"verify":report});
    log("update done");
  }
  Future<int> signinUser(String email,String pass)async
  {
    DatabaseReference ref=await database.reference().child("users").child(email.replaceAll(".", ","));
    DataSnapshot ds=await ref.once();
      var values=ds.value;
      if(values["password"]==pass)
        {
          if(values["gender"]=="teacher")
            {
              return 1;
            }
          else
            {
              return 2;
            }
        }
      else
        {
          return 0;
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
        "verify":0,
        "currentDate":formattedDate
      }
    );
    return true;
  }
  Future<List> getVerified()async
  {
    String k;
    int c=0;
    List list=new List();
    DatabaseReference ref=await database.reference().child("users");
    DataSnapshot ds=await ref.once();
    var value=Map<String, dynamic>.from(ds.value).values;
    var key=Map<String, dynamic>.from(ds.value).keys;
    for(var element in key) {
      List temp=await getHistory(element);
      k=element;
      if(temp!=null) {
        for (var element in temp) {
          element["email"] = k;
          log("element " + element.toString());
        }
        list=list+temp;
      }
      log(c.toString()+" mama "+list.toString() );
      c=c+1;
    }
    log("list here "+list.toString());
    return list;
  }
  Future<List> getProducts()async{
    String k;
    List list=new List();
    DatabaseReference ref=await database.reference().child("products");
    DataSnapshot ds=await ref.once();
    var key=Map<String, dynamic>.from(ds.value).keys;
    for(k in key){
      DatabaseReference ref1=await database.reference().child("products").child(k);
      DataSnapshot ds1=await ref1.once();
      list.add(Map<String, dynamic>.from(ds1.value));
    }
    return list;
  }
  Future<List> getHistory(String email)async
  {
    var value;
    int c=0;
    List list=new List();
    DatabaseReference refName=await database.reference().child("users").child(email.replaceAll(".", ","));
    DataSnapshot ds1=await refName.once();
    var value1=Map<String, dynamic>.from(ds1.value).values;
    DatabaseReference ref=await database.reference().child("users").child(email.replaceAll(".", ",")).child("reports");
    DataSnapshot ds=await ref.once();
    if(ds.value==null)
      return null;
    else
      value=Map<String, dynamic>.from(ds.value).values;
    var key=Map<String, dynamic>.from(ds.value).keys;
    for(var element in value) {
      element["id"]=key.elementAt(c);
      element["fname"]=value1.elementAt(7).toString();
      element["lname"]=value1.elementAt(1).toString();
      list.add(element);
      //log("key" + key.elementAt(c));
    }
    return list;
  }
}