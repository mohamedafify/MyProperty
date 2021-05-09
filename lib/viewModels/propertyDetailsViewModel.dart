import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/database.dart';
import 'package:MyProperty/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';


class PropertyDetailsViewModel {
	final GlobalKey scaffoldKey;
	PropertyDetailsViewModel(this.scaffoldKey);
	final DatabaseService _database = DatabaseService();

	Future<MyUser> getUserByUID(String uid) async {
		return await _database.getUserByID(uid);
	}
	Future openWhatsappChat(BuildContext context, String number) async {
		String url = "https://wa.me/$number";
		if (await DeviceApps.isAppInstalled("com.whatsapp")) {
			await canLaunch(url) ? await launch(url) : ShowDialog().showDialogOnScreen(scaffoldKey.currentContext, "Couldn't open WhatsApp", "This is a problem please contact us if it keeps showing this error");
		} else {
			ShowDialog().showDialogOnScreen(scaffoldKey.currentContext, "WhatsApp is not installed", "Please install WhatsApp first then try again.");
		}
	}
}