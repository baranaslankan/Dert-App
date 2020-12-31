
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  int number;
  DatabaseService({this.uid,this.number});

  final CollectionReference profiles=Firestore.instance.collection('profiles');
  final CollectionReference posts=Firestore.instance.collection('posts');
  

  Future updateUserData(String name,String userName,String email,String image,int points)async{
    return await profiles.document(uid).setData({
      'name':name,
      'username':userName,
      'email':email,
      'image':image,
      'points':points,
    });
  }
  Future updatePosts(String data,String uid,int points,String postedby,List<String> liste)async{
    return await posts.document(number.toString()).setData({
      'data':data,
      'uid':uid,
      'points':points,
      'postedby':postedby,
      'liste':liste,
    });
  }
  Future updatePhoto(String url)async{
    return await profiles.document((uid)).updateData({'image':url});
  }
  Future updateName1(String name)async{
    return await profiles.document((uid)).updateData({'name':name});
  }
  Future updateNick(String nick)async{
    return await profiles.document((uid)).updateData({'username':nick});
  }
  Future updatePoints(int points)async{
    return await posts.document((number.toString())).updateData({'points':points});
  }
  Future updateName(String postedby)async{
    return await posts.document((number.toString())).updateData({'postedby':postedby});
  }
  Future updatePoints2(int points)async{
    return await profiles.document((uid)).updateData({'points':points});
  }
  Future updateList(String uid)async{
    return await posts.document((number.toString())).updateData({'liste':FieldValue.arrayUnion([uid])});
  }
  Future updateList2(String uid)async{
    return await posts.document((number.toString())).updateData({'liste':FieldValue.arrayRemove([uid])});
  }




}