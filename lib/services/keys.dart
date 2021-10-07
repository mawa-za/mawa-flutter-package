part of mawa;

class JsonResponseKeys{
  static const String token = 'token';
  static const String userID = 'userID';

  static const String ticketId = 'id';
  static const String ticketStatus = 'status';
  static const String ticketPriority = 'priority';
  static const String ticketDateLogged = 'dateLogged';
  static const String ticketDueDate = 'dueDate';
  static const String ticketCategory = 'category';
  static const String ticketDescription = 'description';
  static const String ticketAssignedToID = 'assignedToID';
  static const String ticketAssignedTo = 'assignedTo';
  static const String ticketAssignedByID = 'assignedByID';
  static const String ticketAssignedBy = 'assignedBy';
  static const String ticketClientId = 'clientId';

  static const String fieldOptionCode = 'code';
  static const String fieldOptionDescription = 'description';
  static const String fieldOptionValidFrom = 'validFrom';
  static const String fieldOptionValidTo = 'validTo';

  // static const String = '';

  static const String usersId = 'id';
  static const String usersFirstName = 'firstName';
  static const String usersLastName = 'lastName';
  static const String usersPasswordStatus = 'password_status';
  static const String usersPartner = 'partner';
  static const String usersCellphone = 'cellphone';
  static const String usersEmail = 'email';
  static const String usersStatus = 'status';
  static const String usersGroupId = 'groupID';
  static const String usersGroupName = 'groupName';

  static const String usersRolesId = 'id';
  static const String usersRolesDescription = 'description';



  static const String personId = 'id';
  static const String personIdType = 'idType';
  static const String personIdNumber = 'idnumber';
  static const String personLastName = 'lastName';
  static const String personMiddleName = 'middleName';
  static const String personFirstName = 'firstName';
  static const String personGender = 'gender';
  static const String personBirthDate = 'birthDate';
  static const String personLanguage = 'language';
  static const String personMaritalStatus = 'maritalStatus';
  static const String personTitle = 'title';
  static const String personStatus = 'status';

  static const String ticketLogID = 'ticketLogID';
  static const String ticketLogTicketID = 'ticketID';
  static const String ticketLogPartnerId = 'partnerID';
  static const String ticketLogPartner = 'partner';
  static const String ticketLogStartTime = 'startTime';
  static const String ticketLogEndTime = 'endTime';
  static const String ticketLogNotes = 'notes';

  static const String leaveLeaveRequestID = 'leaveRequestID';
  static const String leaveRequestID = 'requestId';
  static const String leaveStartDate = 'startDate';
  static const String leaveEndDate = 'endDate';
  static const String leaveType = 'leaveType';
  static const String leaveTypeDescription = 'leaveTypeDescription';
  static const String leaveStatus = 'status';
  static const String leaveDateCreated = 'dateCreated';
  static const String leaveUnitOfMeasure = 'unitOfMeasure';
  static const String leaveQuantity = 'quantity';
  static const String leaveQuantityRemaining = 'quantityRemaining';
  static const String leaveStatusReason = 'statusReason';
  static const String leaveLoggedByID = 'loggedByID';
  static const String leaveLoggedBy = 'loggedBy';
  static const String leaveApprovedBy = 'approvedBy';
  static const String leaveApproverID = 'approverID';
  static const String leaveDescription = 'description';

  static const String versionAppName = 'appName';
  static const String versionApkVersionCode = 'versionNumber';
  static const String versionAppUsable = 'appUsable';

  static const String leaveProfilesID = 'id';
  static const String leaveProfilesType = 'type';
  static const String leaveProfilesLeaveType = 'leaveType';
  static const String leaveProfilesStatus = 'status';
  static const String leaveProfilesValidFrom = 'validFrom';
  static const String leaveProfilesValidTo = 'validTo';

  static const String leaveTypeItem = 'itemNo';
  static const String leaveTypeProductCode = 'productCode';
  static const String leaveTypeProductDescription = 'productDescription';
  static const String leaveTypeQuantity = 'quantity';
  static const String leaveTypeUnitOfMeasure = 'unitOfMeasure';
  static const String leaveTypeQuantityRemaining = 'quantityRemaining';
  static const String leaveTypeValidTo = 'validTo';
  static const String leaveTypeValidFrom = 'validFrom';

  static const String transactionId = 'id';
  static const String transactionValue = 'value';
  static const String transactionDateCreated = 'date_created';
  static const String transactionRelation = 'transaction';
  static const String transactionTimeCreated = 'timeCreated';
  static const String transactionLoggedById = 'loggedById';
  static const String transactionLoggedBy = 'loggedBy';

}

class Resources{
  static const String otp = 'otp';
  static const String authenticate = 'authenticate';
  static const String tickets = 'tickets';
  static const String ticketsLog = 'ticketsLog';
  static const String ticketInProgress = 'inprogress';
  static const String ticketAwaiting = 'awaitingCustomer';
  static const String ticketResolve = 'resolved';
  static const String ticketReject = 'reject';
  static const String ticketCancel = 'cancel';
  static const String users = 'users';
  static const String resetPassword = 'passwordReset';
  static const String forgotPassword = 'forgotPassword';
  static const String versions = 'versions';
  static const String leaves = 'leaves';
  static const String fields = 'fields';
  static const String fieldOptions = 'fieldoptions';
  static const String leavesApprovers = 'leavesApprovers';
  static const String leavesToApprove = 'leavesToApprove';
  static const String leaveProfiles = 'leaveProfiles';
  static const String transactionNotes = 'transactionNotes';

  static const String approve = 'Approve';
  static const String approveCancellation = 'ApproveCancellation';
  static const String approveEditedLeave = 'ApproveEditedLeave';
  static const String rejectApproval = 'RejectApproval';
  static const String rejectCancel = 'RejectCancel';
  static const String rejectEditedLeave = 'rejectEditedLeave';
  static const String cancel = 'Cancel';
  static const String edit = 'Edit';

  static const String roles = 'roles';


  static const String ticketStatusNew = 'new';
  static const String ticketStatusOpen = 'open';
  static const String ticketStatusClosed = 'closed';
  static const String ticketStatusInProgress = 'inprogress';
  static const String ticketStatusAwaitingApproval = 'awaitingCustomer';

}

class JsonPayloadKeys{

  static const String value = 'value';
  static const String type = 'type';
  static const String transaction = 'transaction';

  static const String otp = 'otp';
  static const String otpPartnerEmail = 'partnerEmail';

  static const String ticketStatusNew = 'New';
  static const String ticketStatusOpen = 'Open';
  static const String ticketStatusClosed = 'Closed';
  static const String ticketStatusInProgress = 'Inprogress';
  static const String ticketStatusCompleted = 'Completed';
  static const String ticketStatusResolved = 'Resolved';

  static const String loggedByID = 'loggedByID';
  static const String approverID = 'approverID';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
  static const String description = 'description';
  static const String subDescription = 'subDescription';
  static const String leaveType = 'leaveType';

// static const String  = '';
}

class QueryParameters{

  static const String versionAppName = 'appName';
  static const String versionApkVersionCode = 'versionNumber';
  static const String versionAppUsable = 'appUsable';
  static const String partnerFunction = 'partnerFunction';
  static const String partnerFunctionEmployee = 'EMPLOYEE';
  static const String partnerFunctionOrganization = 'ORGANIZATION';

  static const String partnerNo = 'partnerNo';
  static const String transaction = 'transaction';
  static const String otp = 'otp';

  static const String filter = 'filter';
  static const String filterValue = 'x';
  static const String assignedTo = 'assignedTo';
  static const String assignedToID = 'assignedToID';
  static const String clintID = 'clintID';
  static const String status = 'status';

  static const String partnerID = 'partnerID';
  static const String partnerId = 'partnerId';
  static const String ticketID = 'ticketID';
  static const String approverId = 'approverId';

  static const String field = 'field';

  static const String organisationId = 'organisationId';
  static const String endDAte = 'endDate';


}

class Statuses{
  static const String pending = 'Pending';
  static const String approved = 'Approved';
  static const String cancelled = 'Cancelled';
}

class StatusReasons {

  static const String awaitingApproval = 'Awaiting Approval';
  static const String awaitingCancelApproval = 'Awaiting Cancel Approval';
  static const String awaitingEditApproval = 'Awaiting Edit Approval';
}

class SharedPreferencesKeys{
  static const token = 'token';
  static const username = 'username';
  static const lastPage = 'lastPage';
  static const startTime = 'startTime';
  static const endTime = 'endTime';
  static const isTracking = 'isTracking';
  static const trackingTicketID = 'trackingTicketID';

}