import 'package:MyProperty/screens/wrapper.dart';
import 'package:MyProperty/services/connection.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/services/auth.dart';
import 'package:MyProperty/models/user.dart';
import 'package:provider/provider.dart';


Future<void> main() async{
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp();
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MultiProvider(
			providers: [
				StreamProvider<MyUser>.value(
					initialData: null,
					value: AuthService().user,
				),
				ChangeNotifierProvider(
					create: (_) => Connection(),
				),
			],
			child: MaterialApp(
				theme: ThemeData(fontFamily: Constant.font),
				home: Wrapper(),
			),
		);
	}
}
