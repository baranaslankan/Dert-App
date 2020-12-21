

import 'package:flutter/material.dart';
import 'package:projext/pages/addDert.dart';
import 'package:projext/pages/bottom_nav.dart';
import 'package:projext/pages/forgot_password.dart';
import 'package:projext/pages/log_in.dart';
import 'package:projext/pages/sign_up.dart';
import 'package:projext/pages/updateProfile.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/':(context)=>Log_In(),
      '/nav':(context)=>Bottom_Nav(),
      '/log_in':(context)=>Log_In(),
      '/sign_up':(context)=>Sign_up(),
      '/updatep':(context)=>Update_Profile(),
      '/adddert':(context)=>ADD_Dert(),
      '/forgot':(context)=>ForgotPassword(),
    },
  ));
}

