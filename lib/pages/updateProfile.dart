import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projext/pages/log_in.dart';
import 'package:projext/services/database.dart';

class Update_Profile extends StatefulWidget {
  static int n;
  @override
  _UpdareProfileState createState() => _UpdareProfileState();
}

class _UpdareProfileState extends State<Update_Profile> {






  File _image;
  String _uploadedFileURL;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _userNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                CircleAvatar(
                  radius: 65.0,
                  child:RawMaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: EdgeInsets.all(65.0),
                    shape: CircleBorder(),
                    onPressed: () async{
                      var image=await ImagePicker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        _image=image;
                      });
                    },
                  ),
                  backgroundImage: _image== null ? NetworkImage(Log_In.currentUser.photoUrl) : FileImage(_image),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Divider(
                    color: Colors.yellow[800],
                    height: 40.0,
                    thickness: 2.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextField(
                    cursorColor: Colors.blueGrey[800],
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person,color: Colors.blueGrey[800],),
                      hintText: 'İsim Soyisim giriniz',
                      labelStyle: TextStyle(
                          color: Colors.grey[800]
                      ),
                      labelText: 'İsim Soyisim',focusColor: Colors.blueGrey[800],
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[800]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[800]),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextField(
                    cursorColor: Colors.blueGrey[800],
                    controller: _userNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.tag,color: Colors.blueGrey[800],),
                      hintText: 'Kullanıcı adı giriniz',
                      labelStyle: TextStyle(
                          color: Colors.grey[800]
                      ),
                      labelText: 'Kullanıcı Adı',focusColor: Colors.blueGrey[800],
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[800]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[800]),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: MaterialButton(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                    padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                    child: Text(
                      'Profili Güncelle',
                      style: TextStyle(color: Colors.white),
                    ),
                      color: Colors.yellow[800],
                    onPressed: () async {
                      try{
                        if(Log_In.currentUser !=null){
                          UserUpdateInfo updateUser=UserUpdateInfo();
                          updateUser.displayName=_userNameController.text;
                          StorageReference storageReference=FirebaseStorage.instance.ref().child('profilePics/${Log_In.currentUser.uid}');
                          StorageUploadTask uploadTask=storageReference.putFile(_image);
                          await uploadTask.onComplete;
                          await storageReference.getDownloadURL().then((fileURL){
                            setState(() {
                              _uploadedFileURL=fileURL;
                            });
                          });
                          var snapShot=await Firestore.instance.collection('profiles').document(Log_In.currentUser.uid).get();
                          updateUser.photoUrl=_uploadedFileURL;
                          Log_In.currentUser.updateProfile(updateUser);
                          DatabaseService(uid: Log_In.currentUser.uid).updateName1(_nameController.text);
                          DatabaseService(uid: Log_In.currentUser.uid).updateNick(_userNameController.text);
                          DatabaseService(uid: Log_In.currentUser.uid).updatePhoto(_uploadedFileURL);
                           var snapShot2=await Firestore.instance.collection('profiles').document(Log_In.currentUser.uid).get();
                           Update_Profile.n=0;
                           while(true){
                             var snapShot=await Firestore.instance.collection('posts').document('${Update_Profile.n}').get();
                             if(!snapShot.exists){
                               break;}
                             if(snapShot.data['uid']==Log_In.currentUser.uid){
                               await DatabaseService(number: Update_Profile.n).updateName(snapShot2.data['username']);
                             }
                             Update_Profile.n++;
                           }
                           setState(() {

                           });

                          Navigator.of(context).pushNamed('/nav');
                        }

                      }catch(e){
                        print(e);
                        _userNameController.text="";
                        _nameController.text="";
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
