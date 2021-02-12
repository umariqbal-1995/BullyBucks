import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    await database.reference().child("users").child(email.replaceAll(".", ",")).child("reports").set(
      {
        "bully":  tcn1,
        "victim":  tcn2,
        "location":tcn3,
        "time":tcn4,
        "description":tcn5,
        "type":type,
        "role":role
      }
    );
    return true;
  }
}