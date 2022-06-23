import 'package:mawa_package/services/keys.dart';
import 'package:mawa_package/services/network_requests.dart';

import 'notification.dart';

class Employees {

  static const String employeesResource = 'employees';

  static List  employees = [];
  String password = "";
  getAllEmployees() async{
    // List emps
    employees = await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$employeesResource/'));
    Map<String, String> mapUsers = {};
    if (employees != null) {
      for (int i = 0; i < employees.length; i++) {
        employees[i][JsonResponses.usersFirstName] != null &&
            employees[i][JsonResponses.usersFirstName] != null
            ? mapUsers['${employees[i][JsonResponses.id]}'] =
                '${employees[i][JsonResponses.usersLastName] ?? 'Surname not Supplied'}, ${employees[i][JsonResponses.usersFirstName] ?? 'Name not Supplied'}' //'${listUsers[i][JsonKeys.usersLastName]}, ${listUsers[i][JsonKeys.usersFirstName]}'
            : mapUsers['${employees[i][JsonResponses.id]}'] = 'No Name Provided';
      }
  }
   return employees;
   //= emps;



    return employees;
  }

  getEmployee(String employeeId) async {
    return NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '$employeesResource/$employeeId'));
  }




}
// part of mawa;
//
// class Employees {
//
//   static const String employeesResource = 'employees';
//   late List employees;
//   getAllEmployees() async{
//     List emps = await NetworkRequests().securedMawaAPI(
//         NetworkRequests.methodGet,
//         resource: '$employeesResource/');
//     Map<String, String> mapUsers = {};
//     if (emps != null) {
//       for (int i = 0; i < emps.length; i++) {
//         emps[i][JsonResponses.usersFirstName] != null &&
//                 emps[i][JsonResponses.usersFirstName] != null
//             ? mapUsers['${emps[i][JsonResponses.id]}'] =
//                 '${emps[i][JsonResponses.usersLastName] ?? 'Surname not Supplied'}, ${emps[i][JsonResponses.usersFirstName] ?? 'Name not Supplied'}' //'${listUsers[i][JsonKeys.usersLastName]}, ${listUsers[i][JsonKeys.usersFirstName]}'
//             : mapUsers['${emps[i][JsonResponses.id]}'] = 'No Name Provided';
//       }
//     }
//     employees = emps;
//   }
//
//   getEmployee(String employeeId) async {
//     return NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
//         resource: '$employeesResource/$employeeId');
//   }
// }
