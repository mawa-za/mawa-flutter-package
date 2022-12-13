import 'package:flutter/material.dart';
import 'package:mawa_package/mawa_package.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String id = 'Dashboard';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  future() async {
    await WorkCenters().getAllWorkCenters();
    // _itemController = DashboardItemController(items:
    // dashboardItems(),);

  }
  dashboardItems(snapData){
    List<Widget> list = [];
    print('${snapData.length}');
    for(int i = 0; i < snapData.length; i++){
      print('${snapData[i][JsonResponses.description]}');
      // list.add(Container(
      //   color: Colors.green.shade300,
      //   child: Center(
      //     child: ListTile(
      //       leading: const Icon(CupertinoIcons.app, size: 50.0),
      //       title: Text('${snapData[i][JsonResponses.description]}'),
      //       // subtitle: const Text('Best of Sonu Nigam Song'),
      //       isThreeLine: false,
      //     ),
      //   ),
      // ));
      list.add(Card(
          color: Colors.orange,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(child: Icon(Icons.access_alarm, size:50.0, )),
                Text('${snapData[i][JsonResponses.description]}', ),
              ]
          ),
          )
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: future(),
        builder: (context, snapshot) {
          Widget body;
          if(snapshot.connectionState == ConnectionState.done){
            if(WorkCenters.workcenters.isNotEmpty){
                body = Scaffold(
                  appBar: AppBar(),
                  body: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 8.0,
                    children: dashboardItems(WorkCenters.workcenters),
                  )
                  /*Dashboard(
              dashboardItemController: _itemController,
              itemBuilder: (DashboardItem item) {

             },
            )*/
                  ,
                  persistentFooterButtons: [],
                );
              }
            else {
              body =
                  Scaffold(body: SnapShortStaticWidgets.futureNoData(),);
            }
            }
          else if (snapshot.connectionState ==
          ConnectionState.waiting) {
          body =
          Scaffold(body: SnapShortStaticWidgets.snapshotWaitingIndicator(),);
          } else if (snapshot.hasError) {
          body =
              Scaffold(body:  SnapShortStaticWidgets.snapshotError(),);
          } else {
          body =
              Scaffold(body: SnapShortStaticWidgets.futureNoData(),);
          }

          return body;
        }
      ),
    );
  }
}
