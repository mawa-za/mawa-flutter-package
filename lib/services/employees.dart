part of 'package:mawa_package/mawa_package.dart';

class Employees {
  static const String employeesResource = 'employees';
  static List employees = [];
  static late String employeeId;
  // Employees(String id) {
  //   employeeId = id;
  // }

  static String personNameFromJson(json) {
    if (json != null) {
      return
        '${json[JsonResponses
            .personLastName] ?? ''}, ${json[JsonResponses
            .personFirstName] ?? ''} ${json[JsonResponses.personMiddleName] ??
            ''}';
    }
    else {
      return '';
    }
  }

  getAllEmployees() async {
    // List emps
    employees =
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$employeesResource'));
    Map<String, String> mapUsers = {};
    if (employees != null) {
      for (int i = 0; i < employees.length; i++) {
        employees[i][JsonResponses.usersFirstName] != null &&
            employees[i][JsonResponses.usersFirstName] != null
            ? mapUsers['${employees[i][JsonResponses.id]}'] =
        '${employees[i][JsonResponses.usersLastName] ??
            'Surname not Supplied'}, ${employees[i][JsonResponses
            .usersFirstName] ??
            'Name not Supplied'}' //'${listUsers[i][JsonKeys.usersLastName]}, ${listUsers[i][JsonKeys.usersFirstName]}'
            : mapUsers['${employees[i][JsonResponses.id]}'] =
        'No Name Provided';
      }
    }
    return employees;
  }

//Get All Employees
  getAllEmployee() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource:Resources.employees),
        negativeResponse: []);
  }

}
