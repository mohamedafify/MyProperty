

import 'package:flutter/material.dart';

class Screen {
	final BuildContext _context;
	double _width;
	double _height;
	get width {
		return _width;
	}
	get height {
		return _height;
	}
	Screen(this._context) {
		_height = MediaQuery.of(_context).size.height;
		_width = MediaQuery.of(_context).size.width;
	}

}