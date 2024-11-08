class EmployeeListModel {
  // the property below is used to get the id of the task
  int? id;
  // property below is used for getting the employee name
  String? empName;
  // property below is used for getting the employee role
  String? empRole;
    // property below is used for getting the employee from date
String? empFromDate;
      // property below is used for getting the employee to date
String? empToDate;

  // property below is used to check that whether the task is done or not
  bool? done;

  // the code below is used to create a constructor for initialization
  EmployeeListModel({
    this.id,
    this.empName,
    this.empRole,
    this.empFromDate,
    this.empToDate,
    this.done = false,
  });

  // the code below is used to create a factory method for converting the json Data
  // to dart object
  factory EmployeeListModel.fromJSON(Map<String, dynamic> json) {
    return EmployeeListModel(
      id: json['id'],
      empName: json['empName'],
      empRole: json['empRole'],
      empFromDate: json['empFromDate'],
      empToDate: json['empToDate'],
      done: json['is_done'] == 0
          ? false
          : true, // since the sqlite does not have the boolean type
      // so we are using 0 to denote false and 1 to denote true
    );
  }

  // the code below is used to create a method for converting dart object to json to
  // be stored in the database
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'empName': empName,
      'empRole': empRole,
      'empFromDate': empFromDate,
      'empToDate': empToDate,
      'is_done': done == false
          ? 0
          : 1, // since the sqlite does not have the boolean type
      // so we are using 0 to denote false and 1 to denote true
    };
  }
}
