import 'package:flutter/material.dart';
import 'package:yemeksiparis/views/Restaurant/AdminDashboard.dart';
import 'package:yemeksiparis/views/User/UserDashboard.dart';
import 'package:yemeksiparis/Forms/DishAddForm.dart';
import 'package:yemeksiparis/Forms/DishEditForm.dart';
import 'package:yemeksiparis/Forms/UserDetailForm.dart';
import 'package:yemeksiparis/views/LandingPage.dart';
import 'package:yemeksiparis/views/DashboardLoader.dart';
import 'package:yemeksiparis/views/ProfilePage.dart';
import 'package:yemeksiparis/views/SignupPage.dart';
import 'views/LoginPage.dart';
import 'views/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      routes: {
        '/': (context) => LandingPage(),
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/dash': (context) => Dashboard(),
        '/admindash': (context) => AdminDashboard(),
        '/profile' : (context) => ProfileScreen(),
        '/loadDash' : (context) => DashboardLoader(),
        '/dishEditForm' : (context) => DishEditForm(),
        '/dishAddForm' : (context) => DishAddForm(),
        '/userDetailsForm' : (context) => UserDetailForm(),
        '/signup' : (context) => SignupPage(),
      },
    );
  }
}

