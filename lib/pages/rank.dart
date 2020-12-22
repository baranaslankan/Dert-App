import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Rank extends StatefulWidget {
  static String userName;
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {
  Future getDatas()async{
    var firestore=Firestore.instance;
    QuerySnapshot rdata=await firestore.collection('profiles').getDocuments();
    return rdata.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sıralama'),
      ),
      body: FutureBuilder(
        future: getDatas(),
        builder: (_,snapshot){
          return ListView.builder(
            itemCount: snapshot?.data?.length ?? 0,
            itemBuilder: (_,index){
              return Material(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(snapshot.data[index].data['username']),
                      onTap: (){
                        setState(() {
                          Rank.userName=snapshot.data[index].data['username'];
                        });
                        Navigator.of(context).pushNamed('rank_info');
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                      child: Divider(
                        thickness: 4,
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
