part of mawa;

class Persons {
  static late String personId;
  static late String personIdNumber;
  late String  clientStatus;
  late bool status;
  static Map person = {};
  static List people = [];
  static List personRoles = [];
  static dynamic personIdentities;
  static dynamic personContacts;
  static dynamic personAddresses;

  static Future personSearch({required String id, required String idType,}) async {
    String resource =
        '${Resources.persons}/?idnumber=$id&idtype=$idType&filter=x';
    return await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet, resource: resource);
  }

  validateSAID(id) async {
    Map<String, dynamic> response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: 'validateSAID?idnumber=$id');
    response != null ? status = response['valid'] : null;
    return status;
  }

  static getPerson(String personId) async {
    print('person $personId');
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.persons}/$personId');
  }

  Future<dynamic> adaNewClient(clientDetails) async {
    return NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.persons, body: clientDetails);
  }

  static Future assignPersonRole({required String personID, required String personRole}) async{
    await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.persons}/$personID/roles?role=$personRole');
  }

  addPersonDetail({required String personID, required String path, required String field, required String detail}) async{
    NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.persons}/$personID/$path', body: {field: detail});
  }

  getPersonDetail({required String option,}) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: '${Resources.persons}/${Persons.personId}/$option');
  }
}