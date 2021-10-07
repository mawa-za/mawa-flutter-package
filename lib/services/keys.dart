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



  static const String versionAppName = 'appName';
  static const String versionApkVersionCode = 'versionNumber';
  static const String versionAppUsable = 'appUsable';
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
  static const String leavesApprovers = 'leavesApprovers';
  static const String leavesToApprove = 'leavesToApprove';
  static const String leaveProfiles = 'leaveProfiles';
  static const String policiesResource = 'policies';


  static const String ticketStatusNew = 'new';
  static const String ticketStatusOpen = 'open';
  static const String ticketStatusClosed = 'closed';
  static const String ticketStatusInProgress = 'inprogress';
  static const String ticketStatusAwaitingApproval = 'awaitingCustomer';
}

class JsonPayloadKeys{

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
  static const String otp = 'otp';

  static const String filter = 'filter';
  static const String filterValue = 'x';
  static const String assignedTo = 'assignedTo';
  static const String assignedToID = 'assignedToID';
  static const String clintID = 'clintID';
  static const String status = 'status';

  static const String partnerID = 'partnerID';
  static const String ticketID = 'ticketID';
  static const String approverId = 'approverId';

}

class SharedPreferencesKeys{
  static const token = 'token';
  static const lastPage = 'lastPage';
  static const startTime = 'startTime';
  static const endTime = 'endTime';
  static const isTracking = 'isTracking';
  static const trackingTicketID = 'trackingTicketID';

}