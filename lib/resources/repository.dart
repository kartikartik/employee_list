// the code below is used to create a class that will act as an abstraction layer
// for the data source provider which is our local database
import 'package:employee_list/database/database_controller.dart';
import 'package:employee_list/model/employee_list_model.dart';

class Repository {
  // the code below is used to create an instance of the DatabaseController class
  final DatabaseController dbController = DatabaseController();

  Future getAllEmpLists() => dbController.getAllEmpList();

  Future insertEmpLists(EmployeeListModel empList) =>
      dbController.createEmpList(empList);

  Future updateEmpLists(EmployeeListModel empList) =>
      dbController.updateEmpList(empList);

  Future deleteEmpLists(int index) => dbController.deleteEmpList(index);
}
