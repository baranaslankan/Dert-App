import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Log_In extends StatefulWidget {
  static FirebaseUser currentUser;
  @override
  _Log_InState createState() => _Log_InState();
}

class _Log_InState extends State<Log_In> {


  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  child: Image.network('https://www.geekgirlauthority.com/wp-content/uploads/2020/03/Screen-Shot-2020-03-01-at-12.09.15-PM-1280x640.png'),
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 16, 230, 16),
                  child: Text("GİRİŞ YAP",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'E-mail',
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
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.security),
                      labelText: 'Şifre',
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
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 8, 50, 8),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Şifremi unuttum.',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  letterSpacing: 1.0,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                  Navigator.of(context).pushNamed('/forgot');
                                  }),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 80),
                      child: MaterialButton(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                        child: Text(
                          'Giriş Yap',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          try{
                            FirebaseUser user=(await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text)).user;
                          if(!user.isEmailVerified){
                            showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text("E-mail"),
                                  content: Text("Lütfen mail adresinizi doğrulayınız !"),
                                );
                              }
                            );
                          }
                            if(user!=null && user.isEmailVerified){
                            setState(() {
                              Log_In.currentUser=user;
                            });
                            Navigator.of(context).pushReplacementNamed('/nav');
                          }
                          }catch(error){
                            switch(error.code){
                              case 'ERROR_USER_NOT_FOUND':
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text("Hesap"),
                                      content: Text("Kullanıcı Bulunamadı !"),
                                    );
                                  }
                                );
                                _emailController.text="";
                                _passwordController.text="";
                                break;
                              case 'ERROR_WRONG_PASSWORD':
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Hesap"),
                                        content: Text("Şifre Hatalı !"),
                                      );
                                    }
                                );
                                _emailController.text="";
                                _passwordController.text="";
                                break;
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 10.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Henüz kayıt olmadınız mı ?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        letterSpacing: 1.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Buradan kayıt olun.',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () => {Navigator.of(context).pushNamed('/sign_up')}),
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
