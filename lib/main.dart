import 'package:flutter/material.dart';
import 'package:sample_app/components/signup_form.dart';
import 'package:sample_app/screens/auth_page.dart';
import 'package:sample_app/screens/onboarding_page.dart';
import 'package:sample_app/screens/onbording_page.dart';
import 'package:sample_app/screens/otp_verification_page.dart';
import 'package:sample_app/screens/profile_page.dart';
import 'package:sample_app/utilities/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Doctor App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorBorder,
          floatingLabelStyle: TextStyle(color:Config.primaryColor),
          enabledBorder: Config.outlineBorder,
          prefixIconColor: Colors.black38,
        ),

        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Config.primaryColor,
          selectedItemColor: Colors.white,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          unselectedItemColor: Colors.grey.shade700,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      initialRoute: '/',
      routes:  {
        '/' : (context) => const OnBordingPage(),
        'auth' : (context) => AuthPage(),
        // 'main' : (context) => const MainLayout(),
        // 'doc_details' : (context) => const DoctorDetails(),
        // 'booking_page' : (context) => const BookingPage(),
        // 'success_booking' : (context) => const AppointmentBooked(),
        'otp_page' : (context) =>  OtpPage(email: '', onPressed: () { },),
        'sign_up' : (context) => const SignUpForm(),
        'profile_page' : (context) => const ProfilePage()

      },

    );
  }
}


