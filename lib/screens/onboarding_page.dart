import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        children: [
          // Column(
          //   children: [
          //     SizedBox(height: 5,),
          //     Image.asset('images/img-1.png',width: 100, height: 100,)
          //   ],
          // ),
          Container(
            color: Colors.blue,
            child: const Center(
              child: Text('Page 1'),
            ),
          ),
          Container(
            color: Colors.green,
            child: const Center(
              child: Text('Page 2'),
            ),
          ),
          Container(
            color: Colors.blue,
            child: const Center(
              child: Text('Page 3'),
            ),
          ),
        ],
      ),
    );
  }
}
