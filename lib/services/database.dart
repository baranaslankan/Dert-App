import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  int number=0;
  DatabaseService({this.uid,this.number});

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
  Future updatePosts(String data)async{
    return await posts.document(number.toString()).setData({
      'data':data,
    });
  }



}