import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool _ifPressed=false,_ifPressed3=false,_ifPressed2=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bildirimler"),
      ),
      body: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            child: FlatButton(
              color: _ifPressed2 ? Colors.blue:Colors.white,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: (){
                setState(() {
                  _ifPressed=false;
                  _ifPressed2=true;
                  _ifPressed3=false;
                });
              },
              child: Text("Yeni Dertler",
                style: TextStyle(
                  color: _ifPressed2 ? Colors.white:Colors.blue,
                ),),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.blue
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            child: FlatButton(
              color: _ifPressed ? Colors.blue:Colors.white,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: (){
                setState(() {
                  _ifPressed=true;
                  _ifPressed2=false;
                  _ifPressed3=false;
                });
              },
              child: Text("Bahsetmeler",
                style: TextStyle(
                  color: _ifPressed ? Colors.white:Colors.blue,
                ),),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.blue
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            child: FlatButton(
              color: _ifPressed3 ? Colors.blue:Colors.white,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: (){
                setState(() {
                  _ifPressed=false;
                  _ifPressed2=false;
                  _ifPressed3=true;
                });
              },
              child: Text("Tepkiler",
                style: TextStyle(
                  color: _ifPressed3 ? Colors.white:Colors.blue,
                ),),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.blue
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
