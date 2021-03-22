import 'package:MyProperty/screens/home/profile.dart';
import 'package:MyProperty/screens/home/settings.dart';
import 'package:flutter/material.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:MyProperty/models/user.dart';

class Home extends StatefulWidget {
	@override
	_HomeState createState() => _HomeState();
}
//TODO design the home page
//TODO make differences according to guest or not
class _HomeState extends State<Home> {

	final AuthService _auth = AuthService();
	final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

	@override
	Widget build(BuildContext context) {
	final user = Provider.of<MyUser>(context);

		return Scaffold(
			key: _scaffoldKey,
			appBar: AppBar(
				leading: IconButton(
					icon: Icon(Icons.menu),
					onPressed: () {
						setState(() {
							_scaffoldKey.currentState.openDrawer();
						});
					},
				),
				title: Text("Home"),
			),
			drawer: Drawer(
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
			),
		);
	}
}