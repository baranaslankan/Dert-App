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
        centerTitle: true,
        title: Text(Rank.userName),
      ),
    );
  }
}
