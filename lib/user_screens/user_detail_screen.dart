import 'package:flutter/material.dart';
import 'package:mobil_kodlama_ornekleri/models/User.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


class UserDetailScreen extends StatefulWidget {
  int userId;

  UserDetailScreen(this.userId);

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {

 Future<User> getById(int id)async{
    var response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users?id=$id"));
    if(response.statusCode==200){
      var result=(jsonDecode(response.body))
          .map((e) => User.fromJson(e));
      print(result);
      return result;
    }
    else{
      debugPrint("Error, Error Code is: "+response.statusCode.toString());
    }

  }

   User user;

@override
  void initState() {
user=getById(widget.userId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User"),),
      body:
      FutureBuilder<User>(
        future: getById(widget.userId),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data=snapshot.data;
            return ListView(
              children: [
                Text(data.id.toString()),
                Text(data.name),
                Text(data.username),
                Text(data.email),
                Text("Adress=>"),
                Text(data.address.street),
                Text(data.address.suite),
                Text(data.address.city),
                Text(data.address.zipcode),
                Text("Adress=>Geo=>"),
                Text(data.address.geo.lat),
                Text(data.address.geo.lng),
                Text(data.phone),
                Text(data.website)

              ],
            );
          }
          else{
            return Center(child: CircularProgressIndicator());}
        },


      ),
    );
  }
}
