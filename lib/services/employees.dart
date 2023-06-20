part of 'package:mawa_package/mawa_package.dart';

class Employees {

  static const String employeesResource = 'employees';

  static List  employees = [];
  String password = "";
  static late String personId;
  static late String personIdNumber;
  late String  clientStatus;
  late bool status;
  static Map person = {};
  static Map employee = {};
  static Map group = {};
  static List people = [];
  static List personRoles = [];
  static dynamic personIdentities;
  static dynamic personContacts;
  static String? employeeID;
  List personDetail = [];
  Persons(String id){
    personId = id;
  }

  static String personNameFromJson(json){
    if(json != null){
      return
        '${json[JsonResponses
            .personLastName] ?? ''}, ${json[JsonResponses
            .personFirstName] ?? ''} ${json[JsonResponses.personMiddleName] ??
            ''}';
    }
    else{
      return '';
    }
  }
  getAllEmployees() async{
    // List emps
    employees = await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$employeesResource'));
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


  getAllEmployee() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: '${Resources.employees}'),
        negativeResponse: []);
  }
  getEmployee(String employeeId) async {
    employee = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: '${Resources.persons}/$employeeId',
    ),

        negativeResponse: {});

    return employee;
  }

  // getEmployee(String employeeId) async {
  //   return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
  //       resource: '${Resources.persons}/$employeeId'));
  // }

  getEmployeeRoles(String partnerNumber) async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.persons}/$partnerNumber/${Resources.roles}'));

  }

  getEmployeeIdentities(String partnerNumber) async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.persons}/$partnerNumber/${Resources.identities}'));
  }

  getEmployeeContacts(String partnerNumber) async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.persons}/$partnerNumber/${Resources.contacts}'));
  }
  getEmployeeAddresses(String partnerNumber) async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.persons}/$partnerNumber/${Resources.addresses}'));
  }
  getEmployeeDetails(String partnerNumber) async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.partner}/$partnerNumber'));
    // /${Resources.employeeId}'
  }
  getEmployeeLeaveProfile(String partnerFunction,String partnerNo) async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.leaveProfiles,
    queryParameters: {
      QueryParameters.partnerNo:partnerNo,
      QueryParameters.partnerFunction:partnerFunction,
    }));

  }

  // editEmployeeDetails(String partnerNumber) async {
  //   return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
  //       resource: '${Resources.persons}/$partnerNumber'));
  // }
  getEmployeeEmploymentDetails(String partnerNumber) async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.employment}/$partnerNumber'));
  }
  addEmployeeRole(String partnerNumber,String role) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.persons}/$partnerNumber/${Resources.roles}',
      queryParameters: {
      QueryParameters.role: role,
      }
    );

  }
  addEmployeeContacts(String partnerNumber, String type, String detail) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.persons}/$partnerNumber/${Resources.contacts}',
        body: {
          JsonPayloads.type: type,
          JsonPayloads.detail: detail,
        }
    );

  }

  addEmployeeIdentity(String partnerNumber, String idType, String idNumber) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.persons}/$partnerNumber/${Resources.identities}',
        body: {
          JsonPayloads.idType: idType,
          JsonPayloads.idNumber: idNumber,
        }
    );

  }

  // addEmployeeAddress(String partnerNumber, String addressline1, String addressline2, String addressline3, String addressline4, String postalCode) async {
  //   return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
  //       resource: '${Resources.persons}/$partnerNumber/${Resources.addresses}',
  //       body: {
  //         JsonPayloads.addressline1: addressline1,
  //         JsonPayloads.addressline2: addressline2,
  //         JsonPayloads.addressline3: addressline3,
  //         JsonPayloads.addressline4: addressline4,
  //         JsonPayloads.postalCode: postalCode,
  //       }
  //   );
  //
  // }


  static createEmployee(
      {required String? firstName,
        String? middleName,
        required String? lastName,
        required dynamic gender,
        required dynamic title,
        required dynamic maritalStatus,
        required dynamic birthdate,
        String? postalCode}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.persons,
        body: {
          JsonPayloads.firstName: firstName,
          JsonPayloads.middleName: middleName,
          JsonPayloads.lastName: lastName,
          JsonPayloads.gender: gender,
          JsonPayloads.title: title,
          JsonPayloads.maritalStatus: maritalStatus,
          JsonPayloads.birthDate: birthdate
        });
    return response;
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
