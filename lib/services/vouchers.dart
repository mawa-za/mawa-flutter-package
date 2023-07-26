part of 'package:mawa_package/mawa_package.dart';

class Vouchers{

  dynamic  voucherId;


  Vouchers({required this.voucherId});
  getVouchers(String claimNo) async {
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.vouchers,
        queryParameters: {
          QueryParameters.filter: QueryParameters.filterValue,
          QueryParameters.transactionLink: claimNo
        }

    ), negativeResponse: []);
  }
  getAllVouchers() async{
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
        resource: Resources.voucher,
        // queryParameters: {
        //   // QueryParameters.status: status,
        //   QueryParameters.customerId: customerId,
        //   // QueryParameters.number: number,
        //   // QueryParameters.expiryDate: expiryDate,
        //   // QueryParameters.IdNumber: IdNumber,
        //
        // }

    ), negativeResponse: []);
  }

  getVouchersByCustomerId({ required dynamic customerId}) async{
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
      resource: Resources.voucher,
      queryParameters: {
        QueryParameters.customerId: customerId,
      }

    ), negativeResponse: []);
  }


  getVouchersById() async{
     dynamic data= await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
      resource: '${Resources.voucher}/$voucherId',
    ), negativeResponse: []);
     dynamic responseData = await json.decode(data.body);
     return responseData;
  }


  static createVoucher(
      {
        required dynamic amount,
        required String customerId,
        required String expiryDate,
        required dynamic type,

      }) async {
    dynamic response= await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.voucher,
        body :{
              JsonPayloads.amount:amount,
               JsonPayloads.customerId:customerId,
               JsonPayloads.expiryDate:expiryDate,
               JsonPayloads.type:type,
        }
    );
    return response;
  }


  editVoucher(
      {
        required dynamic body

      }) async {
    dynamic response= await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource:'${Resources.voucher}/$voucherId',
        body :body
    );
    return response;
  }

  deleteVoucher() async{
    return await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodDelete,
        resource: '${Resources.voucher}$voucherId',
      ),
        negativeResponse: ''
    );
  }


}