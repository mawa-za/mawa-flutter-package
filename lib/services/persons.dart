part of 'package:mawa_package/mawa_package.dart';

class Persons {
  static late String personId;
  static late String personIdNumber;
  late String clientStatus;
  late bool status;
  static Map person = {};
  static Map group = {};
  static List people = [];
  static List personRoles = [];
  static dynamic personIdentities;
  static dynamic personContacts;
  List personDetail = [];

  Persons(String id) {
    personId = id;
  }

  static String personNameFromJson(json) {
    if (json != null) {
      try{
        String name =
            '${json[JsonResponses.personLastName] ?? ''}, ${json[JsonResponses.personFirstName] ?? ''} ${json[JsonResponses.personMiddleName] ?? ''}';
        return name == ',  ' ? '' : name;
      }catch(e){
        print(e);
        return 'Error Deciphering Name';
      }
    } else {
      return '';
    }
  }

  static Future personSearch(
      {String? idNumber,
      String? idType,
      String? lastName,
      String? middleName,
      String? firsName}) async {
    Persons.people.clear();
    dynamic peopleResponse = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
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
    people = await NetworkRequests.decodeJson(peopleResponse);
    return people;
  }

  validateSAID(id) async {
    Map<String, dynamic> response = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(await NetworkRequests.methodGet,
            resource: 'validateSAID?idnumber=$id'));
    response != null ? status = response['valid'] : null;
    return status;
  }

  getPerson() async {
    Persons.person.clear();
    dynamic respond = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.persons}/$personId');
    try {
      person = await NetworkRequests.decodeJson(respond, negativeResponse: {});
    } catch (e) {
      person = {};
    }
    return person;
  }

  static getOrganizations() async {
    return await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.organization),
        negativeResponse: []);
  }

  Future<dynamic> adaNewClient(clientDetails) async {
    return await NetworkRequests.decodeJson(await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodPost,
            resource: Resources.persons, body: clientDetails));
  }

  Future assignPersonRole({required String personRole}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.persons}/$personId/roles',
        queryParameters: {'role': personRole}));
  }

  addPersonDetail(
      {required String personID,
      required String path,
      required String field,
      required String detail}) async {
    await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.persons}/$personID/$path',
        body: {field: detail}));
  }

  getPersonDetail({
    required String option,
  }) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.persons}/${Persons.personId}/$option');
    response.statusCode == 200
        ? personDetail = await NetworkRequests.decodeJson(response)
        : personDetail = [];
    return personDetail;
  }

  //Add Identity
  addIdentity(
      {required String? path,
      required dynamic idType,
      required String? idNumber}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.persons}/$personId/$path',
        body: {
          JsonPayloads.idType: idType,
          JsonPayloads.personIdNumber: idNumber,
        });
    return response;
  }

  //add Contacts
  addContact(
      {required String? path,
      required String? contactType,
      required dynamic detail}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.persons}/$personId/$path',
        body: {
          JsonPayloads.type: contactType,
          JsonPayloads.cellNumber: detail,
        });
    return response;
  }

  //Add addresses
  addAdress(
      {required String? path,
      required String? addressType,
      required String? houseno,
      required String? streetName,
      required dynamic suburb,
      required dynamic city,
      required String? postalCode}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.persons}/$personId/$path',
        body: {
          JsonPayloads.type: addressType,
          JsonPayloads.addressline1: houseno,
          JsonPayloads.addressline2: streetName,
          JsonPayloads.addressline3: suburb,
          JsonPayloads.addressline4: city,
          JsonPayloads.postalCode: postalCode,
        });
    return response;
  }


  //NEW METHODS FOR THE NEW BACKEND

  static Future getPersonByIdNum(
      {String? idNumber}) async {
    Persons.people.clear();
    dynamic peopleResponse = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.persons,
        queryParameters: {
          'idnumber': idNumber,
          'filter': 'X'
        });

    // peopleResponse.runtimeType == people.runtimeType ? people = peopleResponse: people = [];
    people = await NetworkRequests.decodeJson(peopleResponse);
    return people;
  }

  static getPersonById(String id) async{
    await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.persons}/$id',
       )
    );
  }

  static getAll() async{
    return await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.persons,
       ),
      negativeResponse: [],
    );
  }


}
