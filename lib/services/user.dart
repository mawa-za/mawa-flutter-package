part of 'package:mawa_package/mawa_package.dart';

class User {
  User(this.id) {
    resource = '${Resources.user}/$id';
  }
  final String id;
  static String? partnerId;
  static String? groupId;
  static String userLoginRole = '';
  static Map<String, String> userRoles = {};
  static Map loggedInUser = {};
  static Map user = {};
  static List listUsers = [];
  static List assignees = [];

  static late String username;
  static late String password;
  static late String email;
  static late dynamic pass;

  late String resource;

  // GET /user/{id}
  get() async {
    user = await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.user}/$id',
      ),
      negativeResponse: {},
    );
    return user;
  }

  // GET /user/{username}/username
  static getByUsername(String username) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.user}/${Resources.username}/$username',
      ),
      negativeResponse: {},
    );
  }

  // GET /user/email/{email}
  static getByEmail(String email) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.user}/$email/${Resources.email}',
      ),
      negativeResponse: {},
    );
  }

  // GET /user/cellphone/{cellphone}
  static getByCellphone(String cellphone) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.user}/$cellphone/${Resources.cellphone}',
      ),
      negativeResponse: {},
    );
  }

  // GET /user
  static getAll() async {
    listUsers = await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.user,
      ),
      negativeResponse: [],
    );
    return listUsers;
  }

  // GET /user
  static mapAll() async {
    await User.getAll();
    Map<String, String> mapUsers = {};
    for (int i = 0; i < listUsers.length; i++) {
      listUsers[i][JsonResponses.usersFirstName] != null &&
              listUsers[i][JsonResponses.usersFirstName] != null
          ? mapUsers['${listUsers[i][JsonResponses.id]}'] =
              Strings.personNameFromJson(listUsers[i])
          : mapUsers['${listUsers[i][JsonResponses.id]}'] = 'No Name Provided';
    }
    return mapUsers;
  }

  // GET /user
  //  {
  //   "email": "string",
  //   "cellphone": "string",
  //   "partnerId": "string",
  //   "passwordStatus": "string",
  //   "status": "string",
  //   "userType": "string"
  // }
  static search({
    String? email,
    String? cellphone,
    String? partnerID,
    String? passwordSatus,
    String? status,
    String? userType,
  }) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.user,
        queryParameters: {
          QueryParameters.email: email,
          QueryParameters.cellphone: cellphone,
          QueryParameters.partnerId: partnerID,
          QueryParameters.passwordStatus: password,
          QueryParameters.status: status,
          QueryParameters.userType: userType
        },
      ),
      negativeResponse: [],
    );
  }

  // DELETE /user/{id}
  delete() async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: resource,
    );
  }

  // PUT /user/{id}/{path}
  action(String path, {Map<String, dynamic>? query}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '$resource/$path',
      queryParameters: query,
    );
  }

  // PUT /user/{id}/lock
  lock(String reason) async {
    return await action(
      Resources.lock,
      query: {
        JsonPayloads.reason: reason,
      },
    );
  }

  // PUT /user/{id}/unlock
  unlock() async {
    return await action(Resources.unlock);
  }

  // PUT /user/{id}/reset
  reset() async {
    return await action(Resources.reset);
  }

  // PUT /user/{username}
  // {
  //   "cellphone": "string",
  //   "email": "string",
  //   "password": "string",
  //   "userType": "string"
  // }
  set({
    String? cellphone,
    String? email,
    String? password,
    String? userType,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: resource,
      body: {
        JsonPayloads.cellphone: cellphone,
        JsonPayloads.email: email,
        JsonPayloads.password: password,
        JsonPayloads.userType: userType,
      },
    );
  }

  // DELETE /user/{id}/role
  deleteRole(String userRole) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: '$resource/${Resources.role}',
      queryParameters: {
        QueryParameters.userRole: userRole,
      },
    );
  }

  forgotPassword({required String emailAddress}) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    Map json = {JsonPayloads.email: emailAddress};
    http.Response response = await http.post(
        Uri.http(NetworkRequests().endpointURL,
            NetworkRequests.path + Resources.forgotPassword),
        headers: headers,
        body: jsonEncode(json));

    if (response.statusCode == 200 || response.statusCode == 201) {
      NetworkRequests.token = jsonDecode(response.body);
    } else if (response.statusCode == 417) {
      return jsonDecode(response.body);
    }
  }

  static changePassword({required String password}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: Resources.resetPassword,
      body: {
        JsonPayloads.password: password,
      },
    );
  }

  resetPassword() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: '$resource/${Resources.reset}',
      ),
    );
  }

  getRoles() async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '$resource/${Resources.role}',
      ),
      negativeResponse: [],
    );
  }

  addRoles({required List<String> roles}) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: '$resource/${Resources.role}',
      body: roles,
    );
  }

  static create({
    required String username,
    required String email,
    required String cellphone,
    required String password,
    required String userType,
    required String partnerId,
  }) async {
    return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.user,
      body: {
        JsonPayloads.username: username,
        JsonPayloads.userType: userType,
        JsonPayloads.email: email,
        JsonPayloads.cellphone: cellphone,
        JsonPayloads.password: password,
        JsonPayloads.partnerId: partnerId,
      },
    );
  }

  static getUsersByOrganisation(String organizationId) async {
    return await NetworkRequests.decodeJson(
      await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.user}/${Resources.OrganizationUsers}',
        queryParameters: {
          QueryParameters.organizationId: organizationId,
        },
      ),
      negativeResponse: [],
    );
  }

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await preferences;
    return prefs.getBool(SharedPrefs.isLoggedIn) ?? false;
  }

  static void setLoggedIn({required bool loggedIn}) async {
    final SharedPreferences prefs = await preferences;
    prefs.setBool(
      SharedPrefs.isLoggedIn,
      loggedIn,
    );
  }
}
