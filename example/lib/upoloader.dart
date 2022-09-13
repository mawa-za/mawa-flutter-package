import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_uploader/flutter_uploader.dart';

import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawa_package/dependencies.dart';

import 'package:equatable/equatable.dart';
import 'package:mawa_package/mawa.dart';

const String title = 'FileUpload Sample app';
final Uri uploadURL = Uri.parse(
  'https://us-central1-flutteruploadertest.cloudfunctions.net/upload',
);
final NetworkRequests mawa = NetworkRequests();
Uri url = Uri.https('api-qas.mawa.co.za:8181', NetworkRequests.path + Resources.attachments,
    {
      JsonPayloads.parentType: 'TRANSACTION',
      JsonPayloads.parentReference: 'TN0000000028',
      JsonPayloads.documentType: 'JPG',
    },
);


FlutterUploader _uploader = FlutterUploader();

void backgroundHandler() {
  WidgetsFlutterBinding.ensureInitialized();

  // Notice these instances belong to a forked isolate.
  var uploader = FlutterUploader();

  var notifications = FlutterLocalNotificationsPlugin();

  // Only show notifications for unprocessed uploads.
  SharedPreferences.getInstance().then((preferences) {
    var processed = preferences.getStringList('processed') ?? <String>[];

    if (Platform.isAndroid) {
      uploader.progress.listen((progress) {
        if (processed.contains(progress.taskId)) {
          return;
        }

        notifications.show(
          progress.taskId.hashCode,
          'FlutterUploader Example',
          'Upload in Progress',
          NotificationDetails(
            android: AndroidNotificationDetails(
              'FlutterUploader.Example',
              'FlutterUploader',
              channelDescription:
              'Installed when you activate the Flutter Uploader Example',
              progress: progress.progress ?? 0,
              icon: 'ic_upload',
              enableVibration: false,
              importance: Importance.low,
              showProgress: true,
              onlyAlertOnce: true,
              maxProgress: 100,
              channelShowBadge: false,
            ),
            iOS: const IOSNotificationDetails(),
          ),
        );
      });
    }

    uploader.result.listen((result) {
      if (processed.contains(result.taskId)) {
        return;
      }

      processed.add(result.taskId);
      preferences.setStringList('processed', processed);

      notifications.cancel(result.taskId.hashCode);

      final successful = result.status == UploadTaskStatus.complete;

      var title = 'Upload Complete';
      if (result.status == UploadTaskStatus.failed) {
        title = 'Upload Failed';
      } else if (result.status == UploadTaskStatus.canceled) {
        title = 'Upload Canceled';
      }

      notifications
          .show(
        result.taskId.hashCode,
        'FlutterUploader Example',
        title,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'FlutterUploader.Example',
            'FlutterUploader',
            channelDescription:
            'Installed when you activate the Flutter Uploader Example',
            icon: 'ic_upload',
            enableVibration: !successful,
            importance: result.status == UploadTaskStatus.failed
                ? Importance.high
                : Importance.min,
          ),
          iOS: const IOSNotificationDetails(
            presentAlert: true,
          ),
        ),
      )
          .catchError((e, stack) {
        print('error while showing notification: $e, $stack');
      });
    });
  });
}

void main() => runApp(const Upploader());

class Upploader extends StatefulWidget {
  const Upploader({Key? key}) : super(key: key);

  @override
  _UpploaderState createState() => _UpploaderState();
}

class _UpploaderState extends State<Upploader> {
  int _currentIndex = 0;

  bool allowCellular = true;

  @override
  void initState() {
    super.initState();

    _uploader.setBackgroundHandler(backgroundHandler);

    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('ic_upload');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {},
    );

    SharedPreferences.getInstance()
        .then((sp) => sp.getBool('allowCellular') ?? true)
        .then((result) {
      if (mounted) {
        setState(() {
          allowCellular = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(allowCellular
                  ? Icons.signal_cellular_connected_no_internet_4_bar
                  : Icons.wifi_outlined),
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                await sp.setBool('allowCellular', !allowCellular);
                if (mounted) {
                  setState(() {
                    allowCellular = !allowCellular;
                  });
                }
              },
            ),
          ],
        ),
        body: _currentIndex == 0
            ? UploadScreen(
          uploader: _uploader,
          uploadURL: uploadURL,
          onUploadStarted: () {
            setState(() => _currentIndex = 1);
          },
        )
            : ResponsesScreen(
          uploader: _uploader,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_upload),
              label: 'Upload',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: 'Responses',
            ),
          ],
          onTap: (newIndex) {
            setState(() => _currentIndex = newIndex);
          },
          currentIndex: _currentIndex,
        ),
      ),
    );
  }
}
//-----------------------------------------------------------------

typedef CancelUploadCallback = Future<void> Function(String id);

class UploadItemView extends StatelessWidget {
  final UploadItem item;
  final CancelUploadCallback onCancel;

  UploadItemView({
    Key? key,
    required this.item,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                item.id,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(fontFamily: 'monospace'),
              ),
              Container(
                height: 5.0,
              ),
              Text(item.status!.description),
              // if (item.status == UploadTaskStatus.complete &&
              //     item.remoteHash != null)
              //   Builder(builder: (context) {
              //     return Column(
              //       mainAxisSize: MainAxisSize.min,
              //       crossAxisAlignment: CrossAxisAlignment.stretch,
              //       children: [
              //         _compareMd5(item.path, item.remoteHash),
              //         _compareSize(item.path, item.remoteSize),
              //       ],
              //     );
              //   }),
              Container(height: 5.0),
              if (item.status == UploadTaskStatus.running)
                LinearProgressIndicator(value: item.progress!.toDouble() / 100),
              if (item.status == UploadTaskStatus.complete ||
                  item.status == UploadTaskStatus.failed) ...[
                Text('HTTP status code: ${item.response!.statusCode}'),
                if (item.response!.response != null)
                  Text(
                    item.response!.response!,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontFamily: 'monospace'),
                  ),
              ]
            ],
          ),
        ),
        if (item.status == UploadTaskStatus.running)
          Container(
            height: 50,
            width: 50,
            child: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () => onCancel(item.id),
            ),
          )
      ],
    );
  }

// Text _compareMd5(String localPath, String remoteHash) {
//   final File file = File(localPath);
//   if (!file.existsSync()) {
//     return Text(
//       'File ƒ',
//       style: TextStyle(color: Colors.grey),
//     );
//   }

//   var digest = md5.convert(file.readAsBytesSync());
//   if (digest.toString().toLowerCase() == remoteHash) {
//     return Text(
//       'Hash $digest √',
//       style: TextStyle(color: Colors.green),
//     );
//   } else {
//     return Text(
//       'Hash $digest vs $remoteHash ƒ',
//       style: TextStyle(color: Colors.red),
//     );
//   }
// }

// Text _compareSize(String localPath, int remoteSize) {
//   final File file = File(localPath);
//   if (!file.existsSync()) {
//     return Text(
//       'File ƒ',
//       style: TextStyle(color: Colors.grey),
//     );
//   }

//   final length = file.lengthSync();
//   if (length == remoteSize) {
//     return Text(
//       'Length $length √',
//       style: TextStyle(color: Colors.green),
//     );
//   } else {
//     return Text(
//       'Length $length vs $remoteSize ƒ',
//       style: TextStyle(color: Colors.red),
//     );
//   }
// }
}//-----------------------------------------------------------------

class UploadItem extends Equatable {
  final String id;
  final int? progress;
  final UploadTaskStatus? status;

  /// Store the entire response object.
  final UploadTaskResponse? response;

  const UploadItem(
      this.id, {
        this.progress,
        this.status,
        this.response,
      });

  UploadItem copyWith({
    String? id,
    int? progress,
    UploadTaskStatus? status,
    UploadTaskResponse? response,
  }) {
    return UploadItem(
      id ?? this.id,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      response: response ?? this.response,
    );
  }

  bool isCompleted() =>
      status == UploadTaskStatus.canceled ||
          status == UploadTaskStatus.complete ||
          status == UploadTaskStatus.failed;

  @override
  List<Object?> get props {
    return [
      id,
      progress,
      status,
      response,
    ];
  }
}
//-----------------------------------------------------------------
/// Configure server behavior
class ServerBehavior {
  /// User visible
  final String title;

  /// Backend server understands this
  final String name;

  ServerBehavior._(this.title, this.name);

  /// Default behavior
  static ServerBehavior defaultOk200 = ServerBehavior._('OK - 200', 'ok200');

  /// All available server behaviors.
  static List<ServerBehavior> all = [
    defaultOk200,
    ServerBehavior._('OK - 200, add random data', 'ok200randomdata'),
    ServerBehavior._('OK - 201', 'ok201'),
    ServerBehavior._('Error - 401', 'error401'),
    ServerBehavior._('Error - 403', 'error403'),
    ServerBehavior._('Error - 500', 'error500')
  ];
}
//-----------------------------------------------------------------

class UploadScreen extends StatefulWidget {
  const UploadScreen({
    Key? key,
    required this.uploader,
    required this.uploadURL,
    required this.onUploadStarted,
  }) : super(key: key);

  final FlutterUploader uploader;
  final Uri uploadURL;
  final VoidCallback onUploadStarted;

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  ImagePicker imagePicker = ImagePicker();

  ServerBehavior _serverBehavior = ServerBehavior.defaultOk200;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      imagePicker.getLostData().then((lostData) {
        if (lostData.isEmpty) {
          return;
        }

        if (lostData.type == RetrieveType.image) {
          _handleFileUpload([lostData.file!.path]);
        }
        if (lostData.type == RetrieveType.video) {
          _handleFileUpload([lostData.file!.path]);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Uploader'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Configure test Server Behavior',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                DropdownButton<ServerBehavior>(
                  items: ServerBehavior.all.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text('${e.title}'),
                    );
                  }).toList(),
                  onChanged: (newBehavior) {
                    if (newBehavior != null) {
                      setState(() => _serverBehavior = newBehavior);
                    }
                  },
                  value: _serverBehavior,
                ),
                Divider(),
                Text(
                  'multipart/form-data uploads',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => getImage(binary: false),
                      child: Text('upload image'),
                    ),
                    ElevatedButton(
                      onPressed: () => getVideo(binary: false),
                      child: Text('upload video'),
                    ),
                    ElevatedButton(
                      onPressed: () => getMultiple(binary: false),
                      child: Text('upload multi'),
                    ),
                  ],
                ),
                Divider(height: 40),
                Text(
                  'binary uploads',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text('this will upload selected files as binary'),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => getImage(binary: true),
                      child: Text('upload image'),
                    ),
                    ElevatedButton(
                      onPressed: () => getVideo(binary: true),
                      child: Text('upload video'),
                    ),
                    ElevatedButton(
                      onPressed: () => getMultiple(binary: true),
                      child: Text('upload multi'),
                    ),
                  ],
                ),
                Divider(height: 40),
                Text('Cancellation'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => widget.uploader.cancelAll(),
                      child: Text('Cancel All'),
                    ),
                    Container(width: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        widget.uploader.clearUploads();
                      },
                      child: Text('Clear Uploads'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage({required bool binary}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('binary', binary);

    var image = await imagePicker.getImage(source: ImageSource.gallery);

    if (image != null) {
      _handleFileUpload([image.path]);
    }
  }

  Future getVideo({required bool binary}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('binary', binary);

    var video = await imagePicker.getVideo(source: ImageSource.gallery);

    if (video != null) {
      _handleFileUpload([video.path]);
    }
  }

  Future getMultiple({required bool binary}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('binary', binary);

    final files = await FilePicker.platform.pickFiles(
      allowCompression: false,
      allowMultiple: true,
    );
    if (files != null && files.count > 0) {
      if (binary) {
        for (var file in files.files) {
          _handleFileUpload([file.path]);
        }
      } else {
        _handleFileUpload(files.paths);
      }
    }
  }

  void _handleFileUpload(List<String?> paths) async {
    final prefs = await SharedPreferences.getInstance();
    final binary = prefs.getBool('binary') ?? false;

    await widget.uploader.enqueue(_buildUpload(
      binary,
      paths.whereType<String>().toList(),
    ));

    widget.onUploadStarted();
  }

  Upload _buildUpload(bool binary, List<String> paths) {
    final tag = 'upload';

    var url = binary
        ? widget.uploadURL.replace(path: widget.uploadURL.path + 'Binary')
        : widget.uploadURL;

    url = url.replace(queryParameters: {
      'simulate': _serverBehavior.name,
    });

    if (binary) {
      return RawUpload(
        url: url.toString(),
        path: paths.first,
        method: UploadMethod.POST,
        tag: tag,
      );
    } else {
      return MultipartFormDataUpload(
        url: url.toString(),
        data: {'name': 'john'},
        files: paths.map((e) => FileItem(path: e, field: 'file')).toList(),
        method: UploadMethod.POST,
        tag: tag,
      );
    }
  }
}
//-----------------------------------------------------------------

// ignore_for_file: public_member_api_docs

/// Shows the statusresponses for previous uploads.
class ResponsesScreen extends StatefulWidget {
  ResponsesScreen({
    Key? key,
    required this.uploader,
  }) : super(key: key);

  final FlutterUploader uploader;

  @override
  _ResponsesScreenState createState() => _ResponsesScreenState();
}

class _ResponsesScreenState extends State<ResponsesScreen> {
  StreamSubscription<UploadTaskProgress>? _progressSubscription;
  StreamSubscription<UploadTaskResponse>? _resultSubscription;

  Map<String, UploadItem> _tasks = {};

  @override
  void initState() {
    super.initState();

    _progressSubscription = widget.uploader.progress.listen((progress) {
      final task = _tasks[progress.taskId];
      print(
          'In MAIN APP: ID: ${progress.taskId}, progress: ${progress.progress}');
      if (task == null) return;
      if (task.isCompleted()) return;

      var tmp = <String, UploadItem>{}..addAll(_tasks);
      tmp.putIfAbsent(progress.taskId, () => UploadItem(progress.taskId));
      tmp[progress.taskId] =
          task.copyWith(progress: progress.progress, status: progress.status);
      setState(() => _tasks = tmp);
    }, onError: (ex, stacktrace) {
      print('exception: $ex');
      print('stacktrace: $stacktrace');
    });

    _resultSubscription = widget.uploader.result.listen((result) {
      print(
          'IN MAIN APP: ${result.taskId}, status: ${result.status}, statusCode: ${result.statusCode}, headers: ${result.headers}');

      var tmp = <String, UploadItem>{}..addAll(_tasks);
      tmp.putIfAbsent(result.taskId, () => UploadItem(result.taskId));
      tmp[result.taskId] =
          tmp[result.taskId]!.copyWith(status: result.status, response: result);

      setState(() => _tasks = tmp);
    }, onError: (ex, stacktrace) {
      print('exception: $ex');
      print('stacktrace: $stacktrace');
    });
  }

  @override
  void dispose() {
    super.dispose();
    _progressSubscription?.cancel();
    _resultSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Responses'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.0),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final item = _tasks.values.elementAt(index);
          return UploadItemView(
            item: item,
            onCancel: _cancelUpload,
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.black,
          );
        },
      ),
    );
  }

  Future _cancelUpload(String id) async {
    await widget.uploader.cancel(taskId: id);
  }
}
