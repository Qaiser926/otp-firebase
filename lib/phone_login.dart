// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:otp_verification/verify.dart';
//
// class PhoneLogin extends StatefulWidget {
//    PhoneLogin({Key? key}) : super(key: key);
//
//   @override
//   State<PhoneLogin> createState() => _PhoneLoginState();
// }
//
// class _PhoneLoginState extends State<PhoneLogin> {
//   final phoneNumberController=TextEditingController();
//
//   bool loading=false;
//
//   final auth=FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextFormField(
//               keyboardType: TextInputType.number,
//               controller: phoneNumberController,
//               decoration: InputDecoration(
//                 hintText: '+124567',
//               ),
//             ),
//             ElevatedButton(onPressed: (){
//               setState((){
//                 loading=true;
//               });
//               auth.verifyPhoneNumber
//                 (
//                 phoneNumber: phoneNumberController.text.trim(),
//                   verificationCompleted: (_){
//
//               },
//                   /// agr exception a giya to toast me show kar de ge
//                   verificationFailed: (e){
//                 Fluttertoast.showToast(msg: e.toString());
//                   },
//                   /// is me firebase ak verifiction code send kare ga
//                   /// our dosra token send kare ga
//                   /// token hum user see le ge jo front end par recieve ho ga
//                   /// our verification id hum send kare ge
//                   codeSent: (String verification , int? token){
//                   Navigator.push(context, MaterialPageRoute(builder:
//                       (context)=>VerifyOtp(verificationId: verification,)));
//                   },
//                   /// agar time out ho giya to 1 min time out hota eh
//                   codeAutoRetrievalTimeout: (e){
//
//                   });
//             }, child: Text('Login')),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneLogin extends StatefulWidget {
  static String verify='';
  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final phoneController=TextEditingController();

  var phone='';
  TextEditingController countryCode=TextEditingController();

  @override
  void iniState(){
    // TODO implement iniState
    // countryCode.text="+91";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 55,
                decoration: BoxDecoration(

                    border: Border.all(width: 1,color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)

                ),
                child: Row(
                  children: [
                    SizedBox(width: 40,child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                    ),),
                    SizedBox(width: 10,),
                    Text("|",style: TextStyle(fontSize: 30),),
                    SizedBox(width: 4,),
                    Expanded(child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value){
                        phone=value;
                      },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                          hintText: 'Phone'
                    )))
                  ],
                ),
              ),
              Text('Phone Verification',style: TextStyle(fontSize: 22),),
              Text("We need to register your phone before gettting started",style: TextStyle(fontSize: 16),),

              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(onPressed: () async{
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: "${countryCode.text+phone}",
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      PhoneLogin.verify=verificationId;
                      Navigator.pushNamed(context, 'verify');
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},

                  );
                  //
                }, child: Text("Send the code"),
                style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
