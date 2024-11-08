// the code below is used to create a class to write the business logic for our employee list project
import 'package:rxdart/rxdart.dart';
import 'package:employee_list/model/employee_list_model.dart';
import 'package:employee_list/resources/repository.dart';

class EmpListBloc{
  // the code below is used to create an instance of the repository class
  final Repository repository = Repository();

  // the code below is used to create an instance of the publish subject class
  final PublishSubject<List<EmployeeListModel>> _listFetcher = PublishSubject<List<EmployeeListModel>>();

  // the code below is used to create a getter for getting of type Stream<EmployeeListModel> for
  // getting the stream from PublishSubject()
  Stream<List<EmployeeListModel>> get allEmpList => _listFetcher.stream;

  // the code below is used to create an instance of the EmpListBloc
  EmpListBloc(){
    // the code below is used to call the getAllEmpLists method
    getAllEmpLists();
  }

  // the code below is used to create a method to get all the empList
  getAllEmpLists() async {
    List<EmployeeListModel> empList = await repository.getAllEmpLists();
    _listFetcher.sink.add(empList);
  }

  // the code below is used to create a method to add the empList
  addEmpList(EmployeeListModel empList) async {
    await repository.insertEmpLists(empList);
    getAllEmpLists();
  }

  // the code below is used to update the empList
  updateEmpList(EmployeeListModel empList) async {
    repository.updateEmpLists(empList);
    getAllEmpLists();
  }

  // the code below is used to delete the empList
  deleteEmpList(int id) async {
    repository.deleteEmpLists(id);
    getAllEmpLists();
  }

}

final empListBloc = EmpListBloc();
