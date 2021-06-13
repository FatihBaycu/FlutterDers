import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobil_kodlama_ornekleri/models/student.dart';



class StudentList extends StatefulWidget {

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {

  Future<List<Student>> getAll() async {
    var response = await http
        .get(Uri.parse("https://api.onurylmz.com/mobile-students/all"));
    if (response.statusCode == 200) {
      var result = (jsonDecode(response.body)["data"] as List)
          .map((e) => Student.fromJson(e))
          .toList();
      return result;
    } else {
      debugPrint("HATA");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<Student>>(
          future:getAll(),
          builder: (BuildContext context, snapshot){
            if(snapshot.hasData){
              var students=snapshot.data;
              return ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context,index){
                    var ogrenci=students[index];
                    var shade = 100 * ((index+1) % 9);
                    return Container(
                      color: shade==0?Colors.green:Colors.green[shade],
                      child: ListTile(
                        leading:  CircleAvatar(child: Text(ogrenci.id.toString()),),
                        title: Text(ogrenci.firstName),
                        subtitle: Text(ogrenci.email),
                      ),
                    );
                  }
              );
            }
            else
            {
              return Center(child:CircularProgressIndicator());
            }
          },
        ),

    );
  }
}
