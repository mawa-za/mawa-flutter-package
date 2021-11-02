part of mawa;

class TicketLogs {
  TicketLogs({required String ticketID}) {
    Tickets.ticketNo = ticketID;
  }

  static late List allTicketLogs;
  static late Map ticketsLog;
  static late String ticketLogID;

  Future<void> ticketLogCreate() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPost,
        resource: Resources.ticketsLog,
        body: {
          JsonPayloads.partnerID: User.partnerId,
          JsonPayloads.ticketID: Tickets.ticketNo,
        });
    if (NetworkRequests.statusCode == 200) {
      ticketLogID = response;
      if(Tickets.ticket[JsonResponses.status] != JsonPayloads.InProgress) {
        await Tickets.changeTicketStatus(status: Resources.inprogress);
      }
    }
  }

  static Future<dynamic> ticketLogSearch() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.ticketsLog,
        queryParameters: {
          QueryParameters.id: Tickets.ticketNo,
        });
    if (NetworkRequests.statusCode == 200) {
      allTicketLogs = response;
    }
    return allTicketLogs;
  }

  Future<void> ticketLogClose(status) async {
    // Tickets.ticketLogID != null ?
    await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.ticketsLog + '/' + ticketLogID,
    )
    // : null
        ;
    if(NetworkRequests.statusCode == 200) {
      status == Tools.close
          ? Tickets.changeTicketStatus(status: Resources.awaitingCustomer)
          : status == Tools.pause
              ? Tickets.openTicket(Tickets.ticketNo)
              : null;
    }
  }

  Future<dynamic> ticketLogGet() async {
    dynamic resp = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodGet,
      resource: Resources.ticketsLog + '/' + ticketLogID,
    );

    if (NetworkRequests.statusCode == 200) {
      ticketsLog = await resp;
      Time.startTime =
          DateTime.parse(await ticketsLog[JsonResponses.ticketLogStartTime]);
    }
  }


  static searchUsersLog() async {
    await TicketLogs.ticketLogSearch();
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
        await TicketLogs(ticketID: Tickets.ticketNo).ticketLogCreate();
        await TicketLogs(ticketID: Tickets.ticketNo).ticketLogGet();
      }
      TicketLogs.ticketLogID = TicketLogs.ticketsLog[JsonResponses.ticketLogID];
      Time.startTime = DateTime.parse(TicketLogs.ticketsLog[JsonResponses.ticketLogStartTime]);
    }
    else{
      await TicketLogs(ticketID: Tickets.ticketNo).ticketLogCreate();
      await TicketLogs(ticketID: Tickets.ticketNo).ticketLogGet();
    }
  }

}