import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:projext/pages/log_in.dart';
import 'package:projext/services/database.dart';

class ADD_Dert extends StatefulWidget {



  @override
  _ADD_DertState createState() => _ADD_DertState();
}

class _ADD_DertState extends State<ADD_Dert> {
  var snapShot;
  int _number =0;
  TextEditingController _textcontroller=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
            child: TextField(
              controller: _textcontroller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.smoking_rooms_rounded),
                labelText: 'Dert',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 0),
            child: MaterialButton(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0),
              ),
              padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
              child: Text(
                'Paylaş',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                snapShot = (await Firestore.instance.collection('posts').document(_number.toString()).get()) ;
                while(snapShot.exists){
                  _number++;
                  snapShot = ( await Firestore.instance.collection('posts').document(_number.toString()).get()) ;
                }

                  await DatabaseService(number: _number).updatePosts(_textcontroller.text,Log_In.currentUser.uid,0);
                  _number++;
                  Navigator.of(context).pushReplacementNamed('/nav');
                  setState(() {
                  });
              },
            ),
          ),
        ],
      ),
    );
  }
}
