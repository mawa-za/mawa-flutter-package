part of 'package:mawa_package/mawa_package.dart';

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
static deleteAccount({required String id}) async {
  await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodDelete,
      resource: '${Resources.bankAccount}/$id'));
}

static edit(
    { required dynamic id,
      String? accHolderName,
      String? bankName,
      String? accType,
      String? accNumber,
      String? branchCode,
      String? validFrom,
      String? validTo
    }) async {
  return await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '${Resources.bankAccount}/$id',
      body: {
        JsonResponses.id:id,
        JsonPayloads.accountHolder: accHolderName,
        JsonPayloads.bankName: bankName,
        JsonPayloads.accountType: accType,
        JsonPayloads.accountNumber: accNumber,
        JsonPayloads.branchCode: branchCode,
        JsonPayloads.validFrom: validFrom,
        JsonPayloads.validTo: validTo
      });

}


}
