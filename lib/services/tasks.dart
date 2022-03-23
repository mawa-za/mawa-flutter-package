import 'package:mawa/services/keys.dart';
import 'package:mawa/services/network_requests.dart';

class Tasks {
  Tasks({this.reference,required this.taskID});
  late String taskID;
  static late List tasks;
  String? reference;


  // static responseAction(dynamic response, dynamic negativeResult) async {
  //   if (response.statusCode == 200) {
  //     return await NetworkRequests.decodeJson(response);
  //   } else {
  //     return negativeResult;
  //   }
  // }

  //     getting all task assigned to someone
//     GET /mawa-api/resources/tickets/getTasksAssigned?assignTo=PN0000000570
  static getAllAssignedTasks(assignTo) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.tickets}/${Resources.getTasksAssigned}',
        queryParameters: {
          QueryParameters.assignTo: assignTo,
        });
    return await NetworkRequests.decodeJson(response, negativeResponse: []);
  }

//     editing task
//     PUT /mawa-api/resources/tickets/editTask
//      {
//     "ticketTaskID":"TTSK0000000007",
//     "summary":"backend issue on tickets",
//     "assignedTo":"PN0000000570",
//     "taskDescription":"please take a look at ticket",
//     "dueDate":"2022-02-25"
//     }
//     Please note the task id should always be passed, and all the other fields are only passed if you want to update them.
  editTask({
    String? dueDate,
    String? description,
    String? summary,
    String? assignedTo,
  }) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.tickets}/${Resources.tickets}',
        body: {
          QueryParameters.ticketTaskID: taskID,
          QueryParameters.summary: summary,
          QueryParameters.assignedTo: assignedTo,
          QueryParameters.taskDescription: description,
          QueryParameters.dueDate: dueDate,
        });
    return await NetworkRequests.decodeJson(response, negativeResponse: '');
  }

// Start a task log
//     PUT /mawa-api/resources/tickets/startTask?ticketTaskID=TTSK0000000007&loggedByID=PN0000000570
//     please note the logged by is the person who started a task
  startTaskLog(loggedByID) async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodPut,
        resource: '${Resources.tickets}/${Resources.startTask}',
        queryParameters: {
          QueryParameters.ticketTaskID: taskID,
          QueryParameters.loggedById: loggedByID,
        });
    return await NetworkRequests.decodeJson(response, negativeResponse: '');
  }

// Marking a task as complete
//PUT /mawa-api/resources/tickets/completeTask?ticketTaskID=TTSK0000000007
// cancel a task
//PUT /mawa-api/resources/tickets/cancelTask?ticketTaskID=TTSK0000000008
//     ending a task that belongs to ticket
// PUT/mawa-api/resources/tickets/endTask?ticketTaskID=TTSK0000000006&taskLogID=TLG0000000034
//     please note taskLogID is the log you are stopping and will be returned when getting a task

  actionTask({required String actionResource, String? note}) async {
    Map<String, dynamic> body = {
      QueryParameters.ticketTaskID: taskID,
    };
    note != null ? body[QueryParameters.note] = {
      'value': note,
      'type': "TICKETTASK"
    } : null;
    dynamic response = await NetworkRequests().securedMawaAPI(
      NetworkRequests.methodPut,
      resource: '${Resources.tickets}/$actionResource',
      body: body,
    );
    return await NetworkRequests.decodeJson(response, negativeResponse: '');
  }

//    getting a specific task
//  GET /mawa-api/resources/tickets/getSpecificTask?ticketTaskID=TTSK0000000003
  getTask() async {
    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.tickets}/${Resources.getSpecificTask}',
        queryParameters: {
          QueryParameters.ticketTaskID: taskID,
        });
    return await NetworkRequests.decodeJson(response, negativeResponse: '');

  }

//  getting a list of tasks that belong to a ticket
//  GET /mawa-api/resources/tickets/TN0000000007/getTasks
  getTicketTasks() async {

    dynamic response = await NetworkRequests().securedMawaAPI(
        NetworkRequests.methodGet,
        resource: '${Resources.tickets}/$reference/${Resources.getTasks}',
        );
    return await NetworkRequests.decodeJson(response, negativeResponse: '');
  }

}
