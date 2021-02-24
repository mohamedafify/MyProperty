import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './dashboard.dart';
import './loginpage.dart';

class AuthService {
	handleAuth() {
		return StreamBuilder(
				stream: FirebaseAuth.instance.authStateChanges(),
				builder: (BuildContext context, snapshot) {
					if (snapshot.hasData) {
						return DashboardPage();
					} else {
						return LoginPage();
					}
				});
	}

	//Sign out
	signOut() {
		FirebaseAuth.instance.signOut();
	}

	//SignIn
	signIn(context, AuthCredential authCreds) async {
		try {
			await FirebaseAuth.instance.signInWithCredential(authCreds);
			Navigator.of(context).pop();
		} on FirebaseAuthException catch (e) {
//			print('Failed with error code: ${e.code}');
			print(e.message);
			_showMyDialog(context, e.code, e.message);
//			return e.code;
//			LoginPage().showMyDialog(e.code);
//			LoginPage().verifyPhone();
		}
	}

	signInWithOTP(context, smsCode, verId) {
		AuthCredential authCreds =
				PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
		signIn(context, authCreds);
	}

	Future<void> _showMyDialog(context, String msgcode, String msgbody) async {
		return showDialog<void>(
			context: context,
			barrierDismissible: false, // user must tap button!
			builder: (BuildContext context) {
				return AlertDialog(
					title: Text(msgcode),
					content: SingleChildScrollView(
						child: ListBody(
							children: <Widget>[
								Text(msgbody),
							],
						),
					),
					actions: <Widget>[
						TextButton(
							child: Text('موافقة'),
							onPressed: () {
								Navigator.of(context).pop();
							},
						),
					],
				);
			},
		);
	}
}
