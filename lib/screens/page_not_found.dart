part of 'package:mawa_package/mawa_package.dart';

class PageNotFound extends StatelessWidget {
  static const String id = 'Page not found';
  PageNotFound({Key? key, this.appBar, this.drawer}) : super(key: key);
  AppBar? appBar;
  Drawer? drawer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appBar ?? AppBar(
        title: Text(id),
      ),
      drawer: drawer ?? const Drawer(),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: const [
          Flexible(child: Icon(Icons.error,size: 100.0,)),
          Text('Sorry the page you are looking for was not found'),
        ],
      )),
    ));
  }
}
