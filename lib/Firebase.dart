import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer';
import 'package:encrypt/encrypt.dart' as FlutterEncrypt;
import 'package:pointycastle/export.dart' as pc;
import 'package:date_time_picker/date_time_picker.dart';
class Database {

  var key;
  var iv;
  var encrypter;

  Database(){
    key = FlutterEncrypt.Key.fromUtf8('CBoaDQIQAgceGg8dFAkMDBEOECEZAcf=');
    iv = FlutterEncrypt.IV.fromLength(16);
    encrypter = FlutterEncrypt.Encrypter(FlutterEncrypt.AES(key));
  }
  static FirebaseDatabase database;

  Future<Map<dynamic, dynamic>> getMerchant(String email) async {
    DatabaseReference ref = database.reference().child("merchant").child(email);
    DataSnapshot ds = await ref.once();
    var values = ds.value;
    Map<dynamic, dynamic> map = values;
    return map;
  }
  Future<List> getAllSchools()async {
    DatabaseReference ref = database.reference().child("schools");
    DataSnapshot ds = await ref.once();
    var values=ds.value;
    values=Map<dynamic,dynamic>.from(values).keys;
    int i=0;
    List ls=[];
    //Map map={};
    //map[0]="School";
    //ls.add(map);
    for(var val in values){
      Map m={};
      m[i]=val;
      ls.add(m);
      i=i+1;
    }
    log(ls.toString());
    return ls;
  }
  Future<void> addSchool(String school) async {
    DatabaseReference ref = database.reference().child("schools").child(school);
    Fluttertoast.showToast(msg: school);
    DataSnapshot ds = await ref.once();
    var value = ds.value;
    if (value == null) {
      await database
          .reference()
          .child("schools")
          .child(school)
          .set({"merchantEmail": ""});
    }
    //Fluttertoast.showToast(msg: "Ds was not null haahah");
  }

  Future<bool> addUser(String fname, String lname, String email,
      String password, String school, String phone, String gender) async {
    password = encrypt(password);
    await database
        .reference()
        .child("users")
        .child(email.replaceAll(".", ","))
        .set({
      "password": password,
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

  Future<int> getbullyBucks(String email) async {
    DatabaseReference ref = await database
        .reference()
        .child("users")
        .child(email.replaceAll(".", ","));
    DataSnapshot ds = await ref.once();
    var values = ds.value;
    int bucks = values["bucks"];
    return bucks;
  }

  Future<bool> hasID(String email) async {
    DatabaseReference ref = await database
        .reference()
        .child("users")
        .child(email.replaceAll(".", ","));
    DataSnapshot ds = await ref.once();
    if (ds != null) {
      var val = ds.value;
      if (val == null) {
        return false;
      }
    } else {
      return true;
    }
  }

  Future<int> addBullyBucks(String email, int amount) async {
    int currentBalance = await getbullyBucks(email);
    await database
        .reference()
        .child("users")
        .child(email.replaceAll(".", ","))
        .update({"bucks": currentBalance + amount});
  }

  Future<int> minusBullyBucks(String email, int amount) async {
    int currentBalance = await getbullyBucks(email);
    if (currentBalance - amount < 0) {
      return -1;
    } else {
      await database
          .reference()
          .child("users")
          .child(email.replaceAll(".", ","))
          .update({"bucks": currentBalance - amount});
      return 0;
    }
  }

  Future<void> verifyReport(
      String teacherName, String email, String id, int report) async {
    log(id);
    var ref = await database
        .reference()
        .child("users")
        .child(email.replaceAll(".", ","))
        .child("reports")
        .child(id)
        .update({
      "verify": report,
      "teacherName": teacherName,
      "verficationTime": DateTime.now().toString()
    });
  }

  Future<Map<dynamic, dynamic>> getUser(String email) async {
    DatabaseReference ref = await database
        .reference()
        .child("users")
        .child(email.replaceAll(".", ","));
    DataSnapshot ds = await ref.once();
    var values = ds.value;
    Map<dynamic, dynamic> map = new Map<dynamic, dynamic>();
    map["email"] = email;
    map["bucks"] = values["bucks"];
    map["fname"] = values["fname="];
    map["lname"] = values["lname"];
    map["phone"] = values["phone"];
    map["school"] = values["school"];
    return map;
  }

  Future<int> signinUser(String email, String pass) async {
    DatabaseReference ref = await database
        .reference()
        .child("users")
        .child(email.replaceAll(".", ","));
    DataSnapshot ds = await ref.once();
    var values = ds.value;
    String dbpass = await decrypt(values["password"]);
    dbpass=dbpass.trim();
    if (dbpass == pass) {
      if (values["userType"] == "teacher") {
        return 1;
      } else {
        return 2;
      }
    } else {
      return 0;
    }
  }

  Future<bool> submitReport(String email, String tcn1, String
   tcn2, String tcn3,
      String tcn4, String tcn5, int val1, int val2) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM dd, yyyy').format(now);
    String type;
    String role;
    if (val1 == 2) {
      type = "physical";
    }
    if (val1 == 3) {
      type = "Verbal";
    }
    if (val1 == 4) {
      type = "cyber";
    }
    if (val2 == 2) {
      role = "witness";
    }
    if (val2 == 3) {
      role = "victim";
    }
    await database
        .reference()
        .child("users")
        .child(email.replaceAll(".", ","))
        .child("reports")
        .push()
        .set({
      "bully": tcn1,
      "victim": tcn2,
      "location": tcn3,
      "time": tcn4,
      "description": tcn5,
      "type": type,
      "role": role,
      "verify": 0,
      "currentDate": formattedDate,
      "currentTime": DateTime.now().millisecondsSinceEpoch
    });
    return true;
  }

  Future<List> getVerified() async {
    String k;
    int c = 0;
    List list = new List();
    DatabaseReference ref = await database.reference().child("users");
    DataSnapshot ds = await ref.once();
    var value = Map<String, dynamic>.from(ds.value).values;
    var key = Map<String, dynamic>.from(ds.value).keys;
    for (var element in key) {
      List temp = await getHistory(element);
      k = element;
      if (temp != null) {
        for (var element in temp) {
          element["email"] = k;
        }
        list = list + temp;
      }
      c = c + 1;
    }
    return list;
  }

  Future<List<dynamic>> getAllTeachers() async {
    String k;
    int c = 0;
    List list = new List();
    DatabaseReference ref = await database.reference().child("users");
    DataSnapshot ds = await ref.once();
    var value = Map<String, dynamic>.from(ds.value).values;
    var key = Map<String, dynamic>.from(ds.value).keys;
    for (var s in value) {
      if (s["userType"] == "teacher") {
        list.add(key.elementAt(c));
      }
      c = c + 1;
    }
    return list;
  }

  Future<List<dynamic>> getAllTeachersOfSchool(String school) async {
    String k;
    int c = 0;
    List list = new List();
    DatabaseReference ref = await database.reference().child("users");
    DataSnapshot ds = await ref.once();
    var value = Map<String, dynamic>.from(ds.value).values;
    var key = Map<String, dynamic>.from(ds.value).keys;
    for (var s in value) {
      if (s["userType"] == "teacher") {
        if (s["school"] == school) list.add(key.elementAt(c));
      }
      c = c + 1;
    }
    return list;
  }

  Future<List> getProductsOfSchool(String school) async {
    List list=[];
    DatabaseReference ref = database.reference().child("schools").child(school);
    DataSnapshot ds=await ref.once();
    List l=ds.value;
    for(int i=0;i<l.length;i++) {
      var element=l[i];
      if(element != null) {
        log("heheheh");
        var map = await getProducts(element);
        list = list + map;
      }
    }
    return list;
  }

  Future<List> getProducts(String email) async {
    String mEmail = email;
    List list = new List();
    DatabaseReference ref =
        database.reference().child("merchant").child(mEmail).child("products");
    DataSnapshot ds = await ref.once();
    var key = Map<String, dynamic>.from(ds.value).keys;
    for (var k in key) {
      DatabaseReference ref1 = database
          .reference()
          .child("merchant")
          .child(mEmail)
          .child("products")
          .child(k);
      DataSnapshot ds1 = await ref1.once();
      Map<String,dynamic>  tempMap=Map<String, dynamic>.from(ds1.value);
      tempMap["merchantEmail"]=email;
      list.add(tempMap);
    }
    return list;
  }

  Future<List> getHistory(String email) async {
    List list=new List();
    DatabaseReference refName = await database
        .reference()
        .child("users")
        .child(email.replaceAll(".", ",")).orderByValue().reference();
    DataSnapshot ds = await refName.once();
    var map=Map<String,dynamic>.from(ds.value);
    var reports=map["reports"];
    var keys=reports.keys.toList();
    for (var el in keys){
      var element =reports[el];
      element["id"]=el;
      element["fname"] = map["fname"];
      element["lname"] = map["lname"];
      element["expand"] = false;
      list.add(element);
    }
    for (int i=0; i<list.length;i++){
      for (int j=0; j<list.length-1;j++){
        if(greater(list[j]["currentDate"],list[j+1]["currentDate"])<0){
          var temp=list[j];
          list[j]=list[j+1];
          list[j+1]=temp;
        }
      }
    }
    return list;
  }
  int greater(String prev,String next){
    var prevDate    = prev;
    DateFormat format = new DateFormat("MMMM dd, yyyy");
    var prevFormatedDate = format.parse(prev);
    var nextDate    = next;
    var nextFromatedDate = format.parse(next);
    return nextFromatedDate.compareTo(prevFormatedDate);
  }


  String encrypt(String pass) {
    return encrypter.encrypt(pass, iv: iv).base64;
  }

  String decrypt(String pass) {
    return decryptExtension(pass, key.bytes, iv.bytes);
  }

  String decryptExtension(String cipher, Uint8List key, Uint8List iv) {
    final encryptedText = FlutterEncrypt.Encrypted.fromBase64(cipher);
    final ctr = pc.CTRStreamCipher(pc.AESFastEngine())
      ..init(false, pc.ParametersWithIV(pc.KeyParameter(key), iv));
    Uint8List decrypted = ctr.process(encryptedText.bytes);

    print(String.fromCharCodes(decrypted));

    return String.fromCharCodes(decrypted).replaceAll("\n", "");
  }

  Future<List> getReportsOSchool(String school)async{
    List<Map<dynamic,dynamic>> list=[];
    Query ref =  database
        .reference()
        .child("users").orderByChild("school").equalTo(school);
    DataSnapshot ds=await ref.once();
    var values=ds.value;
    Map<dynamic,dynamic> map=Map<dynamic,dynamic>.from(values);
    map.forEach((keyofParent, valueofParent) {
      if(valueofParent["reports"]!=null){
           Map<dynamic,dynamic> mapOfReport= valueofParent["reports"];
           mapOfReport.forEach((key, value) {
             value["id"]=key;
             value["fname"]=valueofParent["fname="];
             value["lname"]=valueofParent["lname"];
             value["expand"] = false;
            value["email"]=keyofParent;
             list.add(value);
           });
      }
    });
    return list;
  }
  Future<void> addaOrder(String email,String caption,int points,String merchantEmail) async {
    var studentMap=await getUser(email);
    database.reference().child("orders").push().set({
      "studentEmail":email.replaceAll(".", ","),
      "studentName":studentMap["fname="].toString()+" " +studentMap["lname"].toString(),
      "productName":caption,
      "school":studentMap["school"],
      "points":points,
      "merchant":merchantEmail.replaceAll(".", ","),
      "date":DateTime.now().millisecondsSinceEpoch
    });
  }
}
