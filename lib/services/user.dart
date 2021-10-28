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

  // requestAuthentication(context) async {
  //     FocusScope.of(context).unfocus();
  //     Alerts.flushbar.show(context);
  //     message(message: 'Please Wait' , textColor: Colors.blue, isLock: true);
  //
  //     User.userID = username;
  //     User.password = password;
  //     await NetworkRequests().authenticateUser(
  //         resource: NetworkRequests.authenticateResource,
  //         payload: {"userID": "${User.userID}", "password": "${User.password}"});
  //     switch (NetworkRequests.statusCode) {
  //       case 200:
  //         {
  //           List roles = User.userRoles.values.toList();
  //           // List workCenters = [];
  //           // for (int index = 0; index <roles.length; index++) {
  //           //   await WorkCenters().getWorkCenters(role: roles[index]);
  //           //   workCenters.addAll(WorkCenters.workCentersList);
  //           // }
  //           // if(workCenters.contains('CASHUP')){
  //           if(roles.contains('CASHIER') || roles.contains('SYSTEMADMINISTRATOR')){
  //
  //             message(message: '' , textColor: Colors.blue, isLock: false);
  //             if(MawaPrinter.printerType == null){
  //               PrinterTypeSelection(context: context).build();
  //               // setState((){});
  //             }
  //             Navigator.pushReplacementNamed(context, SearchScreen.id);
  //
  //             location = Location();
  //             device = DeviceInfo();
  //             User().getUserDetails(User.userID!);
  //             Employees().getAllEmployees();
  //           }
  //           else {
  //             message(message: 'No Access' , textColor: Colors.redAccent, isLock: false);
  //             Alerts().openPopup(context,
  //                 title: 'Oops! ',
  //                 message:
  //                 'It Seems You Do Not Have Privileges To Use This App  ');
  //           }
  //         }
  //         break;
  //       case 401:
  //         {
  //           message(message: 'Incorrect login' , textColor: Colors.redAccent, isLock: false);
  //           Alerts.flushbar(context: SharedResources.context!, message: 'Incorrect login',positive: false, popContext: true);
  //         }
  //         break;
  //       case 404:
  //         {
  //           message(message: 'Server Is Down', textColor: Colors.redAccent, isLock: false);
  //         }
  //         break;
  //       case 0:
  //         {
  //           message(message: 'Network Error', textColor: Colors.redAccent, isLock: false);
  //         }
  //         break;
  //       case 1:
  //         {
  //           message(message: 'Network Error', textColor: Colors.redAccent, isLock: false);
  //         }
  //         break;
  //       default:
  //         {
  //           message(message: 'Login failed', textColor: Colors.redAccent, isLock: false);
  //           Alerts.flushbar(context: SharedResources.context!, message: 'Not Connected To Any Network',positive: false);
  //         }
  //         break;
  //     }
  // }

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