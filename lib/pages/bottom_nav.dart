import 'package:flutter/material.dart';
import 'package:projext/pages/home.dart';
import 'package:projext/pages/notifications.dart';
import 'package:projext/pages/profile.dart';
import 'package:projext/pages/rank.dart';

class Bottom_Nav extends StatefulWidget {
  @override
  _Bottom_NavState createState() => _Bottom_NavState();
}

class _Bottom_NavState extends State<Bottom_Nav> {

  int _index=0;

  final tabs=[
    Home(),
    Rank(),
    null,
    Notifications(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_index],
      bottomNavigationBar: SafeArea(
        child: Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            selectedItemColor: Colors.yellow[800],
            backgroundColor: Colors.grey[200],
            type: BottomNavigationBarType.fixed,
            currentIndex: _index,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(Icons.home),
                title: Text("Anasayfa"),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(Icons.format_list_numbered),
                title: Text("Sıralama"),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(Icons.home_outlined),
                title: Text("Dert Ekle"),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(Icons.notifications),
                title: Text("Bildirimler"),
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(Icons.person),
                title: Text("Profil"),
              ),
            ],
            onTap: (index){
              if(index!=2){
                setState(() {
                  _index=index;
                });
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
        child: FloatingActionButton(
          backgroundColor: Colors.yellow[800],
          onPressed: (){
            Navigator.of(context).pushNamed('/adddert');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
