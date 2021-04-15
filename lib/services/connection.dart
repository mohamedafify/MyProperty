import 'dart:io';

import 'package:flutter/foundation.dart';

class Connection extends ChangeNotifier {
	static bool _hasInternet = false;
	static get hasInternet {
		return _hasInternet;
	}

	Future<void> checkConnection() async {
		try {
			final result = await InternetAddress.lookup('google.com');
			if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
				_hasInternet = true;
			else
				_hasInternet = false;
		} on SocketException catch (_) {
				_hasInternet = false;
			}
		notifyListeners();
	}
}