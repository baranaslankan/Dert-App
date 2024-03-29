import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projext/services/database.dart';

class Sign_up extends StatefulWidget {
  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {

  File _image;
  String _uploadedFileURL;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
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
                  backgroundImage: _image== null ? NetworkImage('https://www.geekgirlauthority.com/wp-content/uploads/2020/03/Screen-Shot-2020-03-01-at-12.09.15-PM-1280x640.png') : FileImage(_image),
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
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[800]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[800]),
                      ),
                      hintText: 'Mail adresinizi giriniz',
                      labelStyle: TextStyle(
                          color: Colors.grey[800]
                      ),
                      prefixIcon: Icon(Icons.email,color: Colors.blueGrey[800],),
                      labelText: 'E-mail',focusColor: Colors.blueGrey[800],),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextField(
                    cursorColor: Colors.blueGrey[800],
                    controller: _nameController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[800]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[800]),
                      ),
                      hintText: 'İsim Soyisim giriniz',
                      labelStyle: TextStyle(
                          color: Colors.grey[800]
                      ),
                      prefixIcon: Icon(Icons.person,color: Colors.blueGrey[800],),
                      labelText: 'İsim Soyisim',focusColor: Colors.blueGrey[800],),),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextField(
                    cursorColor: Colors.blueGrey[800],
                    controller: _userNameController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[800]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[800]),
                      ),
                      hintText: 'Kullanıcı Adı giriniz',
                      labelStyle: TextStyle(
                          color: Colors.grey[800]
                      ),
                      prefixIcon: Icon(Icons.tag,color: Colors.blueGrey[800],),
                      labelText: 'Kullanıcı Adı',focusColor: Colors.blueGrey[800],),),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextField(
                    cursorColor: Colors.blueGrey[800],
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[800]),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow[800]),
                      ),
                      hintText: 'Şifre giriniz',
                      labelStyle: TextStyle(
                          color: Colors.grey[800]
                      ),
                      prefixIcon: Icon(Icons.security,color: Colors.blueGrey[800],),
                      labelText: 'Şifre',focusColor: Colors.blueGrey[800],),),
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
                      'Kayıt Ol',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.yellow[800],
                    onPressed: () async {
                      try{
                        FirebaseUser user=(await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text)).user;
                        await user.sendEmailVerification();
                      if(user !=null){
                        UserUpdateInfo updateUser=UserUpdateInfo();
                        updateUser.displayName=_userNameController.text;
                        StorageReference storageReference=FirebaseStorage.instance.ref().child('profilePics/${user.uid}');
                        StorageUploadTask uploadTask=storageReference.putFile(_image);
                        await uploadTask.onComplete;
                        await storageReference.getDownloadURL().then((fileURL){
                          setState(() {
                            _uploadedFileURL=fileURL;
                          });
                        });
                        updateUser.photoUrl=_uploadedFileURL;
                        user.updateProfile(updateUser);
                        await DatabaseService(uid: user.uid).updateUserData(_nameController.text, _userNameController.text, _emailController.text, _uploadedFileURL,0);
                        Navigator.of(context).pushReplacementNamed('/log_in');
                      }

                      }catch(error){
                        switch(error.code){
                          case 'ERROR_INVALID_EMAIL':
                            showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("E-mail"),
                                  content: Text("Lütfen geçerli bir mail adresi giriniz !"),
                                );
                              }
                            );
                            _emailController.text="";
                            break;
                          case 'ERROR_WEAK_PASSWORD':
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Şifre"),
                                    content: Text("Şifre çok zayıf !"),
                                  );
                                }
                            );
                            _passwordController.text="";
                            break;
                          case 'ERROR_EMAIL_ALREADY_IN_USE':
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Hesap"),
                                    content: Text("Bu mail adresiyle kayıtlı olan başka bir hesap var !"),
                                  );
                                }
                            );
                            _emailController.text="";
                            break;
                        }
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Zaten hesabınız var mı ?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        letterSpacing: 1.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Buradan giriş yapın.',
                            style: TextStyle(
                              color: Colors.yellow[800],
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {Navigator.of(context).pushReplacementNamed('/log_in')}),
                      ],
                    ),
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
