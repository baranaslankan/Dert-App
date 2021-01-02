import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projext/pages/log_in.dart';

class Rank extends StatefulWidget {
  static String userName;
  static int rank,rank2;
  static var snap;
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {

  Future getDatas()async{
    var firestore=Firestore.instance;
    QuerySnapshot rdata=await firestore.collection('profiles')
        .orderBy("points", descending: true).getDocuments();
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
              if(snapshot.data[index].data['email']==Log_In.currentUser.email){
              Rank.rank=index+1;}
              return Material(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('${index+1}- ${snapshot.data[index].data['username']}'),
                      onTap: (){
                        setState(() {
                          Rank.userName=snapshot.data[index].data['username'];
                          Rank.snap=snapshot;
                          Rank.rank2=index;
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
