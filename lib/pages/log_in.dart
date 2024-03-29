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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://www.fonewalls.com/wp-content/uploads/2020/04/Yellow-Phone-Wallpaper.jpg'),
            fit: BoxFit.cover,
          )
        ),
        child: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    child: Text("Dert App",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),),
                    padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 16.0),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(10, 16, 230, 16),
                  //   child: Text("GİRİŞ YAP",
                  //     style: TextStyle(
                  //       color: Colors.grey[800],
                  //       fontSize: 35.0,
                  //       fontWeight: FontWeight.bold,
                  //     ),),
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: TextField(
                      cursorColor: Colors.blueGrey[800],
                      controller: _emailController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: 'Mail adresinizi giriniz',
                        labelStyle: TextStyle(
                          color: Colors.grey[800]
                        ),
                        prefixIcon: Icon(Icons.email,color: Colors.blueGrey[800],),
                        labelText: 'E-mail',focusColor: Colors.blueGrey[800],
                        // enabledBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.blue,
                        //   ),
                        // ),
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(30.0),
                        // ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: TextField(
                      cursorColor: Colors.blueGrey[800],
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: "Şifrenizi giriniz",
                        labelStyle: TextStyle(
                          color: Colors.blueGrey[800],
                        ),
                        prefixIcon: Icon(Icons.security,color: Colors.blueGrey[800],),
                        labelText: 'Şifre',focusColor: Colors.blueGrey[800],
                        // enabledBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.blue,
                        //   ),
                        // ),
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(30.0),
                        // ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(240, 8, 0, 5),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Şifremi unuttum',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    letterSpacing: 1.0,
                                    color: Colors.white,
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
                        padding: EdgeInsets.fromLTRB(100, 20, 100, 0),
                        child: MaterialButton(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          padding: EdgeInsets.fromLTRB(45.0, 9.0, 45.0, 9.0),
                          child: Text(
                            'Giriş Yap',
                            style: TextStyle(color: Colors.yellow[800],fontSize: 17),
                          ),
                          color: Colors.white,
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
                    padding: EdgeInsets.fromLTRB(16.0, 150.0, 16.0, 0.0),
                    child: RichText(
                      text: TextSpan(
                        text: 'Henüz kayıt olmadınız mı ?',
                        style: TextStyle(
                          color: Colors.blueGrey[900],
                          fontSize: 15.0,
                          letterSpacing: 1.0,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Buradan kayıt olun.',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () => {Navigator.of(context).pushReplacementNamed('/sign_up')}),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
