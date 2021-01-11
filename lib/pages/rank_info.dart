import 'package:flutter/material.dart';
import 'package:projext/pages/rank.dart';

class Rank_Info extends StatefulWidget {
  @override
  _Rank_InfoState createState() => _Rank_InfoState();
}

class _Rank_InfoState extends State<Rank_Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        centerTitle: true,
        title: Text(Rank.userName),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 50),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                backgroundImage: NetworkImage(Rank.snap.data[Rank.rank2].data['image']),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 10, 8, 30),
              child: Divider(
                thickness: 4,
              ),
            ),
            Text('Kullanıcı adı: ${Rank.snap.data[Rank.rank2].data['username']}'),
            Text('Ad Soyad: ${Rank.snap.data[Rank.rank2].data['name']}'),
            Text('E-Posta: ${Rank.snap.data[Rank.rank2].data['email']}'),
            Text('Puan: ${Rank.snap.data[Rank.rank2].data['points']}'),
            Text('Sıralama: ${Rank.rank2+1}'),
          ],
        ),
      ),
    );
  }
}
