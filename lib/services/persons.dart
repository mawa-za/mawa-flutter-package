import 'package:mawa_package/services/keys.dart';
import 'package:mawa_package/services/network_requests.dart';

class Persons {
  static late String personId;
  static late String personIdNumber;
  late String  clientStatus;
  late bool status;
  static Map person = {};
  static Map group = {};
  static List people = [];
  static List personRoles = [];
  static dynamic personIdentities;
  static dynamic personContacts;
  List personDetail = [];

  Persons(String id){
    personId = id;
  }

  static String personNameFromJson(json){
    return
      '${json[JsonResponses
          .personLastName] ?? ''}, ${json[JsonResponses
          .personFirstName] ?? ''} ${json[JsonResponses.personMiddleName] ?? ''}';
  }
  static Future personSearch({String? idNumber, String? idType, String? lastName, String? middleName, String? firsName}) async {
    Persons.people.clear();
    dynamic peopleResponse = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.persons,
        queryParameters: {
          'idnumber': idNumber,
          'idtype': idType,
          'firstName': firsName,
          'middleName': middleName,
          'lastName': lastName,
          'filter': 'x'
        });


    // peopleResponse.runtimeType == people.runtimeType ? people = peopleResponse: people = [];
    people =  await NetworkRequests.decodeJson(peopleResponse);
    return people;
  }

  validateSAID(id) async {
    Map<String, dynamic> response = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        await  NetworkRequests.methodGet,
        resource: 'validateSAID?idnumber=$id'));
    response != null ? status = response['valid'] : null;
    return status;
  }

  getPerson() async {
    Persons.person.clear();
    dynamic respond = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.persons}/$personId');
    try{
      person = await NetworkRequests.decodeJson(respond, negativeResponse: {});

    }
    catch (e){
      person = {};
    }
    return person;
  }

  Future<dynamic> adaNewClient(clientDetails) async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.persons, body: clientDetails));
  }

  Future assignPersonRole({required String personRole}) async{
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.persons}/$personId/roles',
        queryParameters: {'role': personRole}));
  }

  addPersonDetail({required String personID, required String path, required String field, required String detail}) async{
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.persons}/$personID/$path', body: {field: detail}));
  }

  getPersonDetail({required String option,}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.persons}/${Persons.personId}/$option');
    response.statusCode == 200 ? personDetail =  await NetworkRequests.decodeJson(response): personDetail = [];
  return personDetail;
  }
}