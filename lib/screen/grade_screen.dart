import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/**
 * My implemention using my friend's made backend
 * optimized version available here:
 * https://github.com/bienreti/pbp-uas-flutter
 */
class Grade extends StatefulWidget {
  const Grade({Key? key, required this.jsonMap, required this.jsonList})
      : super(key: key);
  final Map<String, dynamic> jsonMap;
  final List<dynamic> jsonList;
  @override
  _GradeState createState() => _GradeState();
}

class _GradeState extends State<Grade> {
  final _formKey = GlobalKey<FormState>();
  late List<dynamic> _filteredData;
  TextEditingController controller = TextEditingController();
  TextEditingController input = TextEditingController();
  int _rowsPerPage = 10;
  int _currentSortColumn = 0;
  bool _isAscending = true;
  late String _timeHours;
  late String _timeYear;
  String _searchResult = '';

  @override
  void initState() {
    _filteredData = widget.jsonList;
    _timeHours =
        "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
    int val = DateTime.now().weekday;
    String weekday;
    if (val == 1) {
      weekday = "Monday";
    } else if (val == 2) {
      weekday = "Tuesday";
    } else if (val == 3) {
      weekday = "Wednesday";
    } else if (val == 4) {
      weekday = "Thursday";
    } else if (val == 5) {
      weekday = "Friday";
    } else if (val == 6) {
      weekday = "Saturday";
    } else {
      weekday = "Sunday";
    }
    _timeYear =
        "$weekday, ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _getCurrentTimeHours());
    Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _getCurrentTimeYear());
    super.initState();
  }

  void _getCurrentTimeHours() {
    if (mounted) {
      setState(() {
        _timeHours =
            "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
      });
    }
  }

  void _getCurrentTimeYear() {
    if (mounted) {
      setState(() {
        int val = DateTime.now().weekday;
        String weekday;
        if (val == 1) {
          weekday = "Monday";
        } else if (val == 2) {
          weekday = "Tuesday";
        } else if (val == 3) {
          weekday = "Wednesday";
        } else if (val == 4) {
          weekday = "Thursday";
        } else if (val == 5) {
          weekday = "Friday";
        } else if (val == 6) {
          weekday = "Saturday";
        } else {
          weekday = "Sunday";
        }
        _timeYear =
            "$weekday, ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: [
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.jsonMap['name'].split('-')[1].trim(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(_timeHours),
                      Text(_timeYear),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.search),
                  title: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                      onChanged: (value) {
                        setState(() {
                          /**/
                          _searchResult = value.toLowerCase();
                          _filteredData = widget.jsonList
                              .where((data) =>
                                  data['name']
                                      .toString()
                                      .toLowerCase()
                                      .contains(_searchResult) ||
                                  data['score']
                                      .toString()
                                      .toLowerCase()
                                      .contains(_searchResult))
                              .toList();
                        });
                      }),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        controller.clear();
                        _searchResult = '';
                        _filteredData = widget.jsonList;
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.fromLTRB(20, 2.5, 20, 20),
              child: PaginatedDataTable(
                onRowsPerPageChanged: (v) {
                  setState(() {
                    _rowsPerPage = v!;
                  });
                },
                availableRowsPerPage: const [10, 25, 50, 100],
                rowsPerPage: _rowsPerPage,
                sortColumnIndex: _currentSortColumn,
                sortAscending: _isAscending,
                columns: [
                  DataColumn(
                      label: const Text(
                        'Task Name',
                      ),
                      onSort: (columnIndex, _) {
                        setState(() {
                          _currentSortColumn = columnIndex;
                          if (_isAscending) {
                            _isAscending = false;
                            _filteredData.sort((a, b) => a['name']
                                .toString()
                                .compareTo(b['name'].toString()));
                          } else {
                            _isAscending = true;
                            _filteredData.sort((a, b) => b['name']
                                .toString()
                                .compareTo(a['name'].toString()));
                          }
                        });
                      }),
                  DataColumn(
                      label: const Text(
                        'Score',
                      ),
                      // Sorting function
                      onSort: (columnIndex, _) {
                        setState(() {
                          _currentSortColumn = columnIndex;
                          if (_isAscending) {
                            _isAscending = false;
                            _filteredData.sort(
                                (a, b) => a['score'].compareTo(b['score']));
                          } else {
                            _isAscending = true;
                            _filteredData.sort(
                                (a, b) => b['score'].compareTo(a['score']));
                          }
                        });
                      }),
                ],
                columnSpacing: 100,
                horizontalMargin: 10,
                showCheckboxColumn: false,
                source: Data(_filteredData),
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: const Text(
                        'Ask The Teacher',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        width: 300,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                              child: const Text(
                                'Question',
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.top,
                                maxLines: 7,
                                controller: input,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0.0)),
                                  ),
                                  hintText: "Enter your suggestions or critics",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'This field can\'t be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: ElevatedButton(
                        child: const Text(
                          "Submit Question",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepPurple)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            input.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}

class Data extends DataTableSource {
  Data(this._data);

  final List<dynamic> _data;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['name'].toString())),
      DataCell(Text('${_data[index]['score']}')),
    ]);
  }
}
