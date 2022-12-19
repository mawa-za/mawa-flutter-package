part of 'package:mawa_package/mawa_package.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Page not found'),
      ),
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
