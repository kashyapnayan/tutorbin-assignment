import 'package:flutter/material.dart';
import 'package:tutorbin/providers/cart_provider.dart';
import 'package:tutorbin/view/home_screen.dart';
import 'package:provider/provider.dart';

import 'const/const.dart';
import 'providers/home_provider.dart';

void main() {
  runApp(const ConfigureApp());
}

class ConfigureApp extends StatefulWidget {
  const ConfigureApp({Key? key}) : super(key: key);

  @override
  State<ConfigureApp> createState() => _ConfigureAppState();
}

class _ConfigureAppState extends State<ConfigureApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Const.appName,
        theme: ThemeData(
          primaryColor: Const.appPrimaryColor,
          progressIndicatorTheme:
              ProgressIndicatorThemeData(color: Const.appPrimaryColor),
        ),
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => const HomeScreen(),
        },
      ),
    );
  }
}
