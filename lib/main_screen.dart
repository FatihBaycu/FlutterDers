import 'package:flutter/material.dart';
import 'package:mobil_kodlama_ornekleri/students_screen/student_add.dart';
import 'package:mobil_kodlama_ornekleri/students_screen/student_list.dart';
import 'package:mobil_kodlama_ornekleri/students_screen/student_list_gridview.dart';
import 'package:mobil_kodlama_ornekleri/todo_screens/todo_screen.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex=0;
  var pageList=[StudentList(),StudentAdd(),StudentListGridView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Students."),),
      drawer: drawerWidget(),
      body:  bodyWidget(),
      bottomNavigationBar: bottomNavigationBarWidget(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget drawerWidget(){
   return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Fatih"),
            accountEmail: Text("fatih.baycu@gmail.com"),
            currentAccountPicture: Image.network(
                "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            otherAccountsPictures: [
              Image.network(
                  "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-with-glasses.jpg"),
              Image.network(
                  "https://i.pinimg.com/originals/d6/64/cb/d664cb970d4bbc84f69fb50783c824ca.jpg"),
            ],
          ),
          ListTile(
            leading: Icon(Icons.http,color: Colors.blue,),
            title: Text("Http User List"),
            trailing: Icon(Icons.navigate_next),
            onTap: () {Navigator.pushNamed(context, "/UserList");},
          ),

          ListTile(
            leading: Icon(Icons.plus_one),
            title: Text("My Todos"),
            subtitle: Text("Bu bir subtitledır."),
            trailing: Icon(Icons.navigate_next),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>TodoScreen()));
            },
          ),

          AboutListTile(applicationIcon: Icon(Icons.navigate_next)),
        ],
      ),
    );

  }

  bodyWidget() {
    return pageList[selectedIndex];
  }

  bottomNavigationBarWidget() {
    return BottomNavigationBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.http),label: "StudentList"),
      BottomNavigationBarItem(icon: Icon(Icons.http),label: "StudentInsert"),
      BottomNavigationBarItem(icon: Icon(Icons.http),label: "StudentGrid"),
    ],
     type: BottomNavigationBarType.fixed,
     currentIndex: selectedIndex,
     selectedItemColor: Colors.red,
     onTap: (int index){
      setState(() {
        selectedIndex=index;
      });

     });
  }
}
