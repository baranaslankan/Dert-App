
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  int number,points;
  DatabaseService({this.uid,this.number,this.points});

  final CollectionReference profiles=Firestore.instance.collection('profiles');
  final CollectionReference posts=Firestore.instance.collection('posts');

  Future updateUserData(String name,String userName,String email,String image)async{
    return await profiles.document(uid).setData({
      'name':name,
      'username':userName,
      'email':email,
      'image':image,
    });
  }
  Future updatePosts(String data,String uid,int points)async{
    return await posts.document(number.toString()).setData({
      'data':data,
      'uid':uid,
      'points':points,
    });
  }
  Future updatePoints(int points)async{
    return await posts.document((number.toString())).updateData({'points':points});
  }




}