import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:employee_list/blocs/emp_list_bloc.dart';
import 'package:employee_list/model/employee_list_model.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

const List<String> list = <String>[
  'Product Designer',
  'Flutter Developer',
  'QA Tester',
  'Product Owner'
];

class AddEmpListScreen extends StatefulWidget {
  const AddEmpListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _AddEmpListScreenState createState() => _AddEmpListScreenState();
}

class _AddEmpListScreenState extends State<AddEmpListScreen> {
  // getting the task name
  String? empName;
  String dropdownValue = list.first;
  DateTime todayDate = DateTime.now();
  DateTime fromDate = DateTime.now();

  // String selectedDate = "Today";
  bool btnTodaySelected = true;
  bool btnNextMonSelected = false;
  bool btnNextTueSelected = false;
  bool btnWeekSelected = false;

  final _selectedDate = BehaviorSubject<String>();
  final _selectedToDate = BehaviorSubject<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _selectedDate.close();
    _selectedToDate.close();

    super.dispose();
  }

  void updateData(String newData) {
    _selectedDate.add(newData);
  }

  void updateToData(String newData) {
    _selectedToDate.add(newData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Add Employee Details'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: const InputDecoration(
                  // border: InputBorder.none,
                  hintText: "Employee Name",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    empName = value;
                  });
                },
              ),
              const SizedBox(
                height: 25.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.blueGrey)),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      enabled: false,
                      prefixIcon: Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.blue,
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                  hint: const Text('Select Role'),
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50.0,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(color: Colors.blueGrey)),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(color: Colors.blue),
                        // backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (ctxt) => AlertDialog(
                                  title: handleCalendar(ctxt),
                                ));
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.blue,
                      ),
                      label: StreamBuilder<String>(
                        stream: _selectedDate,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text('${snapshot.data}');
                          } else {
                            return const Text('Today');
                          }
                        },
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.blue,
                  ),
                  Container(
                    height: 50.0,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(color: Colors.blueGrey)),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(color: Colors.blue),
                        // backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      onPressed: () async {
                        if (_selectedDate.hasValue) {
                          showDialog(
                              context: context,
                              builder: (ctxt) => AlertDialog(
                                    title: handleToCalendar(ctxt),
                                  ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('First Select from date'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.blue,
                      ),
                      label: StreamBuilder<String>(
                        stream: _selectedToDate,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text('${snapshot.data}');
                          } else {
                            return const Text('No Date');
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )),
              const SizedBox(
                height: 25.0,
              ),
              const Spacer(),
              Row(
                children: [
                  MaterialButton(
                      child: Container(
                        width: 100.0,
                        height: 50.0,
                        color: Colors.blue[100],
                        child: const Center(
                          child: Text(
                            "Cancel",
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  MaterialButton(
                      child: Container(
                        width: 200.0,
                        height: 50.0,
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            "Save",
                          ),
                        ),
                      ),
                      onPressed: () {
                        empListBloc.addEmpList(EmployeeListModel(
                          empName: empName,
                          empRole: dropdownValue,
                          empFromDate: _selectedDate.value,
                          empToDate: _selectedToDate.hasValue
                              ? _selectedToDate.value
                              : "",
                          done: false,
                        ));

                        Navigator.pop(context);
                      }),
                ],
              )
            ],
          ),
        ));
  }

  Widget handleCalendar(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    width: 120.0,
                    // height: 50.0,
                    decoration: BoxDecoration(
                      color: btnTodaySelected ? Colors.blue : Colors.blue[50],
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    // color: Colors.blue,
                    child: Center(
                      child: Text(
                        "Today",
                        style: TextStyle(
                            color:
                                btnTodaySelected ? Colors.white : Colors.blue),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      btnTodaySelected = true;
                      btnNextMonSelected = false;
                      btnNextTueSelected = false;
                      btnWeekSelected = false;

                      DateTime todayDate = DateTime.now();
                      final date = DateFormat('dd MMM yyyy');
                      updateData(date.format(
                          DateTime.fromMillisecondsSinceEpoch(
                              todayDate.millisecondsSinceEpoch)));
                    });
                  }),
              MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    // width: 200.0,
                    // height: 50.0,
                    decoration: BoxDecoration(
                      color: btnNextMonSelected ? Colors.blue : Colors.blue[50],
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    // color: Colors.blue,
                    child: Center(
                      child: Text(
                        "Next Monday",
                        style: TextStyle(
                            color: btnNextMonSelected
                                ? Colors.white
                                : Colors.blue),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      btnTodaySelected = false;
                      btnNextMonSelected = true;
                      btnNextTueSelected = false;
                      btnWeekSelected = false;

                      DateTime todayDate = DateTime.now();
                      DateTime nextMon = todayDate.next(DateTime.monday);
                      final date = DateFormat('dd MMM yyyy');

                      updateData(date.format(
                          DateTime.fromMillisecondsSinceEpoch(
                              nextMon.millisecondsSinceEpoch)));
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    width: 120.0,
                    // height: 50.0,
                    decoration: BoxDecoration(
                      color: btnNextTueSelected ? Colors.blue : Colors.blue[50],
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    // color: Colors.blue,
                    child: Center(
                      child: Text(
                        "Next Tuesday",
                        style: TextStyle(
                            color: btnNextTueSelected
                                ? Colors.white
                                : Colors.blue),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      btnTodaySelected = false;
                      btnNextMonSelected = false;
                      btnNextTueSelected = true;
                      btnWeekSelected = false;

                      DateTime todayDate = DateTime.now();
                      DateTime nextTue = todayDate.next(DateTime.tuesday);
                      final date = DateFormat('dd MMM yyyy');

                      updateData(date.format(
                          DateTime.fromMillisecondsSinceEpoch(
                              nextTue.millisecondsSinceEpoch)));
                    });
                  }),
              MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    // height: 50.0,
                    decoration: BoxDecoration(
                      color: btnWeekSelected ? Colors.blue : Colors.blue[50],
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    // color: Colors.blue,
                    child: Center(
                      child: Text(
                        "After 1 Week",
                        style: TextStyle(
                            color:
                                btnWeekSelected ? Colors.white : Colors.blue),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      btnTodaySelected = false;
                      btnNextMonSelected = false;
                      btnNextTueSelected = false;
                      btnWeekSelected = true;

                      DateTime todayDate = DateTime.now();
                      final date = DateFormat('dd MMM yyyy');
                      DateTime nextWeek = todayDate.add(Duration(days: 7));

                      updateData(date.format(
                          DateTime.fromMillisecondsSinceEpoch(
                              nextWeek.millisecondsSinceEpoch)));
                    });
                  }),
            ],
          ),
          SizedBox(
            width: 300,
            height: 400,
            child: DatePicker(
              highlightColor: Colors.blue,
              slidersColor: Colors.blue,
              splashColor: Colors.blue,
              minDate:
                  DateTime(todayDate.year - 10, todayDate.month, todayDate.day),
              maxDate: DateTime(todayDate.year, todayDate.month, todayDate.day),
              onDateSelected: (value) {
                // Handle selected date
                log("$value");
                fromDate = value;
                final date = DateFormat('dd MMM yyyy');

                updateData(date.format(DateTime.fromMillisecondsSinceEpoch(
                    value.millisecondsSinceEpoch)));
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.grey,
          ),
          Row(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  StreamBuilder<String>(
                    stream: _selectedDate,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          '${snapshot.data}',
                          style: const TextStyle(fontSize: 14),
                        );
                      } else {
                        return const Text('-');
                      }
                    },
                  ),
                ],
              ),
              MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ]);
      },
    );
  }

  Widget handleToCalendar(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    width: 80.0,
                    // height: 50.0,
                    decoration: BoxDecoration(
                      color: btnTodaySelected ? Colors.blue[50] : Colors.blue,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    // color: Colors.blue,
                    child: Center(
                      child: Text(
                        "No Date",
                        style: TextStyle(
                            color:
                                btnTodaySelected ? Colors.blue : Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      btnTodaySelected = false;
                      updateToData("No Date");
                    });
                  }),
              MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    width: 120.0,
                    // height: 50.0,
                    decoration: BoxDecoration(
                      color: btnTodaySelected ? Colors.blue : Colors.blue[50],
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    // color: Colors.blue,
                    child: Center(
                      child: Text(
                        "Today",
                        style: TextStyle(
                            color:
                                btnTodaySelected ? Colors.white : Colors.blue),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      btnTodaySelected = true;

                      DateTime todayDate = DateTime.now();
                      final date = DateFormat('dd MMM yyyy');
                      updateToData(date.format(
                          DateTime.fromMillisecondsSinceEpoch(
                              todayDate.millisecondsSinceEpoch)));
                    });
                  }),
            ],
          ),
          SizedBox(
            width: 300,
            height: 400,
            child: DatePicker(
              minDate:
                  DateTime(fromDate.year, fromDate.month, fromDate.day + 1),
              maxDate:
                  DateTime(fromDate.year + 20, fromDate.month, fromDate.day),
              onDateSelected: (value) {
                // Handle selected date
                log("$value");

                final date = DateFormat('dd MMM yyyy');

                updateToData(date.format(DateTime.fromMillisecondsSinceEpoch(
                    value.millisecondsSinceEpoch)));
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.grey,
          ),
          Row(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  StreamBuilder<String>(
                    stream: _selectedToDate,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          '${snapshot.data}',
                          style: const TextStyle(fontSize: 14),
                        );
                      } else {
                        return const Text('-');
                      }
                    },
                  ),
                ],
              ),
              MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              MaterialButton(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        ]);
      },
    );
  }
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return this.add(
      Duration(
        days: (day - this.weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}
