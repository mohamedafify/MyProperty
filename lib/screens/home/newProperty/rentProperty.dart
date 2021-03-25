import 'package:MyProperty/models/property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RentPropertyPage extends StatefulWidget {
	@override
	_RentPropertyPageState createState() => _RentPropertyPageState();
}

class _RentPropertyPageState extends State<RentPropertyPage> {
	final _formKey = GlobalKey<FormState>();
	final RentProperty property = RentProperty();
	DateTime currentDateTime = DateTime.now();
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Form(
				key: _formKey,
				child: ListView(
					padding: EdgeInsets.only(left: 10, right: 10),
					children:<Widget> [
						// title
						TextFormField(
							style: TextStyle(
								fontSize: 20,
								decoration: TextDecoration.none,
							),
							validator: (val) => val.isEmpty ? "" : null,
							decoration: InputDecoration(
								hintText: "Title"
							),
							onChanged: (val) {
								// setState(() => _email = val);
							},
						),
						// location
						TextFormField(
							style: TextStyle(
								fontSize: 20,
							),
							validator: (val) => val.isEmpty ? "" : null,
							decoration: InputDecoration(
								hintText: "location"
							),
							onChanged: (val) {
								// setState(() => _email = val);
							},
						),
						TextButton(
							child: Text("avalible for rent date"),
							onPressed: () {
								DatePicker.showDatePicker(
									context,
									minTime: currentDateTime,
									showTitleActions: true,
									onConfirm: (value) {
										property.rentableAt = value;
									},
								);
							},
						),
						TextFormField(
							style: TextStyle(
								fontSize: 40,
							),
							validator: (val) => val.isEmpty ? "" : null,
							decoration: InputDecoration(
								hintText: "Title"
							),
							onChanged: (val) {
								// setState(() => _email = val);
							},
						),
						TextFormField(
							style: TextStyle(
								fontSize: 40,
							),
							validator: (val) => val.isEmpty ? "" : null,
							decoration: InputDecoration(
								hintText: "Title"
							),
							onChanged: (val) {
								// setState(() => _email = val);
							},
						),
					],
				),
			)
		);
	}
}