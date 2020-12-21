import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
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
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 165,vertical: 10),
                              child: Text(snapshot.data[index].data['data']),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,10,270,5),
                              child: FlatButton.icon(
                                icon: Icon(Icons.smoking_rooms_sharp,
                                color: Colors.blue,),
                                label: Text("Yak"),
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
