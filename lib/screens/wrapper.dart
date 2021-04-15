import 'package:MyProperty/screens/home/homeWrapper.dart';
import 'package:MyProperty/services/connection.dart';
import 'package:MyProperty/utils/noInternet.dart';
import 'package:flutter/material.dart';
import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		// return authenticate or home page
		final user = Provider.of<MyUser>(context);
		final connection = context.watch<Connection>();
		// checks if the user is logged in
		if (Connection.hasInternet) {
			if (user != null) {
				return HomeWrapper();
			}
			return Authenticate();
		} else {
			connection.checkConnection();
			return NoInternet();
		}
	}
}