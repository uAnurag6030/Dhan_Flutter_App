
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'menuItemsparts/tabControllerScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
     [
       DeviceOrientation.portraitDown,
       DeviceOrientation.portraitUp,
     ]
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tabcontrollerscreen(),
    );
  }
}
