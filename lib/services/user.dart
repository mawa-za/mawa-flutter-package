part of mawa;

class User{
  static String? id;
  static String? partnerId;
  static String? groupId;
  static String userLoginRole = '';
  static Map<String,String> userRoles = {};
  static Map loggedInUser = {};
  static Map<String, String> users = {};

  static late String username;
  static late String password;
  static late String email;

  getUserDetails (String username) async {
    loggedInUser.clear();
    try {
      loggedInUser =
      // Map<dynamic, dynamic>.from(
      await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.users}/$username')
      // )
          ;
      partnerId = loggedInUser[JsonResponses.usersPartner];
      Persons.personId = loggedInUser[JsonResponses.usersPartner];
      groupId =  loggedInUser[JsonResponses.usersPartner];

    }
    catch(e){
      loggedInUser.clear();
    }
  }

  forgotPassword({required String emailAddress}) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    Map json = {"email": emailAddress};
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

  changePassword({required String password}) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
        resource: Resources.resetPassword, body: {"password": password});
  }

  resetPassword({required String username}) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.users}/$username/reset');
  }

  getUserRoles() async {
    userRoles = {};
    List list = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.users}/$username/roles');
    if(list.isNotEmpty && list.runtimeType == Constants.list.runtimeType){
      for (int i = 0; i < list.length; i++) {
        userRoles[list[i][JsonResponses.usersRolesDescription]] =
        list[i][JsonResponses.usersRolesId];
      }
    }
  }
}