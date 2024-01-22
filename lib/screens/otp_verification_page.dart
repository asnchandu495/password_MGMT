import 'dart:async';
import 'dart:ffi';



import 'package:email_otp/email_otp.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sample_app/components/button.dart';
import 'package:sample_app/components/custom_appbar.dart';
import 'package:sample_app/components/signup_form.dart';
import 'package:sample_app/utilities/config.dart';



class OtpPage extends StatefulWidget {
  const OtpPage({Key? key, required this.email, required this.onPressed }) : super(key: key);

final String email;
  final Function() onPressed;
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  bool invalidOtp = false;
  bool isSignIn = false;
  int resendTime = 30;

  late Timer countdownTimer;
  final TextEditingController text1 = TextEditingController();
  final TextEditingController text2 = TextEditingController();
  final TextEditingController text3 = TextEditingController();
  final TextEditingController text4 = TextEditingController();
  final TextEditingController text = TextEditingController();


  // EmailAuth emailAuth =  EmailAuth(sessionName: "Sample session");



  @override
  void initState() {
    startTimer();
    super.initState();
  }
  startTimer(){
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime = resendTime-1;
      });
      if(resendTime<1){
        countdownTimer.cancel();
      }
    });
  }
  stopTimer(){
    if(countdownTimer.isActive){
      countdownTimer.cancel();
    }
  }
  String strFormatting(n) => n.toString().padLeft(2, '0');

  // void verifyOTP() async {
  //   var res = emailAuth.validateOtp(recipientMail: widget.email, userOtp:text1.text+text2.text+text3.text + text4.text);
  //   if(res){
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('OTP verified')));
  //      Navigator.of(context).pushNamed('/');
  //   }else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid OTP')));
  //   }
  // }
//
void verifyOTP () async{
  String inputOTP = text1.text + text2.text + text3.text + text4.text;
  print(inputOTP);
  var otpVal = int.parse(inputOTP);
  print(otpVal );
  if(await myauth.verifyOTP(otp: inputOTP ) == true){

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('OTP verified')));
    Navigator.of(context).pushNamed('/');
  }else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid OTP')));
    stopTimer();
  }
}


  void sendOTP() async{
    myauth.setConfig(
        appEmail: 'contact@hdvscoder.com',
        appName: 'doctor_app',
        userEmail: widget.email,
        otpLength: 4,
        otpType: OTPType.digitsOnly
    );
    if(await myauth.sendOTP() == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('OTP has been sent')));
      Navigator.of(context).pushNamed('otp_page');

    }else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Oops, OTP sent failed')));

    }

  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const  CustomAppBar(
        appTitle: 'Verification',
        icon: FaIcon(Icons.arrow_back,),

        actions: [
          SizedBox(width: 50,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(

          child: SingleChildScrollView(
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Verification Code',
                style: TextStyle(fontSize: 24),),
                Config.spaceSmall,
                const Text('Enter the 4 digit verification code received',
                style: TextStyle(fontSize: 18),),
                Config.spaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // TextFormField(
                    // controller: text,
                    // decoration:
                    // const InputDecoration(hintText: "User Email")),

                    myInputBox(context, text1),
                    myInputBox(context, text2),
                    myInputBox(context, text3),
                    myInputBox(context, text4),
                  ],
                ),
                Config.spaceSmall,
                Visibility(
                  visible: invalidOtp,
                  child: const Text('Invalid verification code',
                  style: TextStyle(fontSize: 18, color: Colors.red),),
                ),
                Visibility(
                    visible: invalidOtp,
                    child:Config.spaceSmall, ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Haven\'t received OTP yet ?',
                    style: TextStyle(fontSize: 18),),
                    const SizedBox(width: 10,),
                    resendTime == 0 ? InkWell(
                      onTap: (){
                      invalidOtp = false;
                      resendTime = 30 ;
                      startTimer();
                      sendOTP();
                        // widget.onPressed();
                      },
                      child: const Text('Resend', style: TextStyle(color: Colors.red, fontSize: 18),),)
                        : const SizedBox(),
                  ],
                ),
                Config.spaceSmall,
                resendTime !=0 ? Text('You can resend OTP after ${strFormatting(resendTime)}  second(s)', style: TextStyle(fontSize: 18),) :  const SizedBox(),
                Config.spaceSmall,
                Button(
                    width: double.infinity,
                    title: 'Submit',
                    onPressed: () {
                    //   final otp = text1.text + text2.text + text3.text +
                    //       text4.text;
                    //   if (otp == '4321') {
                    //     stopTimer();
                    //     Navigator.of(context).pushReplacementNamed('/');
                    //   } else {
                    //     setState(() {
                    //       invalidOtp = true;
                    //     });
                    //   }
                    // },
                    //
                      verifyOTP();

                    },
                //     async{
                // if(await myauth.verifyOTP(otp: text1.text+text2.text+text3.text + text4.text) == true){
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('OTP verified')));
                // Navigator.of(context).pushNamed('/');
                // }else{
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid OTP')));
                // }
                //
                //
                // },
                    disable: false)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget myInputBox(BuildContext context,TextEditingController controller) {
  return Container(
    height: 65,
    width: 60,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
    ),
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,

      maxLength: 1,
      onChanged: (value){
        if(value.length == 1) {
          FocusScope.of(context).nextFocus();
        }if (value.length == 0 ){
          FocusScope.of(context).previousFocus();
        }
      },
      style: const TextStyle( fontSize: 25),
      decoration: const InputDecoration(
        counterText: '',
      ),
    ),
  );
}
