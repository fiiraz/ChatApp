import 'package:flutter/material.dart';
import 'package:simplefire/screens/card_screen.dart';
import 'package:simplefire/screens/details_screen.dart';
import 'package:simplefire/screens/reviews_screen.dart';
import 'package:simplefire/screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/third_party_setup_screen.dart';

final routes = {
  '/': (BuildContext context) => new SplashScreen(),
  '/login': (BuildContext context) => new LoginScreen(),
  '/signup': (BuildContext context) => new SignupScreen(),
  '/home': (BuildContext context) => new HomeScreen(),
  '/third_party_setup': (BuildContext context) => new ThirdPartySetupScreen(),
  '/reviews': (BuildContext context) => new ReviewsScreen(),
  '/card': (BuildContext context) => new CardScreen(),
  '/details': (BuildContext context) => new DetailsScreen(),
};
