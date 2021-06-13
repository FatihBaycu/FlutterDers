import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobil_kodlama_ornekleri/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:mobil_kodlama_ornekleri/user_screens/user_detail_screen.dart';

class UserList extends StatefulWidget {
  const UserList({Key key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {


  Future<List<User>> getAll()async{
    var response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode==200){
    var result=(jsonDecode(response.body) as List)
        .map((e) => User.fromJson(e))
        .toList();
    return result;
    }
    else{
       debugPrint("Error, Error Code is: "+response.statusCode.toString());
    }

  }

  @override
  void initState() {
    getAll();
        super.initState();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Users"),),
    body: FutureBuilder<List<User>>(
     future: getAll(),
      builder: (context,snapshot){
       if(snapshot.hasData){
         var data=snapshot.data;
         return ListView.builder(
             itemCount: data.length,
             itemBuilder: (context,index){
               var user=data[index];
               return ListTile(
                 leading: Text(user.id.toString()),
                 title: Text(user.name),
                 subtitle: Text(user.email),
                 trailing: Icon(Icons.navigate_next),
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetailScreen(user.id)));
                 },

               );
             });
       }
       else return Center(child: CircularProgressIndicator());
      },
    ),
  );
  }
}
