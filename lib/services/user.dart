part of 'package:mawa_package/mawa_package.dart';

class User{
  static String? id;
  static String? partnerId;
  static String? groupId;
  static String userLoginRole = '';
  static Map<String,String> userRoles = {};
  static Map loggedInUser = {};
  static Map user = {};
  static List listUsers = [];
  static List assignees = [];

  static late List list = [];
  static late String username;
  static late String password;
  static late String email;
  static late dynamic pass;

  getUserDetails (String username, {bool getPerson = false}) async {
    loggedInUser.clear();
    try {
      dynamic response = await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.user}/$username')
      ;
      if(response.statusCode == 200 ) {
        print('\nj\n code ${response.statusCode}\nj\n');
        user.clear();
        print('clear');
        dynamic data = await NetworkRequests.decodeJson(response, negativeResponse: {});
        print('dara ${data.runtimeType}');
        user.addAll(data);
        print('\nj\n user ${user}\nj\n');
        // partnerId = user[JsonResponses.usersPartner];
        partnerId = user[JsonResponses.username];
        // Persons.personId = user[JsonResponses.usersPartner];
        print('\nj\n per id ${Persons.personId}\nj\n');
        // groupId = user[JsonResponses.usersPartner];
        print('\nj\n gr id ${groupId}\nj\n');
        // if(getPerson) {
        //   await Persons(Persons.personId).getPerson();
        // }
      }
    }
    catch(e){
      user.clear();
    }
    return user;
  }

  getAllUsers() async {
    User.user.clear();
    dynamic response =
    await NetworkRequests()
        .securedMawaAPI(NetworkRequests.methodGet, resource: Resources.user);

    Map<String, String> mapUsers = {};

    if(response.statusCode == 200){

      listUsers = await NetworkRequests.decodeJson(response, negativeResponse: []);
      // try{
      for (int i = 0; i < listUsers.length; i++) {
        listUsers[i][JsonResponses.usersFirstName] != null &&
            listUsers[i][JsonResponses.usersFirstName] != null
            ? mapUsers['${listUsers[i][JsonResponses.id]}'] =
        '${listUsers[i][JsonResponses.usersLastName] ??
            'Surname not Supplied'}, ${listUsers[i][JsonResponses
            .usersFirstName] ??
            'Name not Supplied'}' //'${listUsers[i][JsonKeys.usersLastName]}, ${listUsers[i][JsonKeys.usersFirstName]}'
            : mapUsers['${listUsers[i][JsonResponses.id]}'] =
        'No Name Provided';
      }
      // }
      // catch(e){
      //   mapUsers.clear();
      // }
    }
    else{
      mapUsers.clear();
    }
    return User.user = mapUsers;
    // print('opw\n$users\n name');
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
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: '${Resources.user}/$username/${Resources.reset}'));
  }

  getUserRoles() async {
    userRoles = {};
    // List
    list = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.user}/$username/role'));
    // if(sort) {
    //   if (list.isNotEmpty && list.runtimeType == Constants.list.runtimeType) {
    //     for (int i = 0; i < list.length; i++) {
    //       userRoles[list[i][JsonResponses.usersRolesDescription]] =
    //       list[i][JsonResponses.id
    //       ];
    //     }
    //   }
    //   return userRoles;
    // }
    // else{
    //   return list;
    // }
    return list;
  }

  addUser(
      {
        required String id,
        required String email,
        required String cellphone,
        required String partnerNum,
        required String role,
        required String userType,
      }) async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.user,
        body: {
          JsonPayloads.id : id,
          JsonPayloads.userType : userType,
          JsonPayloads.email : email,
          JsonPayloads.cellphone : cellphone,
          JsonPayloads.partnerID : partnerNum,
          JsonPayloads.role : role,
        });
    pass =  await NetworkRequests.decodeJson(response, negativeResponse: '');
    print('ttttttttttttttttt');
    print(pass);
    if(response.statusCode == 200 || response.statusCode == 201){
      dynamic p=  pass['password'];
      dynamic i = pass['id'];
      Notification(id: i).newUserNotification(
          meesageType: 'NEWUSER',
          user: true,
          password: p);
      print(p);
      print(i);
      print('USER CREATED');
    }
    return response;
  }

  getUsersByOrganisation() async {
    assignees = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.user + '/' + Resources.OrganizationUsers,
        queryParameters: {
          QueryParameters.organizationId:
          User.loggedInUser[JsonResponses.usersGroupId]
        }
    ),negativeResponse: []);

    return assignees;
  }

}