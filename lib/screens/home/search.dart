import 'package:MyProperty/utils/pagesRefresher.dart';
import 'package:MyProperty/utils/search/filterCheckBox.dart';
import 'package:MyProperty/utils/search/searchCategories.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:MyProperty/viewModels/searchViewModel.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
	final SearchCategories searchUtils;
	final PagesRefresher pagesRefresher;
	SearchPage(this.searchUtils, this.pagesRefresher);
	@override
	_SearchPageState createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage> {
	SearchViewModel viewModel;
	void refresh() {
		setState((){});
	}

	@override
	void initState() {
		viewModel = SearchViewModel(widget.searchUtils);
		widget.pagesRefresher.searchPageRefresh = refresh;
		super.initState();
	}
	@override
	Widget build(BuildContext context) {
		sort mySort = sort.MostRecent;
		return Scaffold(
			appBar: AppBar(
				actions: [
					PopupMenuButton(
						onSelected: (sort sortCategory) {
							switch(sortCategory) {
								case sort.MostRecent:
									mySort = sort.MostRecent;
									break;
								case sort.HighToLow:
									mySort = sort.HighToLow;
									break;
								case sort.LowToHigh:
									mySort = sort.LowToHigh;
									break;
							}
						},
						child: Row(
							children: [
								Text(
									"Sort",
									style: TextStyle(
										fontSize: 20,
									),
								),
								SizedBox(width: 5),
								Icon(
									Icons.sort,
									size: 25,
								),
							]
						),
						itemBuilder: (context) {
							return <PopupMenuEntry<sort>>[
								PopupMenuItem(
									value: sort.MostRecent,
									child: Row(
										children: [
											mySort == sort.MostRecent ?
											Icon(Icons.check_circle,
												color: Colors.black,
											) :
											Icon(Icons.check_circle_outline_outlined,
												color: Colors.black,
											),
											SizedBox(width: 5),
											Text("Most Recent"),
										]
									),
								),
								PopupMenuItem(
									value: sort.HighToLow,
									child: Row(
										children: [
											mySort == sort.HighToLow ?
											Icon(Icons.check_circle,
												color: Colors.black,
											) :
											Icon(Icons.check_circle_outline_outlined,
												color: Colors.black,
											),
											SizedBox(width: 5),
											Text("Price: High to Low")
										]
									),
								),
								PopupMenuItem(
									value: sort.LowToHigh,
									child: Row(
										children: [
											mySort == sort.LowToHigh ?
											Icon(Icons.check_circle,
												color: Colors.black,
											) :
											Icon(Icons.check_circle_outline_outlined,
												color: Colors.black,
											),
											SizedBox(width: 5),
											Text("Price: Low to High")
										]
									),
								)
							];
						},
					)
				],
			),
			body: SingleChildScrollView(
				padding: EdgeInsets.all(20),
				child:Column(
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						// ad type
						TextField(
							controller: TextEditingController(
								text:
								StringHelp.filterPickerToString(widget.searchUtils.adTypes),
							),
							decoration: InputDecoration(
								labelText: "Ad type",
								border: OutlineInputBorder(
									borderSide: BorderSide(
										color: Colors.black,
									),
								),
							),
							enableInteractiveSelection: false,
							readOnly: true,
							textAlign: TextAlign.left,
							style: TextStyle(
								color: Colors.black,
								fontWeight: FontWeight.normal,
								fontSize: 20,
							),
							onTap: () {
								showModalBottomSheet(
									context: context,
									elevation: 20,
									builder: (context) {
										return StatefulBuilder(
											builder: (context, StateSetter setState) {
												return ListView.builder(
													padding: EdgeInsets.only(left: 20),
													itemBuilder: (context, index) {
														return
																FilterCheckBox(widget.searchUtils.adTypes.entries.elementAt(index),
																		widget.searchUtils.adTypes,
																		setState,
																		index
																		== 0 ?
																		true :
																		false,
																		widget.pagesRefresher);
													},
													itemCount:
													widget.searchUtils.adTypes.length
												);
											},
										);
									}
								);
							},
						),
						SizedBox(height: 10),
						// property type
						TextField(
							controller: TextEditingController(
								text:
								StringHelp.filterPickerToString(widget.searchUtils.propertyType),
							),
							decoration: InputDecoration(
								labelText: "Property type",
								border: OutlineInputBorder(
									borderSide: BorderSide(
										color: Colors.black,
									),
								),
							),
							enableInteractiveSelection: false,
							readOnly: true,
							textAlign: TextAlign.left,
							style: TextStyle(
								color: Colors.black,
								fontWeight: FontWeight.normal,
								fontSize: 20,
							),
							onTap: () {
								showModalBottomSheet(
									context: context,
									elevation: 20,
									builder: (context) {
										return StatefulBuilder(
											builder: (context, StateSetter setState) {
												return ListView.builder(
													padding: EdgeInsets.only(left: 20),
													itemBuilder: (context, index) {
														return
																FilterCheckBox(widget.searchUtils.propertyType.entries.elementAt(index),
																		widget.searchUtils.propertyType,
																		setState,
																		index
																		== 0 ?
																		true :
																		false,
																		widget.pagesRefresher);
													},
													itemCount: widget.searchUtils.propertyType.length
												);
											},
										);
									}
								);
							},
						),
						SizedBox(height: 10),
						// finishing degree 
						TextField(
							controller: TextEditingController(
								text:
								StringHelp.filterPickerToString(widget.searchUtils.finishingDegree),
							),
							decoration: InputDecoration(
								labelText: "Finishing Degree",
								border: OutlineInputBorder(
									borderSide: BorderSide(
										color: Colors.black,
									),
								),
							),
							enableInteractiveSelection: false,
							readOnly: true,
							textAlign: TextAlign.left,
							style: TextStyle(
								color: Colors.black,
								fontWeight: FontWeight.normal,
								fontSize: 20,
							),
							onTap: () {
								showModalBottomSheet(
									context: context,
									elevation: 20,
									builder: (context) {
										return StatefulBuilder(
											builder: (context, StateSetter setState) {
												return ListView.builder(
													padding: EdgeInsets.only(left: 20),
													itemBuilder: (context, index) {
														return
																FilterCheckBox(widget.searchUtils.finishingDegree.entries.elementAt(index),
																		widget.searchUtils.finishingDegree,
																		setState,
																		index
																		== 0 ?
																		true :
																		false,
																		widget.pagesRefresher);
													},
													itemCount: widget.searchUtils.finishingDegree.length
												);
											},
										);
									}
								);
							},
						),
						SizedBox(height: 10),



						/********Bottom*********/
						TextButton(
							child: Text(
								"Apply",
								style: TextStyle(
									fontSize: 20
								)
							),
							onPressed: () async {
								// refresh HomePage
								viewModel.applyFilters();
								widget.pagesRefresher.homePageRefresh();
								Navigator.pop(context);
							},
						),
					]
				),
			),
		);	
	}
}
