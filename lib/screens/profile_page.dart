import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sample_app/components/custom_appbar.dart';
import 'package:sample_app/utilities/config.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, this.name, this.phoneNumber, this.email}) : super(key: key);
final name, phoneNumber, email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const  CustomAppBar(
        appTitle: 'Profile Page',
        icon: FaIcon(Icons.arrow_back,),

        actions: [
          SizedBox(width: 50,)
        ],
      ),
      body: Column(

        children: [
          // Expanded(
          //     flex: 4,
          //     child: Container(
          //       width: double.infinity,
          //       color: Config.primaryColor,
          //       child: const Column(
          //         children: <Widget>[
          //           SizedBox(height: 110,),
          //           CircleAvatar(
          //             radius: 65.0,
          //             backgroundColor: Colors.white,
          //             backgroundImage: AssetImage('assets/profile1.jpg'),
          //           ),
          //           SizedBox(height: 10,),
          //           Text('Amanda Tan',
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 20,
          //             ),),
          //           SizedBox(height: 10,),
          //           Text('23 years old | Female',
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 15,
          //             ),)
          //         ],
          //       ),
          //
          //     )),
          Expanded(
              flex: 5,
              child: Container(
                // color: Colors.grey[200],
                color: Colors.white,
                child: Center(
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(0, 45, 0, 0),
                    child: Container(
                      width: 325,
                      height: 260,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                             const Text(
                              'Profile',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800
                              ),
                            ),
                            Divider(
                              color: Colors.grey[300],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.blueAccent[400],
                                  size: 35,
                                ),
                                const SizedBox(width: 20,),
                                // TextButton(
                                //     onPressed: (){},
                                //     child: const Text('Profile',
                                //       style: TextStyle(
                                //         color: Config.primaryColor,
                                //         fontSize: 15,
                                //       ),))
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            ),
                            Config.spaceSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.mobile_friendly_outlined,
                                  color: Colors.yellowAccent[400],
                                  size: 35,
                                ),
                                const SizedBox(width: 20,),
                                // TextButton(
                                //     onPressed: (){},
                                //     child: const Text('History',
                                //       style: TextStyle(
                                //         color: Config.primaryColor,
                                //         fontSize: 15,
                                //       ),))
                                Text(
                                  phoneNumber,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            ),
                            Config.spaceSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Colors.lightGreen[400],
                                  size: 35,
                                ),
                                const SizedBox(width: 20,),
                                // TextButton(
                                //     onPressed: (){},
                                //     child: const Text('Logout',
                                //       style: TextStyle(
                                //         color: Config.primaryColor,
                                //         fontSize: 15,
                                // //       ),))
                                Text(
                                  email,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ) )
        ],
      ),
    );
  }
}
