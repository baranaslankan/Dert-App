import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  Future getPosts()async{
    var firestore=Firestore.instance;
    QuerySnapshot posdata=await firestore.collection('posts').getDocuments();
    return posdata.documents;
  }
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        centerTitle: true,
        title: Text("Notifications"),
      ),
      body: Center(
        child: PageView(controller: controller,
          children: [
            FutureBuilder(
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
                            child: Text("${snapshot.data[snapshot.data.length-index-1].data['postedby']} bir dert paylaştı !"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            child: Divider(
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
