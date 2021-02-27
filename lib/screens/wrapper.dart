import 'package:flutter/material.dart';
import 'package:my_property/models/user.dart';
import 'package:my_property/screens/authenticate/authenticate.dart';
import 'package:my_property/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
	  // return authenticate, home page
	  final user = Provider.of<MyUser>(context);
	  // checks if the user is logged in
	  if (user != null) {
		  return Home();
	  }
      return Authenticate();
  }
}