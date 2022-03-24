part of mawa;

class TicketLogs {
  TicketLogs({required String ticketID}) {
    Tickets.ticketNo = ticketID;
  }

  static List allTicketLogs = [];
  static Map ticketsLog = {};
  static late String ticketLogID;

  Future<dynamic> ticketLogCreate() async {
    dynamic response =  await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.ticketsLog,
        body: {
          JsonPayloads.partnerID: User.partnerId,
          JsonPayloads.ticketID: Tickets.ticketNo,
        });
    if (response.statusCode == 200) {
      ticketLogID = NetworkRequests.decodeJson(response);
      if(Tickets.ticket[JsonResponses.status] != JsonPayloads.InProgress) {
        await Tickets.changeTicketStatus(status: Resources.inprogress);
      }
    }
    return response.statusCode;
  }

  Future<dynamic> ticketLogSearch() async {
    dynamic response =await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.ticketsLog,
        queryParameters: {
          QueryParameters.id: Tickets.ticketNo,
        });
    if (response.statusCode == 200) {
      allTicketLogs =  await NetworkRequests.decodeJson(response);
    }
    else{
      allTicketLogs = [];
    }
    return allTicketLogs;
  }

  Future<dynamic> ticketLogClose(status) async {
    // Tickets.ticketLogID != null ?
    dynamic response = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.ticketsLog + '/' + ticketLogID,
    )
    // : null
        ;
    if(response.statusCode == 200) {
      status == Tools.resolve
          ? Tickets.changeTicketStatus(status: Resources.awaitingCustomer)
          : status == Tools.close
              ? Tickets.openTicket(Tickets.ticketNo)
              : null;
    }
    return response.statusCode;
  }

  Future<dynamic> ticketLogGet() async {
    dynamic resp = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.ticketsLog + '/' + ticketLogID,
    );

    if (resp.statusCode == 200) {
      ticketsLog = await NetworkRequests.decodeJson(await resp);
      Time.startTime =
          DateTime.parse(await ticketsLog[JsonResponses.ticketLogStartTime]);
    }
    else{
      ticketsLog = {};
    }
    // return resp.statusCode;
  }

  Future<dynamic> searchUsersLog() async {
    await TicketLogs(ticketID: Tickets.ticketNo).ticketLogSearch();
    if(TicketLogs.allTicketLogs.isNotEmpty){
      List assigndTo = [];
      for(int i = TicketLogs.allTicketLogs.length -1; i >= 0; i--){
        if(TicketLogs.allTicketLogs[i][JsonResponses.ticketLogPartnerId] == User.loggedInUser[JsonResponses.usersPartner]
            && TicketLogs.allTicketLogs[i][JsonResponses.ticketLogEndTime] == null){
          assigndTo.add(TicketLogs.allTicketLogs[i][JsonResponses.ticketLogPartnerId]);
          TicketLogs.ticketsLog = TicketLogs.allTicketLogs[i];
          TicketLogs.ticketLogID = TicketLogs.ticketsLog[JsonResponses.ticketLogID];
          break;
        }
      }

      if(assigndTo.contains( User.loggedInUser[JsonResponses.usersPartner]) == false){
        dynamic code = await TicketLogs(ticketID: Tickets.ticketNo).ticketLogCreate();
        if(code == 200) await TicketLogs(ticketID: Tickets.ticketNo).ticketLogGet();
      }
      TicketLogs.ticketLogID = TicketLogs.ticketsLog[JsonResponses.ticketLogID];
      Time.startTime = DateTime.parse(TicketLogs.ticketsLog[JsonResponses.ticketLogStartTime]);
    }
    else{
      dynamic code = await TicketLogs(ticketID: Tickets.ticketNo).ticketLogCreate();
      if(code == 200) await TicketLogs(ticketID: Tickets.ticketNo).ticketLogGet();
    }
  }

}