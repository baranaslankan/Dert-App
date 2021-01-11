import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController _emailController=new TextEditingController();
  @override
  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: Text('Şifre Yenileme'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 150.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Text('Şifresini unuttuğunuz hesabın mail adresini girin !',
                  style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
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
              MaterialButton(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                  child: Text(
                    'Gönder',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.yellow[800],
                  onPressed: ()async{
                    resetPassword(_emailController.text);
                    Navigator.of(context).pushReplacementNamed('/log_in');
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
