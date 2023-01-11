
part of 'package:mawa_package/mawa_package.dart';

//Class start here
class Customers {
  static List customer = [];
  static List customerDetails = [];
  static List memberships =[];
  static List vouchers =[];
  static List partnerRoles =[];
  static List identities = [];
  static List attachments =[];
  static List contacts =[];
  static List addressess =[];



  //Get All customers method
  getAllCustomers() async {
  customer = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.customers),
      negativeResponse: []);

      return customer;
  }

  //Get specific customer

  getSpecificCustomerDetails(String customerId) async {
    customerDetails = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.persons}/$customerId',
        ),

        negativeResponse: []);

    return customerDetails;
  }
  //Get Membership
  getMemberShip(String idNumber,String partnerRole) async {
    memberships = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.policies,
        queryParameters: {
          QueryParameters.personIdNumber:idNumber,
          QueryParameters.partnerRole:partnerRole
        },
    ),

        negativeResponse: []);

    return memberships;
  }

  getVoucher(String partnerId) async {
    vouchers = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.voucherValue,
      queryParameters: {
        QueryParameters.filter:QueryParameters.filterValue,
        QueryParameters.assignedToID:partnerId
      },
    ),

        negativeResponse: []);

    return vouchers;
  }
  //Get partner role
  getPartnerRole(String partnerId) async {
    partnerRoles = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: '${Resources.persons}/$partnerId/${Resources.roles}',
    ),

        negativeResponse: []);

    return partnerRoles;
  }
  //Get Attachments
  getAttachments(String partnerId, String parentTypValue) async {
    attachments = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.attachments,
        queryParameters: {
          QueryParameters.parentReference:partnerId,
          QueryParameters.parentType:parentTypValue
        }
    ),

        negativeResponse: []);

    return attachments;
  }
  //Get Attachments
  getIdentity(String partnerId) async {
    identities = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.persons}/$partnerId/${Resources.identity}',
    ),

        negativeResponse: []);

    return identities;
  }

  //Get Contacts
  getContacts(String partnerId) async {
    contacts = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: '${Resources.persons}/$partnerId/${Resources.contactValue}',
    ),

        negativeResponse: []);

    return contacts;
  }

  //Get Addresses
  getAddress(String partnerId) async {
    addressess = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: '${Resources.persons}/$partnerId/${Resources.addresses}',
    ),

        negativeResponse: []);

    return addressess;
  }
  // Get

  // getMembership() async {
  //   customerDetails = await NetworkRequests.decodeJson(await NetworkRequests().securedMawaAPI(
  //       // NetworkRequests.methodGet,
  //       // resource: '${Resources.customers}/'),
  //       // queryParameters: {
  //       //   QueryParameters.filter,
  //       // },
  //       // negativeResponse: []);
  //
  //   //return customerDetails;
  // }

}