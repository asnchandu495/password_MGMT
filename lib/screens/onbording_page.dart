import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sample_app/screens/auth_page.dart';
class OnBordingPage extends StatefulWidget {
  const OnBordingPage({Key? key}) : super(key: key);

  @override
  State<OnBordingPage> createState() => _OnBordingPageState();
}

class _OnBordingPageState extends State<OnBordingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        scrollPhysics: BouncingScrollPhysics(),
        showSkipButton: true,
        showDoneButton: true,
        showNextButton: true,
        onDone: (){
          print('Done');
          Navigator.of(context).pushNamedAndRemoveUntil('auth', (route) => false);
        },
        onSkip: (){
          print('Skip');
          Navigator.of(context).pushNamedAndRemoveUntil('auth', (route) => false);
        },
        done: Text('Done'),
        next: Text('next'),
        skip: Text('Skip'),
        pages: [
          PageViewModel(


            titleWidget: Text('Write Title of Page', style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),),
            body: 'Write The more content of the page',
            image: Image.asset('images/img-1.jpg', height: 800,width: 400,),


          ),
          PageViewModel(
            titleWidget: Text('Write Title of Page', style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),),
            body: 'Write The more content of the page',
            image: Image.asset('images/img-2.jpg', height: 800,width: 400,),


          ),
          PageViewModel(
            titleWidget: Text('Write Title of Page', style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),),
            body: 'Write The more content of the page',
            image: Image.asset('images/img-3.jpg', height: 800,width: 400,),


          )
        ],
        dotsDecorator: DotsDecorator(
          size: Size.square(10.0),
          activeSize: Size(20.0,10.0),
          color: Colors.black38,
          activeColor: Colors.blue,
          spacing: EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          )
        ),
      ),
    );
  }
}
