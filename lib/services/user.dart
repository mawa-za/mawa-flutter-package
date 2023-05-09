part of 'package:mawa_package/mawa_package.dart';

class User{
  User(this._username);
  final String _username;
  static String? partnerId;
  static String? groupId;
  static String userLoginRole = '';
  static Map<String,String> userRoles = {};
  static Map loggedInUser = {};
  static Map user = {};
  static List listUsers = [];
  static List assignees = [];

  static late String username;
  static late String password;
  static late String email;
  static late dynamic pass;

  get ({bool getPerson = false}) async {
      user = await NetworkRequests.decodeJson( await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.user}/$_username'), negativeResponse: {},
      );
    return user;
  }

  static getAll() async {
    listUsers = await NetworkRequests.decodeJson(await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet, resource: Resources.user), negativeResponse: []);
    return listUsers;
  }

  static mapAll() async{
    await User.getAll();
    Map<String, String> mapUsers = {};
      for (int i = 0; i < listUsers.length; i++) {
        listUsers[i][JsonResponses.usersFirstName] != null &&
            listUsers[i][JsonResponses.usersFirstName] != null
            ? mapUsers['${listUsers[i][JsonResponses.id]}'] =
        Strings.personNameFromJson(listUsers[i])
            : mapUsers['${listUsers[i][JsonResponses.id]}'] =
        'No Name Provided';
      }
    return mapUsers;
  }

  forgotPassword({required String emailAddress}) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    Map json = {JsonPayloads.email: emailAddress};
    http.Response response = await http.post(
        Uri.http(NetworkRequests().endpointURL,
            NetworkRequests.path + Resources.forgotPassword),
        headers: headers,
        body: jsonEncode(json));
    NetworkRequests.statusCode = response.statusCode;

    if (response.statusCode == 200 || response.statusCode == 201) {
      NetworkRequests.token = jsonDecode(response.body);
    }
    else if (response.statusCode == 417) {
      return jsonDecode(response.body);
    }
  }

  static changePassword({required String password}) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
        resource: Resources.resetPassword, body: {JsonPayloads.password: password});
  }

  resetPassword() async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.user}/$_username/${Resources.reset}'));
  }

  getRoles() async {
    return  await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.user}/$_username/${Resources.role}'), negativeResponse: []);
  }

  addRoles({required List<String> roles}) async {
    return  await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '${Resources.user}/$_username/${Resources.role}',
    body: roles);
  }

  static create(
      {
        required String username,
        required String email,
        required String cellphone,
        required String password,
        required String userType,
      }) async{
    return await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.user,
        body: {
          JsonPayloads.username : username,
          JsonPayloads.userType : userType,
          JsonPayloads.email : email,
          JsonPayloads.cellphone : cellphone,
          JsonPayloads.password : password,
        });
  }

  static getUsersByOrganisation() async {
    assignees = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.user}/${Resources.OrganizationUsers}',
        queryParameters: {
          QueryParameters.organizationId:
          User.loggedInUser[JsonResponses.usersGroupId]
        }
    ),negativeResponse: []);

    return assignees;
  }

  static Future<bool> isLoggedIn() async{
    final SharedPreferences prefs = await preferences;
    return prefs.getBool(SharedPrefs.isLoggedIn) ?? false;
  }

  static Future<String?> getLoggedInUsername() async{
    final SharedPreferences prefs = await preferences;
    return prefs.getString(SharedPrefs.username);
  }

  static void setLoggedIn({required bool loggedIn}) async{
    final SharedPreferences prefs = await preferences;
    prefs.setBool(SharedPrefs.isLoggedIn, loggedIn);
  }
}