import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_tester/phone_login.dart';
import 'package:pinput/pinput.dart';

class VerifyOtp extends StatelessWidget {
//   String verificationId;
//   VerifyOtp({
//    required this.verificationId
// });

final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code='';
    return

      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Phone Verification',style: TextStyle(fontSize: 22),),
                Text("We need to register your phone before gettting started",style: TextStyle(fontSize: 16),),

            Pinput(
              onChanged: (value){
                code=value;
              },
              length: 6,
              // defaultPinTheme: defaultPinTheme,
              // focusedPinTheme: focusedPinTheme,
              // submittedPinTheme: submittedPinTheme,
              validator: (s) {
                return s == '2222' ? null : 'Pin is incorrect';
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) => print(pin),
            ),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () async{
                    try{
                      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: PhoneLogin.verify,
                          smsCode: code);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      /// jab otp true ho gi to age page pe jaye ga other wise nhe jaye ga
                      Navigator.pushNamedAndRemoveUntil(context,
                          "home", (route) => false);
                    }catch(e){

                    }

                    // Navigator.pushNamed(context, 'phone_login');
                  }, child: Text("verify Code"),
                    
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                ),
                Row(
                  children: [
                    TextButton(onPressed: (){
                     Navigator.pushNamedAndRemoveUntil(context, 'phone_login',
                             (route) => false);
                    }, child: Text('Edit phone Number?'
                      ,style: TextStyle(color: Colors.black),))
                  ],
                )

              ],
            ),
          ),
        ),
      );
  }
}
