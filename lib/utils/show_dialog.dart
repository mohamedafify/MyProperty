import 'package:flutter/material.dart';
class ShowDialog {
	Future<void> showDialogOnScreen(context, String msgcode, String msgbody) async {
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
							child: Text("Confirm"),
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