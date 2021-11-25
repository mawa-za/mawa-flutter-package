part of mawa;

class Tickets {
  Tickets({required String ticketID}) {
    Tickets.ticketNo = ticketID;
  }
  static late String ticketNo;
  static late bool isTracking;
  static late List newTickets;
  static late List myTickets;
  static late Map ticket;

  static trackTicket() async {
    List tickets = await Tickets.allMyTickets();
    List list = [];
    Map map = {};
    
    for (int i = 0; i < tickets.length; i++) {
      list.add(tickets[i][JsonResponses.status]);
      map[tickets[i][JsonResponses.status]] = i;
    }

    if (list.contains(JsonPayloads.InProgress)) {
      // final Map map = list.asMap();
      print('inprog');
      Tickets.ticket = tickets[map[JsonPayloads.InProgress]];
      ticketNo = Tickets.ticket[JsonResponses.id];
      Time.dueTime =
          DateTime.parse(ticket[JsonResponses.dueDate].toString());
      Time.countDownTimer.onExecute.add(StopWatchExecute.start);
      // getTicket(ticketNo);
      // Tickets(ticketID: ticketNo).ticketLogGet();
      Tickets.isTracking = true;
      await TicketLogs.searchUsersLog();

      // Navigator.pushNamed(Tools.context, TrackTicket.id);
    }

    else if (Tickets.ticket[JsonResponses.status] == JsonPayloads.InProgress &&
        Tickets.ticket[JsonResponses.assignedToID] != User.loggedInUser[JsonResponses.usersPartner]) {
      isTracking = false;
      Alerts.flushbar(
          context: Tools.context,
          message: 'Ticket Already Being tracked',
          positive: false,
          popContext: false);
    }
    else if (Tickets.ticket[JsonResponses.status] == JsonPayloads.New ||
        Tickets.ticket[JsonResponses.status] == JsonPayloads.Open)  {
      print('else');

      ticketNo = Tickets.ticket[JsonResponses.id];
      Time.dueTime =
          DateTime.parse(ticket[JsonResponses.dueDate]);

      if (Tickets.ticket[JsonResponses.status] ==
          JsonPayloads.New) {
        await openTicket(ticketNo);
      }

      if (Tickets.ticket[JsonResponses.assignedTo] !=
          User.loggedInUser[JsonResponses.usersPartner]) {
        await reassignTicket(Tickets.ticketNo);
      }

      await TicketLogs(ticketID: Tickets.ticketNo).ticketLogCreate();
      if (NetworkRequests.statusCode == 200) {
        Alerts.flushbar(
            context: Tools.context,
            message: 'You Have Started Working on The Ticket',
            positive: true,
            popContext: false);

        await changeTicketStatus(status: Resources.inprogress);
        if (NetworkRequests.statusCode == 200) {
          await TicketLogs(ticketID: ticketNo).ticketLogGet();
          Tickets.isTracking = true;
          // final SharedPreferences prefs = await preferences;
          // prefs.setString(
          //     SharedPreferencesKeys.startTime, DateTime.now().toString());
          // prefs.setString(
          //     SharedPreferencesKeys.isTracking, Tickets.isTracking.toString());
          // prefs.setString(SharedPreferencesKeys.trackingTicketID,
          //     Tickets.ticket[JsonResponseKeys.ticketAssignedToID]);

          // Time.startTime = DateTime.parse(
          //     prefs.getString(SharedPreferencesKeys.startTime) ??
          //         DateTime.now().toString());

          Time.countDownTimer.onExecute.add(StopWatchExecute.start);
          // Navigator.push(Tools.context, MaterialPageRoute(builder: (_)=> TrackTicket()));
          // Navigator.pushNamed(Tools.context, TrackTicket.id);
        }
      }
    }
    else {
      isTracking = false;
      Alerts.flushbar(
          context: Tools.context,
          message: 'Ticket Is ${Tickets.ticket[JsonResponses.status]}',
          positive: false,
          popContext: false);
    }
  }

  endTracking(status) async {
    await TicketLogs(ticketID: ticketNo).ticketLogClose(status);
    if (NetworkRequests.statusCode == 200) {
      // await changeTicketStatus(status: Resources.awaitingCustomer);
      isTracking = false;

      Time.countDownTimer.onExecute.add(StopWatchExecute.stop);
      // Navigator.popAndPushNamed(Tools.context, DashBoard.id);
    }
  }

  static getTicket(String id) async {
    print('getTicket');
    // ignore: unnecessary_null_comparison
    if (id != null && id != '') {
      ticket = await NetworkRequests().securedMawaAPI(
            NetworkRequests.methodGet,
            resource: Resources.tickets + '/' + id,
          ) ??
          {};
      if (NetworkRequests.statusCode == 200){
        Time.dueTime =
            DateTime.parse(ticket[JsonResponses.dueDate].toString());
        ticketNo = ticket[JsonResponses.ticketLogID].toString();
      }

    }
  }

  static allMyTickets() async {
    print('allMyTickets');
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.tickets,
        queryParameters: {
          JsonPayloads.filter: JsonPayloads.filterValue,
          JsonPayloads.assignedTo: User.partnerId
        });

    if (NetworkRequests.statusCode == 200) {
      myTickets = await response;
    } else {
      myTickets = [];
    }

    for(int i = myTickets.length - 1; i >=0; i--){
      if(myTickets[i][JsonResponses.status] == JsonPayloads.InProgress){
        isTracking = true;
        break;
      }
      else{
        isTracking = false;
      }
    }
    return myTickets;
  }

  static getNewTickets() async {
    print('getNewTickets');
    newTickets = [];
    dynamic response = await NetworkRequests().securedMawaAPI(
            NetworkRequests.methodGet,
            resource: Resources.tickets,
            // queryParameters: {
            //   JsonPayloadKeys.filter: JsonPayloadKeys.filterValue,
            //   // JsonPayloadKeys.status: MapKeys.ticketStatusNew,
            //   JsonPayloadKeys.clintID: User.groupId,
            // }
            ) ??
        [];

    print(response.length);
    if(NetworkRequests.statusCode == 200){
      for(int i = 0; i < response.length; i++) {
        print(i);
        if(response[i][JsonResponses.status] == JsonPayloads.New || response[i][JsonResponses.status] == JsonPayloads.Open){
          newTickets.add(response[i]);
        }
      }

    }
    else{
      newTickets = [];
    }
    print(' gooi $newTickets');
    return newTickets;
  }

  static openTicket(String ticketId) async {
    print('openTicket');
    await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource:
            Resources.tickets + '/' + ticketId + '/' + Resources.ticketStatusOpen,
        queryParameters: {JsonPayloads.assignedTo: User.partnerId});
    NetworkRequests.statusCode == 200
        ? Alerts.flushbar(
            context: Tools.context,
            message: 'Ticket Successfully Assigned To You',
            positive: true,
            popContext: false)
        : null;
  }

  static reassignTicket(String ticket) async {
    print('reassignTicket');
    await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
        resource: Resources.tickets + '/' + ticket,
        body: {JsonPayloads.assignedToID: User.partnerId});
    NetworkRequests.statusCode == 200
        ? Alerts.flushbar(
            context: Tools.context,
            message: 'Ticket Successfully Assigned To You',
            positive: true,
            popContext: false)
        : null;
  }

  static changeTicketStatus({
    required String status,
  }) async {
    print('changeTicketStatus');

    await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.tickets + '/' + ticketNo + '/' + status,
    );
    if(NetworkRequests.statusCode == 200){
      Alerts.flushbar(context: Tools.context, message: 'Successfully ' + status + 'ed', popContext: false, positive: true);
    }
  }
}
