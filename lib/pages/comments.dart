import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projext/pages/home.dart';
import 'package:projext/pages/log_in.dart';
import 'package:projext/services/database.dart';

class Comments extends StatefulWidget {
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  Future getComments()async{
    var firestore=Firestore.instance;
    QuerySnapshot posdata=await firestore.collection('posts').document(Home.index1.toString()).collection('comments').getDocuments();
    return posdata.documents;
  }
  TextEditingController _commentController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 200,
                width: 500,
                child: FutureBuilder(
                  future: getComments(),
                  builder: (_,snapshot){
                    return ListView.builder(
                      itemCount: snapshot?.data?.length ?? 0,
                      itemBuilder: (_,index){
                        return Material(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text("${snapshot.data[index].data['uid']}: ${snapshot.data[index].data['comment']}")),
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,500,8,0),
                child: TextField(
                  cursorColor: Colors.blueGrey[800],
                  controller: _commentController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.comment,color: Colors.blueGrey[800],),
                    labelText: 'Yorum',focusColor: Colors.blueGrey[800],
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[800]),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow[800]),
                    ),
                    labelStyle: TextStyle(
                        color: Colors.grey[800]
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20,10,20,20),
                child: MaterialButton(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    padding: EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                    child: Text(
                      'Gönder',
                      style: TextStyle(color: Colors.white),
                    ),
                  color: Colors.yellow[800],
                  onPressed: ()async{
                    int num=0;
                      var snapShot=await Firestore.instance.collection('posts').document(Home.index1.toString()).collection('comments').document(num.toString()).get();
                      while(snapShot.exists){
                        num++;
                        snapShot=await Firestore.instance.collection('posts').document(Home.index1.toString()).collection('comments').document(num.toString()).get();
                      }
                      DatabaseService(number: Home.index1).commentPosts(_commentController.text, Log_In.currentUser.uid,num);
                    setState(() {
                      _commentController.text="";
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
