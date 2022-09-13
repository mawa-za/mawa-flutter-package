import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const urlBox = 'url list';
List<String> urls = [];

Map data = {
  'username': '',
  'token': '',
  'RefreshToken': '',
  'loggedInUser': {},
  'addresses': '',
  'list': [],
  'loginCounter': 0,
  'counter': 'DateTime.now',
};

class Urls extends StatefulWidget {
  @override
  _UrlsState createState() => _UrlsState();
}

class _UrlsState extends State<Urls> {
  Box<String> urlsListBox;

  @override
  void initState() {
    super.initState();
    urlsListBox = Hive.box(urlBox);
    urls = urlsListBox.values.toList();
  }

  void removeUrl(int index) {
    if (urlsListBox.containsKey(index)) {
      urlsListBox.delete(index);
      urls = urlsListBox.values.toList();
      return;
    }
    // favoriteBooksBox.put(index, urls[index]);
  }

  void addUrl(String url) {
    urlsListBox.add(url);
    urls = urlsListBox.values.toList();
    newUrl.clear();
  }

  TextEditingController newUrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              semanticLabel: 'Add new',
            ),
            onPressed: () {
              print('object ${urlsListBox.length} ${urlsListBox.values}');
              print(
                  '\nLength ${urlsListBox.values.length}\nfirst ${urlsListBox.values.first}\nall ${urlsListBox}');
              print(
                  '\nLength ${urls.length}\nfirst ${urls.first}\nall ${urls}');
            }),
        appBar: AppBar(
          title: Text("My saved URL's"),
          flexibleSpace: Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: <Color>[
                  Colors.deepPurple.shade900,
                  Colors.deepPurple.shade700,
                  Colors.deepPurple.shade500,
                  Colors.deepPurple.shade300,
                  Colors.deepPurple.shade100,
                  Colors.deepPurple.shade50,

                  // Colors.deepPurpleAccent,
                  // Colors.purple,
                  // Colors.purpleAccent,

                  // Color(0xff1f005c),
                  // Color(0xff5b0060),
                  // Color(0xff870160),
                  // Color(0xffac255e),
                  // Color(0xffca485c),
                  // Color(0xffe16b5c),
                  // Color(0xfff39060),
                  // Color(0xffffb56b),
                ], // Gradient from https://learnui.design/tools/gradient-generator.html
                tileMode: TileMode.mirror,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.web),
                labelText: 'URL',
              ),
              controller: newUrl,
              onEditingComplete: () => addUrl(newUrl.text),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: urlsListBox.listenable(),
                builder: (context, Box<String> box, _) {
                  return ListView.separated(
                    separatorBuilder: (c, l) {
                      return Divider();
                    },
                    itemCount: urls.length,
                    itemBuilder: (context, listIndex) {
                      return ListTile(
                        onTap: () {},
                        title: Text(urls[listIndex]),
                        trailing: IconButton(
                          icon: /*getIcon(listIndex)*/ Icon(Icons.cancel),
                          onPressed: () => removeUrl(listIndex),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
