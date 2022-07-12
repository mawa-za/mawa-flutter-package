import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:mawa_package/services/keys.dart';
import 'package:mawa_package/services/network_requests.dart';
import 'package:mawa_package/services/timer.dart';
import 'package:mawa_package/services/ticket_logs.dart';
import 'package:mawa_package/services/tools.dart';
import 'package:mawa_package/services/user.dart';
import 'package:mawa_package/screens/alerts.dart';

class Tickets {
  Tickets({required String ticketID, page}) {
    Tickets.ticketNo = ticketID;
    pageId = page;
  }
  static String? pageId;
  static late String ticketNo;
  static late bool isTracking;
  static late List newTickets = [];
  static List myTickets = [];
  static List allTickets = [];
  static late Map ticket = {};
  static Map? changeStatusBody;

  static trackTicket(dynamic after) async {
    List tickets = await NetworkRequests.decodeJson(await Tickets.allMyTickets());
    List list = [];
    Map map = {};

    for (int i = 0; i < tickets.length; i++) {
      list.add(tickets[i][JsonResponses.status]);
      map[tickets[i][JsonResponses.status]] = i;
    }

    if (list.contains(JsonPayloads.InProgress)) {
      // final Map map = list.asMap();
      Tickets.ticket = tickets[map[JsonPayloads.InProgress]];
      ticketNo = Tickets.ticket[JsonResponses.id];
      Time.dueTime =
          DateTime.parse(ticket[JsonResponses.dueDate].toString());
      Time.countDownTimer.onExecute.add(StopWatchExecute.start);
      // getTicket(ticketNo);
      // Tickets(ticketID: ticketNo).ticketLogGet();
      Tickets.isTracking = true;
      await TicketLogs(ticketID: ticketNo).searchUsersLog();

      after;      // Navigator.pushNamed(Tools.context, TrackTicket.id);
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

      ticketNo = Tickets.ticket[JsonResponses.id];
      Time.dueTime =
          DateTime.parse(ticket[JsonResponses.dueDate]);

      if (Tickets.ticket[JsonResponses.status] ==
          JsonPayloads.New) {
        await openTicket(ticketNo);
      }
      else if (Tickets.ticket[JsonResponses.assignedTo] !=
          User.loggedInUser[JsonResponses.usersPartner]) {
        await reassignTicket(Tickets.ticketNo);
      }

      dynamic status = await TicketLogs(ticketID: Tickets.ticketNo).ticketLogCreate();
      if (status == 200) {
        Alerts.flushbar(
            context: Tools.context,
            message: 'You Have Started Working on The Ticket',
            positive: true,
            popContext: false);

        int code = await changeTicketStatus(status: Resources.inprogress);
        if (code == 200) {
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
          after; // Navigator.pushNamed(Tools.context, TrackTicket.id);
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
    dynamic response = await TicketLogs(ticketID: ticketNo).ticketLogClose(status);
    if (response == 200) {
      // await changeTicketStatus(status: Resources.awaitingCustomer);
      isTracking = false;

      Time.countDownTimer.onExecute.add(StopWatchExecute.stop);
      // Navigator.popAndPushNamed(Tools.context, DashBoard.id);
      return true;
    }
    else{
      return false;
    }
  }

  static getTicket(String id) async {
    // ignore: unnecessary_null_comparison
    if (id != null && id != '') {
      dynamic response = await NetworkRequests().securedMawaAPI(
            NetworkRequests.methodGet,
            resource: Resources.tickets + '/' + id,
          ) ??
          {};
      if (response.statusCode == 200){
        ticket = NetworkRequests.decodeJson(response);
        // Time.dueTime =
        //     DateTime.parse(ticket[JsonResponses.dueDate].toString());
        ticketNo = ticket[JsonResponses.ticketLogID].toString();
      }

    }
  }

  static getTicketByStatus(String status) async{
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.tickets,
        queryParameters: {
          JsonPayloads.filter: JsonPayloads.filterValue,
          JsonPayloads.status: status
        });
    allTickets = await NetworkRequests.decodeJson(response);
    return allTickets;
  }

  static allMyTickets() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: Resources.tickets,
        queryParameters: {
          JsonPayloads.filter: JsonPayloads.filterValue,
          JsonPayloads.assignedTo: User.partnerId
        });

    if (response.statusCode == 200) {
      myTickets = await NetworkRequests.decodeJson(response);
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
    newTickets.clear();
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

    if(response.statusCode == 200){
      dynamic data = await NetworkRequests.decodeJson(response);
      for(int i = 0; i < data.length; i++) {
        print(i);
        if(data[i][JsonResponses.status] == JsonPayloads.New || data[i][JsonResponses.status] == JsonPayloads.Open){
          newTickets.add(data[i]);
        }
      }

    }
    else{
      newTickets = [];
    }
    return newTickets;
  }

  static openTicket(String ticketId) async {
    dynamic response = await NetworkRequests().securedMawaAPI(NetworkRequests.methodPost,
        resource:
            Resources.tickets + '/' + ticketId + '/' + Resources.ticketStatusOpen,
        queryParameters: {JsonPayloads.assignedTo: User.partnerId});
    response.statusCode == 200
        ? Alerts.flushbar(
            context: Tools.context,
            message: 'Ticket Successfully Assigned To You',
            positive: true,
            popContext: false)
        : null;
  }

  static reassignTicket(String ticket) async {
    dynamic response = await NetworkRequests().securedMawaAPI(NetworkRequests.methodPut,
        resource: Resources.tickets + '/' + ticket,
        body: {JsonPayloads.assignedToID: User.partnerId});
    response.statusCode == 200
        ? Alerts.flushbar(
            context: Tools.context,
            message: 'Ticket Successfully Assigned To You',
            positive: true,
            popContext: false)
        : null;
  }

  ///if the reason for changing the status is a resolution or a rejection, then a body must be supplied by initializing [changeStatusBody]
  static changeTicketStatus({
    required String status,
  }) async {

    dynamic response = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPost,
      resource: Resources.tickets + '/' + ticketNo + '/' + status,
      body: changeStatusBody ?? {},
    );
    if(response.statusCode == 200){
      Alerts.flushbar(context: Tools.context, message: 'Successfully ' + status + 'ed', popContext: false, positive: true);
    }
    return response.statusCode;
  }
}
