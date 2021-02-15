import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projext/pages/log_in.dart';
import 'package:projext/pages/rank.dart';
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
        backgroundColor: Colors.yellow[800],
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
          FutureBuilder(
            future: getDatas(),
            builder: (_,snapshot){
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                itemCount: snapshot.hasData? 1:0,
                itemBuilder: (_,index){
                  return Material(
                      child: Stack(
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
                            padding:  EdgeInsets.fromLTRB(155, 150, 0, 0),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(snapshot.data['image']),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),

                  );
                }
              );
            }
          ),
         Expanded(
           child: Container(
             padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
             child: FutureBuilder(
               future: getDatas(),
               builder: (_,snapshot){
                 return ListView.builder(
                   itemCount: snapshot.hasData? 1: 0,
                   itemBuilder: (_,index){
                     return Material(
                       child: Column(
                         children: [
                           Card(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(40),
                             ),
                             child: ListTile(
                               title:  Padding(padding: EdgeInsets.all(20),child: Text("İsim Soyisim: ${snapshot.data['name']}\n\nKullanıcı Adı: ${snapshot.data['username']}\n\nE-Posta: ${snapshot.data['email']}\n\nPuan: ${snapshot.data['points']}\n\nSıralama: ${Rank.rank}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)) ,
                             ),
                             color: Colors.yellow[100],
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
