import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer';
import 'package:simple_rsa/simple_rsa.dart';

class  Database {
  static FirebaseDatabase database;
  Future<Map<dynamic,dynamic>> getMerchant(String email)async {
    DatabaseReference ref = database.reference().child("merchant").child(email);
    DataSnapshot ds = await ref.once();
    var values=ds.value;
    Map<dynamic,dynamic> map=values;
    return map;
  }
  Future<void> addSchool(String school)async{
    DatabaseReference ref=database.reference().child("schools").child(school);
    Fluttertoast.showToast(msg: school);
    DataSnapshot ds=await ref.once();
    var value=ds.value;
    if(value==null) {
      await database.reference().child("schools").child(school).set({
        "merchantEmail": ""
      });
    }
    //Fluttertoast.showToast(msg: "Ds was not null haahah");
  }
  Future<bool> addUser(String fname, String lname, String email, String password, String school, String phone, String gender) async
  {
    password = await encrypt(password);
    await database.reference().child("users")
        .child(email.replaceAll(".", ","))
        .set(
        {"password": password,
          "fname=": fname,
          "lname": lname,
          "userType": gender,
          "school": school,
          "phone": phone,
          "bucks": 0
        });
    addSchool(school);
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
  Future<bool> hasID(String email)async {
    DatabaseReference ref=await database.reference().child("users").child(email.replaceAll(".", ","));
    DataSnapshot ds=await ref.once();
    if(ds!=null){
      var val=ds.value;
      if(val==null){
        return false;
      }
    }
    else {
      return true;
    }
  }
  Future<int> addBullyBucks(String email,int amount)async
  {
    int currentBalance=await getbullyBucks(email);
    await database.reference().child("users").child(email.replaceAll(".", ",")).update({"bucks":currentBalance+amount});
  }
  Future<int> minusBullyBucks(String email,int amount)async
  {
    int currentBalance=await getbullyBucks(email);
    if(currentBalance-amount<0)
    {
      return -1;
    }
    else {
      await database.reference().child("users").child(
          email.replaceAll(".", ",")).update(
          {"bucks": currentBalance - amount});
      return 0;
    }
  }
  Future<void> verifyReport(String teacherName,String email,String id,int report)async {
    log(id);
    var ref=await database.reference().child("users").child(email.replaceAll(".", ",")).child("reports").child(id).
    update(
        {
          "verify":report,
          "teacherName":teacherName,
          "verficationTime":DateTime.now().toString()
    });

  }
  Future<Map<dynamic,dynamic>> getUser(String email)async
  {
    DatabaseReference ref=await database.reference().child("users").child(email.replaceAll(".", ","));
    DataSnapshot ds=await ref.once();
    var values=ds.value;
    Map<dynamic,dynamic> map=new Map<dynamic,dynamic>();
    map["email"]=email;
    map["bucks"]=values["bucks"];
    map["fname"]=values["fname="];
    map["lname"]=values["lname"];
    map["phone"]=values["phone"];
    map["school"]=values["school"];
    return map;
  }
  Future<int> signinUser(String email,String pass)async
  {
    DatabaseReference ref=await database.reference().child("users").child(email.replaceAll(".", ","));
    DataSnapshot ds=await ref.once();
      var values=ds.value;
      String dbpass=await decrypt(values["password"]);
      if(dbpass==pass)
        {
          if(values["userType"]=="teacher")
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
        "currentDate":formattedDate,
        "currentTime":DateTime.now().millisecondsSinceEpoch
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
        }
        list=list+temp;
      }
      c=c+1;
    }
    return list;
  }
  Future<List<dynamic>> getAllTeachers()async{
    String k;
    int c=0;
    List list=new List();
    DatabaseReference ref=await database.reference().child("users");
    DataSnapshot ds=await ref.once();
    var value=Map<String, dynamic>.from(ds.value).values;
    var key=Map<String, dynamic>.from(ds.value).keys;
    for(var s in value){
      if(s["userType"]=="teacher"){
        list.add(key.elementAt(c));
      }
      c=c+1;
    }
    return list;
  }
  Future<String> getMerchantEmail(String school)async{
    //Fluttertoast.showToast(msg: school);
    DatabaseReference ref=database.reference().child("schools").child(school);
    DataSnapshot ds=await ref.once();
    if(ds!=null) {
      var value = ds.value;
      return value["merchantEmail"];
    }
    return null;
  }
  Future<List> getProducts(String school)async{
    String mEmail=await getMerchantEmail(school);
    String k;
    List list=new List();
    DatabaseReference ref=database.reference().child("merchant").child(mEmail).child("products");
    DataSnapshot ds=await ref.once();
    var key=Map<String, dynamic>.from(ds.value).keys;
    for(k in key){
      DatabaseReference ref1=database.reference().child("merchant").child(mEmail).child("products").child(k);
      DataSnapshot ds1=await ref1.once();
      //Fluttertoast.showToast(msg: ds1.value["imag"]);
      list.add(Map<String, dynamic>.from(ds1.value));

    }
    return list;
  }
  Future<List> getHistory(String email) async {
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
      element["expand"]=false;
      log(element["id"]);
      list.add(element);
      c=c+1;
      //log("key" + key.elementAt(c));
    }
    return list;
  }
  final publicKey =
      "MIIBITANBgkqhkiG9w0BAQEFAAOCAQ4AMIIBCQKCAQBuAGGBgg9nuf6D2c5AIHc8" +
          "vZ6KoVwd0imeFVYbpMdgv4yYi5obtB/VYqLryLsucZLFeko+q1fi871ZzGjFtYXY" +
          "9Hh1Q5e10E5hwN1Tx6nIlIztrh5S9uV4uzAR47k2nng7hh6vuZ33kak2hY940RSL" +
          "H5l9E5cKoUXuQNtrIKTS4kPZ5IOUSxZ5xfWBXWoldhe+Nk7VIxxL97Tk0BjM0fJ3" +
          "8rBwv3++eAZxwZoLNmHx9wF92XKG+26I+gVGKKagyToU/xEjIqlpuZ90zesYdjV+" +
          "u0iQjowgbzt3ASOnvJSpJu/oJ6XrWR3egPoTSx+HyX1dKv9+q7uLl6pXqGVVNs+/" +
          "AgMBAAE=";

  final privateKey =
      "MIIEoQIBAAKCAQBuAGGBgg9nuf6D2c5AIHc8vZ6KoVwd0imeFVYbpMdgv4yYi5ob" +
          "tB/VYqLryLsucZLFeko+q1fi871ZzGjFtYXY9Hh1Q5e10E5hwN1Tx6nIlIztrh5S" +
          "9uV4uzAR47k2nng7hh6vuZ33kak2hY940RSLH5l9E5cKoUXuQNtrIKTS4kPZ5IOU" +
          "SxZ5xfWBXWoldhe+Nk7VIxxL97Tk0BjM0fJ38rBwv3++eAZxwZoLNmHx9wF92XKG" +
          "+26I+gVGKKagyToU/xEjIqlpuZ90zesYdjV+u0iQjowgbzt3ASOnvJSpJu/oJ6Xr" +
          "WR3egPoTSx+HyX1dKv9+q7uLl6pXqGVVNs+/AgMBAAECggEANG9qC1n8De3TLPa+" +
          "IkNXk1SwJlUUnAJ6ZCi3iyXZBH1Kf8zMATizk/wYvVxKHbF1zTyl94mls0GMmSmf" +
          "J9+Hlguy//LgdoJ9Wouc9TrP7BUjuIivW8zlRc+08lIjD64qkfU0238XldORXbP8" +
          "2BKSQF8nwz97WE3YD+JKtZ4x83PX7hqC9zabLFIwFIbmJ4boeXzj4zl8B7tjuAPq" +
          "R3JNxxKfvhpqPcGFE2Gd67KJrhcH5FIja4H/cNKjatKFcP6qNfCA7e+bua6bL0Cy" +
          "DzmmNSgz6rx6bthcJ65IKUVrJK6Y0sBcNQCAjqZDA0Bs/7ShGDL28REuCS1/udQz" +
          "XyB7gQKBgQCrgy2pvqLREaOjdds6s1gbkeEsYo7wYlF4vFPg4sLIYeAt+ed0kn4N" +
          "dSmtp4FXgGyNwg7WJEveKEW7IEAMQBSN0KthZU4sK9NEu2lW5ip9Mj0uzyUzU4lh" +
          "B+zwKzZCorip/LIiOocFWtz9jwGZPCKC8expUEbMuU1PzlxrytHJaQKBgQCkMEci" +
          "EHL0KF5mcZbQVeLaRuecQGI5JS4KcCRab24dGDt+EOKYchdzNdXdM8gCHNXb8RKY" +
          "NYnHbCjheXHxV9Jo1is/Qi9nND5sT54gjfrHMKTWAtWKAaX55qKG0CEyBB87WqJM" +
          "Ydn7i4Rf0rsRNa1lbxQ+btX14d0xol9313VC5wKBgERD6Rfn9dwrHivAjCq4GXiX" +
          "vr0w2V3adD0PEH+xIgAp3NXP4w0mBaALozQoOLYAOrTNqaQYPE5HT0Hk2zlFBClS" +
          "BfS1IsE4DFYOFiZtZDoClhGch1z/ge2p/ue0+1rYc5HNL4WqL/W0rcMKeYNpSP8/" +
          "lW5xckyn8Jq0M1sAFjIJAoGAQJvS0f/BDHz6MLvQCelSHGy8ZUscm7oatPbOB1xD" +
          "62UGvCPu1uhGfAqaPrJKqTIpoaPqmkSvE+9m4tsEUGErph9o4zqrJqRzT/HAmrTk" +
          "Ew/8PU7eMrFVW9I68GvkNCdVFukiZoY23fpXu9FT1YDW28xrHepFfb1EamynvqPl" +
          "O88CgYAvzzSt+d4FG03jwObhdZrmZxaJk0jkKu3JkxUmav9Zav3fDTX1hYxDNTLi" +
          "dazvUFfqN7wqSSPqajQmMoTySxmLI8gI4qC0QskB4lT1A8OfmjcDwbUzQGam5Kpz" +
          "ymmKJA9DgQpPgEIjHAnw2dUDR+wI/Loywb0AGLIbszseCOlc2Q==";

  Future<String> encrypt(String pass)async {
      return await encryptString(pass, publicKey);
  }
  Future<String>decrypt(String pass){
    return decryptString(pass, privateKey);
  }
}