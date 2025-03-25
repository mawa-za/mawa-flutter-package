part of 'package:mawa_package/mawa_package.dart';

class ResetPassword {
  static setNewPassword({
    required String token,
    required String newPassword,
  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.setNewPassword,
        body: {
          JsonPayloads.token:token ,
          JsonPayloads.newPassword: newPassword,

        });
  }
  static passUserName({
    required String user,
  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
      resource: Resources.forgotPasswordSelf,
      queryParameters: {
        QueryParameters.user: user,
      },
    );
  }

}
