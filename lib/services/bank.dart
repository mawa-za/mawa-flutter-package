
import '../mawa_package.dart';

class Banks {
dynamic finaleResponse={};
  static getBankAccount({required String transactionId}) async {

    dynamic bankAccountObj = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.bankAccount,
        queryParameters: {
          'objectId': transactionId,
        });

    return  await NetworkRequests.decodeJson(bankAccountObj);
  }
  static addBankAccount({
    required String objectId,
    required String accountHolder,
    required String bankName,
    required String accountNumber,
    required String branchCode,
    required String accountType,

  }) async {
    return await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource: Resources.bankAccount,
        body: {
          JsonPayloads.objectId: objectId,
          JsonPayloads.accountHolder: accountHolder,
          JsonPayloads.bankName: bankName,
          JsonPayloads.accountNumber: accountNumber,
          JsonPayloads.branchCode: branchCode,
          JsonPayloads.accountType: accountType,

        });
  }


}
