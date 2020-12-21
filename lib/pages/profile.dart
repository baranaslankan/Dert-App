import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projext/pages/log_in.dart';
import 'package:projext/services/database.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future getDatas()async{
    var firestore=Firestore.instance;
    DocumentSnapshot pdata=await firestore.collection('profiles').document(Log_In.currentUser.uid).get();
    return pdata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profil"),
        actions: [
          PopupMenuButton<String>(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
            onSelected: handleClick,
            itemBuilder: (BuildContext context){
              return{"Profili Güncelle","Uygulama Ayarları","Çıkış Yap"}.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 4.0),
                child: Card(
                  child: Image(
                    image: NetworkImage('https://www.geekgirlauthority.com/wp-content/uploads/2020/03/Screen-Shot-2020-03-01-at-12.09.15-PM-1280x640.png'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8,200,8,0),
                child: Divider(
                  height: 40.0,
                  thickness: 2.0,
                ),
              ),
              Padding(
                padding:  EdgeInsets.fromLTRB(155, 140, 0, 30),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(Log_In.currentUser.photoUrl),
                ),
              ),
            ],
          ),
         Expanded(
           child: Container(
             padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
             child: FutureBuilder(
               future: getDatas(),
               builder: (_,snapshot){
                 return ListView.builder(
                   itemCount: 1,
                   itemBuilder: (_,index){
                     return Material(
                       child: Column(
                         children: [
                           ListTile(
                             title: index==0 ? Text("İsim Soyisim: ${snapshot.data['name']}\nKullanıcı Adı: ${snapshot.data['username']}\nE-Posta: ${snapshot.data['email']}"): null ,
                           ),
                         ],
                       ),
                     );
                   },
                 );
               },
             ),
           ),
         ),
        ],
      ),
    );
  }
  void handleClick(String value) async{
    switch (value) {
      case 'Profili Güncelle':
        Navigator.of(context).pushNamed('/updatep');
        break;
      case 'Uygulama Ayarları':
        break;
      case 'Çıkış Yap':
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushNamed('/log_in');
        break;
    }
  }
}
