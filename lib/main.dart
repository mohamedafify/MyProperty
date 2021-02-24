import 'package:flutter/material.dart';
import 'package:my_property/screens/landing.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
	WidgetsFlutterBinding.ensureInitialized();
	runApp(App());
}

class App extends StatelessWidget {
	final Future<FirebaseApp> _initialization = Firebase.initializeApp();

	@override
	Widget build(BuildContext context) {
		return FutureBuilder(
			future: _initialization,
			builder: (context, snapshot) {
				if (snapshot.hasError) {
					return UnexpectedError();
				}
				if (snapshot.connectionState == ConnectionState.done) {
					return MaterialApp(
						theme: ThemeData.light(),
						debugShowCheckedModeBanner: false,
						home: AuthService().handleAuth(),
					);
				}
				return Loading();
			},
		);
	}
}

class UnexpectedError extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
				theme: ThemeData.dark(),
				home: Scaffold(
						appBar: AppBar(title: Text('MyProperty')),
						body: Center(
							child: Text('Something went wrong... try again later'),
						)));
	}
}


class Loading extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
				theme: ThemeData.dark(),
				home: Scaffold(
						appBar: AppBar(title: Text('MyProperty')),
						body: Center(
							child: Text('App loading...'),
						)));
	}
}
