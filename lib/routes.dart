import 'package:flutter/cupertino.dart';
import 'package:my_auth/register/register_page.dart';
import 'package:my_auth/resetPass/reset_password.dart';

import 'home_page.dart';
import 'login/login_page.dart';

class AppRoutes {
  static const homePage = '/homePage';
  static const loginPage = '/loginPage';
  static const registerPage = '/registerPage';
  static const resetPass = '/resetPass';


  static final Map<String, WidgetBuilder> routes = {
    homePage: (_) => const HomePage(), // home page
    loginPage: (_) => const LoginPage(), // login
    registerPage: (_) => const RegisterPage(), // register page
    resetPass: (_) => const ResetPassword(), // reset password
  };
}
