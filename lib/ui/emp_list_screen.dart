import 'package:employee_list/ui/edit_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:employee_list/blocs/emp_list_bloc.dart';
import 'package:employee_list/model/employee_list_model.dart';
import 'package:employee_list/ui/add_emp_list_screen.dart';

// the code below is used to create the Emp list screen of the app
class EmpListScreen extends StatelessWidget {
  const EmpListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // the code below is used to call the getAllEmpLists method to get all the emp list
    // from the database
    empListBloc.getAllEmpLists();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Employee List'),
      ),
      body: StreamBuilder<List<EmployeeListModel>>(
        stream: empListBloc.allEmpList,
        builder: (context, AsyncSnapshot<List<EmployeeListModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(4),
                        color: Colors.grey[350],
                        child: const Text(
                          "Current Employee",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      handleCurrentEmp(context, snapshot),
                      Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(4),
                        color: Colors.grey[350],
                        child: const Text("Previous Employee",
                            style: TextStyle(color: Colors.blue)),
                      ),
                      handlePreviousEmp(context, snapshot)
                    ],
                  )
                : const Center(
                    child: Text(
                      "No Record Found",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  );
          } else if (snapshot.hasError) {
            // the code below is used to print the error on the screen
            return Text(snapshot.error.toString());
          } else if (snapshot.data == null) {
            return const Center(
              child: Text(
                "Enter your Employee Name",
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEmpListScreen()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget handleCurrentEmp(
      BuildContext context, AsyncSnapshot<List<EmployeeListModel>> snapshot) {
    return Expanded(
        child: ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return snapshot.data![index].empToDate.toString().isEmpty
            ? Container(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Dismissible(
                        key: UniqueKey(),
                        background: const ColoredBox(
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (DismissDirection direction) {
                          empListBloc
                              .deleteEmpList(snapshot.data![index].id!.toInt());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Employee data has been deleted!!'),
                            ),
                          );
                          // Your deletion logic goes here.
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditEmployeeScreen(
                                      empData: snapshot.data![index]),
                                ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                snapshot.data![index].empName.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                snapshot.data![index].empRole.toString(),
                              ),
                              Text(
                                snapshot.data![index].empFromDate.toString(),
                              ),
                              Text(snapshot.data![index].empToDate.toString()),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                // padding: EdgeInsets.all(10),
                                height: 1,
                                color: Colors.grey[200],
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              )
            : const SizedBox();
      },
    ));
  }

  Widget handlePreviousEmp(
      BuildContext context, AsyncSnapshot<List<EmployeeListModel>> snapshot) {
    return Expanded(
        child: ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Dismissible(
                  key: UniqueKey(),
                  background: const ColoredBox(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (DismissDirection direction) {
                    empListBloc
                        .deleteEmpList(snapshot.data![index].id!.toInt());
                    // Your deletion logic goes here.
                  },
                  child: snapshot.data![index].empToDate.toString() != "null" &&
                          snapshot.data![index].empToDate.toString() != "" &&
                          snapshot.data![index].empToDate.toString() !=
                              "No Date"
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditEmployeeScreen(
                                      empData: snapshot.data![index]),
                                ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                snapshot.data![index].empName.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                snapshot.data![index].empRole.toString(),
                              ),
                              Text(
                                snapshot.data![index].empFromDate.toString(),
                              ),
                              snapshot.data![index].empToDate.toString() !=
                                      "null"
                                  ? Text(snapshot.data![index].empToDate
                                      .toString())
                                  : const SizedBox(),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                // padding: EdgeInsets.all(10),
                                height: 1,
                                color: Colors.grey[200],
                              )
                            ],
                          ))
                      : const SizedBox()),
            ],
          ),
        );
      },
    ));
  }
}
