
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:otp_tester/home.dart';
import 'package:otp_tester/phone_login.dart';
import 'package:otp_tester/verify.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(otp());
}
class otp extends StatefulWidget {

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'phone_login',
      routes: {
        'phone_login':(context)=>PhoneLogin(),
        'verify':(context)=>VerifyOtp(),
        'home':(context)=>Home(),
      },
      // home: LoginPage()
    );
  }
}
