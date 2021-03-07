import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_property/screens/utils/constant.dart';
import 'package:my_property/screens/wrapper.dart';
import 'package:my_property/services/auth.dart';
import 'package:my_property/models/user.dart';
import 'package:provider/provider.dart';


Future<void> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
	Widget build(BuildContext context) {
		return StreamProvider<MyUser>.value(
			value: AuthService().user,
			child: MaterialApp(
				theme: ThemeData(fontFamily: Constant.font),
				home: Wrapper(),
			),
		);
	}
}
