import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/student.dart';

class StudentListGridView extends StatefulWidget {
  const StudentListGridView({Key key}) : super(key: key);

  @override
  _StudentListGridViewState createState() => _StudentListGridViewState();
}

class _StudentListGridViewState extends State<StudentListGridView> {

  Future<List<Student>> getAll() async{
    var response=await http.get(Uri.parse("https://api.onurylmz.com/mobile-students/all"));
    if(response.statusCode==200){
      var result=(jsonDecode(response.body)["data"] as List)
          .map((e) => Student.fromJson(e))
          .toList();
      return result;
    }
    else
      debugPrint("Error!, Error code is: "+response.statusCode.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Student>>(
          future: getAll(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return GridView.builder(

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,int index){
                    var student=snapshot.data[index];
                    var shade = 100 * ((index+1) % 9);
                    return GestureDetector(
                        child: Container(
                      color: shade==0?Colors.orange:Colors.orange[shade],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Ad: "+student.firstName),
                          Text("Soyad: "+student.lastName),
                          Text("Email: "+student.email),
                          Text("Password: "+student.password),
                        ],
                      ),
                    )
                  );
                  }
              );
            }
            else
              {return Center(child: CircularProgressIndicator(),);}
          }
      ),
    );
  }
}
