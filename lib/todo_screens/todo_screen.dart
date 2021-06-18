import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobil_kodlama_ornekleri/models/todo.dart';
import 'package:http/http.dart' as http;

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  Future<List<Todo>> getAll()async{

    var response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
    if(response.statusCode==200){
      
      var result=(jsonDecode(response.body) as List)
          .map((e) => Todo.fromJson(e))
          .toList();
      print(result);
      return result;
    }
    else{
             print(response.statusCode.toString());
    }


  }

  @override
  void initState() {
    //getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todos"),),
      body: FutureBuilder<List<Todo>>(
        future: getAll(),
        builder: (context,snapshot){
            if(snapshot.hasData){
              var todos=snapshot.data;
              return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context,index){
                    var todo=todos[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text(todo.id.toString()),),
                      title: Text(todo.title),
                      trailing: changeIconColor(todo.completed),
                    );
                  }
              );

            }
            else{
              return Center(child: CircularProgressIndicator());
            }
        },
      ),
    );
  }
  Widget changeIconColor(bool completed){
    if(completed){
      return Icon(Icons.done,color: Colors.green);
    }
    else{
      return Icon(Icons.cancel,color: Colors.red,);
    }
  }
}
// var result = (jsonDecode(response.body)["data"] as List)
//     .map((e) => Student.fromJson(e))
//     .toList();
// return result;
//    