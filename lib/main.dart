import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_property/screens/landing.dart';
import 'package:my_property/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
	Widget build(BuildContext context) {
		return MaterialApp(
			//home: Wrapper(),
			home: Landing(),
	);
	}
}
