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

  var statusCode;
  User user;




  Future<List<User>> getById(int id)async{
    var response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users?id=$id"));
    if(response.statusCode==200){
      var result=(jsonDecode(response.body) as List)
          .map((e) => User.fromJson(e))
          .toList();
      user=result.first;
      print(user.name);
      return result;
    }
    else{
      debugPrint("Error, Error Code is: "+response.statusCode.toString());
    }

  }


@override
  void initState() {
   getById(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User"),),
      body:
      FutureBuilder<List<User>>(
        future: getById(widget.userId),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data=snapshot.data[0];
            return Center(
              child: Container(
                width: 250,
                height: 500,
                decoration: BoxDecoration(borderRadius:  BorderRadius.circular(1)),
                child: Card(
                  child: GestureDetector(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(child: Text(data.id.toString()),),
                            userVariableText(data.username),
                          ],),),

                        Divider(color: Colors.black,thickness:4,indent: 15,endIndent: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Name: "),
                            userVariableText(data.name),
                          ],
                        ),   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Email: "),
                            userVariableText(data.email),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Phone: "),
                            userVariableText(data.phone),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Web Site: "),
                            userVariableText(data.website)

                          ],
                        ),
                        userVariableText("Adress"),
                       Divider(color: Colors.black,thickness:4,indent: 15,endIndent: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Street: "),
                            userVariableText(data.address.street),

                          ],
                        ),    Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Suite: "),
                            userVariableText(data.address.suite),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("City: "),
                            userVariableText(data.address.city),

                          ],
                        ),   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Zip Code: "),
                            userVariableText(data.address.zipcode),

                          ],
                        ),Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Zip Code: "),
                            userVariableText(data.address.zipcode),

                          ],
                        ),
                        userVariableText("Adress-Geo"),
                      Divider(color: Colors.black,thickness:4,indent: 15,endIndent: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Geo Lat: "),
                            userVariableText("Lat: "+data.address.geo.lat),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Geo Lng: "),
                            userVariableText(data.address.geo.lng),

                          ],
                        ),
                        Divider(color: Colors.black,thickness:4,indent: 15,endIndent: 15,),


                    ],
                ),
                  ),),
              ),
            );
          }
          else{
            return Center(child: CircularProgressIndicator());}
        },


      ),
    );


  }
  Widget userVariableText(String text){
    return Text(text,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),);
  }
}
