import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:projext/pages/addDert.dart';
import 'package:projext/pages/log_in.dart';
import 'package:projext/services/database.dart';

class Home extends StatefulWidget {
  static int index1;
  static String yorum;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getPosts()async{
    var firestore=Firestore.instance;
    QuerySnapshot posdata=await firestore.collection('posts').getDocuments();
    return posdata.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dertler"),
      ),
      body: FutureBuilder(
        future: getPosts(),
        builder: (_,snapshot){
          return ListView.builder(
            itemCount: snapshot?.data?.length ?? 0,
            itemBuilder: (_,index){
              return Material(
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if(Log_In.currentUser.uid==snapshot.data[snapshot.data.length-index-1].data['uid'])
                                PopupMenuButton(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                    child: Icon(
                                      Icons.menu,
                                      color: Colors.grey[850],
                                    ),
                                  ),
                                  onSelected: (String value) async{
                                    var snapShot2=await Firestore.instance.collection('profiles').document(snapshot.data[snapshot.data.length-index-1].data['uid']).get();
                                  switch (value) {
                                  case 'Sil':
                                 setState(() {
                                   DatabaseService(number:snapshot.data.length-index-1 ).deletePost();
                                   DatabaseService(uid: snapshot.data[snapshot.data.length-index-1].data['uid']).updatePoints2(snapShot2.data['points']-snapshot.data[snapshot.data.length-index-1].data['points']);
                                 });
                                  break;
                                  }
                                  },
                                  itemBuilder: (BuildContext context){
                                    return {'Sil'}.map((String choice) {
                                      return PopupMenuItem(
                                        value: choice,
                                        child: Text(choice),
                                      );
                                    }).toList();
                                  },
                                ),
                              ],
                            ),
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  child: Text("${snapshot.data[snapshot.data.length-index-1].data['data']}\n\nPuan: ${snapshot.data[snapshot.data.length-index-1].data['points']}\n\nPaylaşan: ${snapshot.data[snapshot.data.length-index-1].data['postedby']}"),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0,10,270,0),
                                  child: FlatButton.icon(
                                    onPressed: ()async{
                                      String color;
                                      var snapShot=await Firestore.instance.collection('profiles').document(snapshot.data[snapshot.data.length-index-1].data['uid']).get();
                                      int n=0;
                                      while(n<snapshot.data[snapshot.data.length-index-1].data['liste'].length){
                                        if(snapshot.data[snapshot.data.length-index-1].data['liste'][n]==Log_In.currentUser.uid){
                                          setState(() {
                                            DatabaseService(number: snapshot.data.length-index-1).updatePoints(snapshot.data[snapshot.data.length-index-1].data['points']-1);
                                            DatabaseService(uid: snapshot.data[snapshot.data.length-index-1].data['uid']).updatePoints2(snapShot.data['points']-1);
                                            DatabaseService(number: snapshot.data.length-index-1).updateList2(Log_In.currentUser.uid);
                                            //snapshot.data[snapshot.data.length-index-1].data['liste'].data[n]==null;
                                          });
                                          break;
                                        }
                                        else {
                                          if (n ==
                                              snapshot.data[snapshot.data.length -
                                                  index - 1].data['liste'].length -
                                                  1) {
                                            setState(() {
                                              DatabaseService(
                                                  number: snapshot.data.length -
                                                      index - 1).updatePoints(
                                                  snapshot.data[snapshot.data
                                                      .length - index - 1]
                                                      .data['points'] + 1);
                                              DatabaseService(
                                                  uid: snapshot.data[snapshot.data
                                                      .length - index - 1]
                                                      .data['uid']).updatePoints2(
                                                  snapShot.data['points'] + 1);
                                              DatabaseService(
                                                  number: snapshot.data.length -
                                                      index - 1).updateList(
                                                  Log_In.currentUser.uid);
                                              //snapshot.data[snapshot.data.length-index-1].data['liste'].add(Log_In.currentUser.uid);
                                            });
                                            break;
                                          }

                                        }
                                        n++;}
                                      if(snapshot.data[snapshot.data.length-index-1].data['liste'].length==0){
                                        setState(() {
                                          DatabaseService(number: snapshot.data.length-index-1).updatePoints(snapshot.data[snapshot.data.length-index-1].data['points']+1);
                                          DatabaseService(uid: snapshot.data[snapshot.data.length-index-1].data['uid']).updatePoints2(snapShot.data['points']+1);
                                          DatabaseService(number: snapshot.data.length-index-1).updateList(Log_In.currentUser.uid);
                                          //snapshot.data[snapshot.data.length-index-1].data['liste'].add(Log_In.currentUser.uid);
                                        });
                                      }





                                    },
                                    icon: Icon(Icons.smoking_rooms_sharp,
                                    color: HexColor(snapshot.data[snapshot.data.length-index-1].data['liste'].contains(Log_In.currentUser.uid) ? '#C0C0C0':'#0000FF' )),
                                    label: Text("Yak"),
                                  ),
                                ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                              child: FlatButton.icon(
                                icon: Icon(Icons.comment,color: Colors.blue,),
                                label: Text('Yorum yap'),
                                onPressed: (){
                                 // Home.yorum=snapshot.data[snapshot.data.length-index-1].collection('comments').document(snapshot.data.lenght-index-1).data['comment'];
                                  Home.index1=snapshot.data.length-index-1;
                                  Navigator.of(context).pushNamed('/comments');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );

  }
}
