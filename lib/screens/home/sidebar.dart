import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/screens/home/profile.dart';
import 'package:MyProperty/screens/home/settings.dart';
import 'package:MyProperty/services/auth.dart';
import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
	final AuthService _auth = AuthService();
	@override
	Widget build(BuildContext context) {
		return Drawer(
			child: Container(
				color: Constant.backgroundColor,
				child: ListView(
					children:<Widget> [
						Container(
							child: Row(
								mainAxisAlignment: MainAxisAlignment.start,
								mainAxisSize: MainAxisSize.max,
								children: [
									SizedBox(
										width: 10,
									),
									Icon(
										Icons.home,
										size: 40.0,
									),
									TextButton(
										child: Text(
											"Home",
											style: TextStyle(
												fontSize: 30,
												color: Colors.black,
											),
										),
										onPressed: () {
											// close drawer because i am already in home
											Navigator.pop(context);
										}
									),
								],
							)
						),
						Container(
							child: Row(
								mainAxisAlignment: MainAxisAlignment.start,
								mainAxisSize: MainAxisSize.max,
								children: [
									SizedBox(
										width: 10,
									),
									Icon(
										Icons.face,
										size: 40.0,
									),
									TextButton(
										child: Text(
											"Profile",
											style: TextStyle(
												fontSize: 30,
												color: Colors.black,
											),
										),
										onPressed: () {
											// close drawer
											Navigator.pop(context);
											Navigator.push(
												context,
												MaterialPageRoute(builder: (context) => Profile()),
											);
										}
									),
								],
							)
						),
						Container(
							child: Row(
								mainAxisAlignment: MainAxisAlignment.start,
								mainAxisSize: MainAxisSize.max,
								children: [
									SizedBox(
										width: 10,
									),
									Icon(
										Icons.settings,
										size: 40.0,
									),
									TextButton(
										child: Text(
											"Settings",
											style: TextStyle(
												fontSize: 30,
												color: Colors.black,
											),
										),
										onPressed: () {
											// close drawer
											Navigator.pop(context);
											Navigator.push(
												context,
												MaterialPageRoute(builder: (context) => Settings()),
											);
										}
									),
								],
							)
						),
						Container(
							child: Row(
								mainAxisAlignment: MainAxisAlignment.start,
								mainAxisSize: MainAxisSize.max,
								children: [
									SizedBox(
										width: 10,
									),
									Icon(
										Icons.logout,
										size: 40.0,
									),
									TextButton(
										child: Text(
											"logout",
											style: TextStyle(
												fontSize: 30,
												color: Colors.black,
											),
										),
										onPressed: () {
											_auth.signOut();
										}
									),
								],
							)
						)
					],
				),
			)
		);
	}
}