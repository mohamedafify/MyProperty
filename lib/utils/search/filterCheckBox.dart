import 'package:MyProperty/utils/pagesRefresher.dart';
import 'package:flutter/material.dart';

class FilterCheckBox extends StatefulWidget {
	final Map<String, bool> map;
	final MapEntry<String, bool> entry;
	final StateSetter listStateSetter;
	final bool isAll;
	final PagesRefresher pagesRefresher;
	FilterCheckBox(this.entry, this.map, this.listStateSetter, this.isAll,
			this.pagesRefresher);
	@override
	_FilterCheckBoxState createState() => _FilterCheckBoxState();
}

class _FilterCheckBoxState extends State<FilterCheckBox> {
	void checkerHandler(Map<String, bool> map, bool isAll) {
		int counter = 0;
		// count all checked boxs but 'All'
		map.entries.forEach((element) {
			if (element.key != "All") {
				if (element.value == true) {
					counter++;
				}
			}
		});
		if (!isAll) {
			// if any checkbox other than 'All' is pressed removed the check from 'All'
			if (map.entries.first.value == true) {
				map.entries.forEach((element) {
					if (element.key != "All" && element.value == true) {
						map[map.entries.first.key] = false;
						return;
					}
				});
			}
			// if all checkbox checked removed all checked and check 'All'
			if (counter == map.length - 1) {
				map.entries.forEach((element) {
					if (element.key != "All") {
						map[element.key] = false;
					} else {
						map[element.key] = true;
					}
				});
			}
		} else {
			// if 'All checkbox checked remove all checkers in the list
			map.entries.forEach((element) {
				if (element.key != "All") {
					map[element.key] = false;
				}
			});
		}
		// if nothing is checked but 'All' don't uncheck all
		if (counter == 0) {
			map[map.entries.first.key] = true;
		}
	}
	@override
	Widget build(BuildContext context) {
		return Row(
			children: [
				Text(
					widget.entry.key,
					style: TextStyle(
						fontSize: 20,
					),
				),
				Checkbox(
					value: widget.entry.value,
					onChanged: (isChecked) {
						widget.listStateSetter.call(() {
							widget.map[widget.entry.key] = isChecked;
							checkerHandler(widget.map, widget.isAll);
						});
						widget.pagesRefresher.searchPageRefresh();
					}
				)
			]
		);
	}
}
