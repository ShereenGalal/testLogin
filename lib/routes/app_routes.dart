import 'package:flutter/material.dart';
import '../presentation/sign_in_screen/sign_in_screen.dart';

class AppRoutes {
  static const String signInScreen = '/sign_in_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes =>
      {signInScreen: SignInScreen.builder, initialRoute: SignInScreen.builder};
}
