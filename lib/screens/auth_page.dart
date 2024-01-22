import 'package:flutter/material.dart';
import 'package:sample_app/components/login_form.dart';
import 'package:sample_app/components/signup_form.dart';
import 'package:sample_app/utilities/config.dart';
import 'package:sample_app/utilities/text.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignIn = true;

  @override

  Widget build(BuildContext context) {

    Config().init(context);

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus( FocusNode());

      },

      child: Scaffold(

        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppText.enText['welcome_text']!,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Config.spaceSmall,
                    Text(

                      isSignIn ? AppText.enText['signIn_text']!
                      : AppText.enText['register_text']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Config.spaceSmall,
                    isSignIn ?  LoginForm() : SignUpForm(),
                    Config.spaceSmall,
                    isSignIn ? Center(
                      child: TextButton(
                        onPressed: (){},
                        child: Text(
                          AppText.enText['forgot_password']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                        :
                    // Container(),
                    // const SizedBox(height: 10,),
                    // Center(
                    //   child: Text(
                    //     AppText.enText['social_login']!,
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.normal,
                    //       color: Colors.grey.shade400,
                    //     ),
                    //   ),
                    // ),
                    // Config.spaceSmall,
                    // const Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: <Widget>[
                    //    SocialButton(social: 'google',),
                    //     SocialButton(social: 'facebook',),
                    //   ],
                    // ),
                    Config.spaceSmall,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text( isSignIn ?
                          AppText.enText['signUp_text']!
                          : AppText.enText['registered_text']!,
                          style:TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        SizedBox(width: 10,),
                        TextButton(
                            onPressed: (){
                              setState(() {
                                isSignIn = !isSignIn;
                              });
                            },
                            child:  Text(
                              isSignIn ?  'Sign Up' : 'SignIn',

                              style: const TextStyle(

                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),),

                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
