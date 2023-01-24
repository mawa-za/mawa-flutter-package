part of 'package:mawa_package/mawa_package.dart';

//Class start here
class Customers {
  static List customer = [];
  static Map customerDetails = {};
  static List fieldsOptions = [];
  static Map validateIdentity = {};
  static List memberships = [];
  static List vouchers = [];
  static List partnerRoles = [];
  static List identities = [];
  static List attachments = [];
  static List contacts = [];
  static List addresses = [];

  //Get All customers method
  getAllCustomers() async {
    customer = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.customers),
        negativeResponse: []);

    return customer;
  }

  //Get specific customer

  getSpecificCustomerDetails(String customerId) async {
    customerDetails = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.persons}/$customerId',
        ),
        negativeResponse: {});

    return customerDetails;
  }

  //Get Membership
  getMemberShip(String idNumber, String partnerRole) async {
    memberships = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.policies,
          queryParameters: {
            QueryParameters.personIdNumber: idNumber,
            QueryParameters.partnerRole: partnerRole
          },
        ),
        negativeResponse: []);

    return memberships;
  }

  getVoucher(String partnerId) async {
    vouchers = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: Resources.voucherValue,
          queryParameters: {
            QueryParameters.filter: QueryParameters.filterValue,
            QueryParameters.assignedToID: partnerId
          },
        ),
        negativeResponse: []);

    return vouchers;
  }

  //Get partner role
  getPartnerRole(String partnerId) async {
    partnerRoles = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.persons}/$partnerId/${Resources.roles}',
        ),
        negativeResponse: []);

    return partnerRoles;
  }

  //Get Attachments
  getAttachments(String partnerId, String parentTypValue) async {
    attachments = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
            resource: Resources.attachments,
            queryParameters: {
              QueryParameters.parentReference: partnerId,
              QueryParameters.parentType: parentTypValue
            }),
        negativeResponse: []);

    return attachments;
  }

  //Get Attachments
  getIdentity(String partnerId) async {
    identities = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.persons}/$partnerId/${Resources.identity}',
        ),
        negativeResponse: []);

    return identities;
  }

  //Get Contacts
  getContacts(String partnerId) async {
    contacts = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.persons}/$partnerId/${Resources.contactValue}',
        ),
        negativeResponse: []);

    return contacts;
  }

  //Get Addresses
  getAddress(String partnerId) async {
    addresses = await NetworkRequests.decodeJson(
        await NetworkRequests().securedMawaAPI(
          NetworkRequests.methodGet,
          resource: '${Resources.persons}/$partnerId/${Resources.addresses}',
        ),
        negativeResponse: []);

    return addresses;
  }

  //Validate Identity
  validateID(String idNumber, String idType) async {
    if (idType == 'SAID') {
      validateIdentity = await NetworkRequests.decodeJson(
          await NetworkRequests().securedMawaAPI(NetworkRequests.methodGet,
              resource: Resources.validateSAID,
              queryParameters: {
                QueryParameters.personIdNumber: idNumber,
              }),
          negativeResponse: {});

      return validateIdentity;
    } else {
      print('Passport');
    }
  }

  //Create customer
  static createCustomer(
      {required String? firstName,
      String? middleName,
      required String? lastName,
      required dynamic gender,
      required dynamic title,
      required dynamic maritalStatus,
      required dynamic birthdate,
      String? postalCode}) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.persons,
        body: {
          JsonPayloads.firstName: firstName,
          JsonPayloads.middleName: middleName,
          JsonPayloads.lastName: lastName,
          JsonPayloads.gender: gender,
          JsonPayloads.title: title,
          JsonPayloads.maritalStatus: maritalStatus,
          JsonPayloads.birthDate: birthdate
        });
    return response;
  }

  // assignRole({required String? role, required String? partnerId}) async {
  //   dynamic response = await NetworkRequests().securedMawaAPI(
  //       NetworkRequests.methodPost,
  //       resource: '${Resources.persons}/$partnerId/${Resources.roles}',
  //       queryParameters: {
  //         QueryParameters.role: role,
  //       },
  //       body: {
  //         JsonPayloads.role: role,
  //       });
  // }
}
