import 'dart:convert';

import 'package:flutter/material.dart';

import 'models/student.dart';
import 'package:http/http.dart' as http;

class StudentAdd extends StatefulWidget {

  @override
  _StudentAddState createState() => _StudentAddState();
}

class _StudentAddState extends State<StudentAdd> {
  Student student=new Student(0,"","","","","",0,"",0);

  var name=TextEditingController();
  var surname=TextEditingController();
  var email=TextEditingController();
  var password=TextEditingController();
  var sifre;
  var formKey=GlobalKey<FormState>();

  Future<http.Response> insertStudent(Student student)async{

    var response=await http.post(
      Uri.parse("https://api.onurylmz.com/mobile-students/create"),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // body: jsonEncode(<String,String>{
      //   "email":student.email,
      //   "password":student.password,
      //   "first_name":student.firstName,
      //   "last_name":student.lastName
      // }),
      body: jsonEncode(student),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Form(
        key:formKey ,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextFormField(
              decoration: InputDecoration(
                  hintText: "Name",
                  border:OutlineInputBorder(borderRadius:BorderRadius.circular(10))
              ),
              controller: name,
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Surname",
                  border:OutlineInputBorder(borderRadius:BorderRadius.circular(10))
              ),
              controller: surname,
            ),

            SizedBox(height: 10,),
            TextFormField(

              // validator: (value){
              //   if(value.isEmpty){
              //   return "Boş olamaz.";
              //   }
              //   return null;
              //     },
              autovalidateMode: AutovalidateMode.always,
              decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  border:OutlineInputBorder(borderRadius:BorderRadius.circular(10))
              ),
              controller: email,
            ),

            SizedBox(height: 10,),

            TextFormField(
              controller: password,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Password",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),

            ),
            ElevatedButton(onPressed: (){

              if(formKey.currentState.validate()){
                student.firstName=name.text;
                student.lastName=surname.text;
                student.password=password.text;
                student.email=email.text;

                insertStudent(student);

              }

              print(student.email);
              print(student.firstName);

            }, child: Text("Submit"))
          ],
        ),
      ),
      ),
    );
  }
}
