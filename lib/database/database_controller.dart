// the code below is used to create a class to act as a controller for performing
// the operations on our database
import 'package:employee_list/database/database.dart';
import 'package:employee_list/model/employee_list_model.dart';

class DatabaseController {
  // the code below is used to create a property for accessing the database provider
  final dbClient = DatabaseProvider.dbProvider;

  // the code below is used to create a method to add a new task to our empList database
  Future<int> createEmpList(EmployeeListModel emplist) async {
    // the code below is used to get the access to the db getter
    final db = await dbClient.db;
    // the code below is used to insert the data to the empList table using the insert
    // method and passing the instance of the EmployeeListModel as input
    var result = db.insert(
        "empListTable", emplist.toJSON()); // here empListTable is the name of
    // the table in the database
    return result;
  }

  // the code below is used to create a method for getting the list of Emp List Tasks
  // present in the database
  Future<List<EmployeeListModel>> getAllEmpList({List<String>? columns}) async {
    // the code below is used to get the access to the db getter
    final db = await dbClient.db;
    // the code below is used to query the database
    var result = await db.query("empListTable", columns: columns);
    // the code below is used to create a list to check if the result is not empty
    // then getting the data from the database else returning empty list
    List<EmployeeListModel> empList = result.isNotEmpty
        ? result.map((item) => EmployeeListModel.fromJSON(item)).toList()
        : [];
    return empList;
  }

  // the code below is used to create a method to update the empList Table
  Future<int> updateEmpList(EmployeeListModel empList) async {
    // the code below is used to get access to the db getter
    final db = await dbClient.db;
    // the code below is used to update the empList table
    var result = await db.update("empListTable", empList.toJSON(),
        where: "id = ?", whereArgs: [empList.id]);
    return result;
  }

  //the method below is used to Delete empListTable records
  Future<int> deleteEmpList(int id) async {
    final db = await dbClient.db;
    var result =
        await db.delete("empListTable", where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
