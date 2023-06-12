part of 'package:mawa_package/mawa_package.dart';

class AttachBase64File extends StatefulWidget {
  static const String id = 'attach-file';
  AttachBase64File({Key? key, this.afterUpload}) : super(key: key);
  static String? attachmentID;

  Function()? afterUpload;
  @override
  State<AttachBase64File> createState() => _AttachBase64FileState();
}

class _AttachBase64FileState extends State<AttachBase64File> {
  FilePickerResult? result;
  PlatformFile? pickedFile;
  bool isLoading = false;
  Uint8List? uint8list;

  @override
  initState() {
    // Permission.storage.request();
    super.initState();
  }

  pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'png',
          'jpeg',
          'raw',
        ],
        allowMultiple: false,
      );

      if (result != null) {
        pickedFile = result!.files.single;
        uint8list = result!.files.single.bytes;
      } else {
        setState(() {
          isLoading = false;
        });
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pick File To Upload',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: isLoading
                  ? SnapshotWaitingIndicator()
                  : TextButton(
                      onPressed: pickFile, child: const Text('Pick File')),
            ),
            pickedFile != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: 'Picked File:\t${pickedFile!.name}',
                              readOnly: true,
                            ),
                          ),
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                                shape: BoxShape.circle,
                                color: const Color(0xFFF5E4D0),
                              ),
                              width: double.infinity,
                              child: CircleAvatar(
                                child: FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  onPressed: clear,
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      pickedFile!.extension!.toUpperCase() == 'PNG' ||
                              pickedFile!.extension!.toUpperCase() == 'JPEG'
                          ? SizedBox(
                              height: 300.0,
                              width: 400.0,
                              child: Image.memory(uint8list as Uint8List),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextButton(
                        onPressed: upload,
                        child: const Text('Upload'),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  upload() async {
    final OverlayWidgets overlay = OverlayWidgets(context: context);
    FocusScope.of(context).unfocus();
    overlay.showOverlay(SnapShortStaticWidgets.snapshotWaitingIndicator());
    http.Response response = await Attachment.attachBase64(uint8list!);
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic map = await NetworkRequests.decodeJson(response);
      AttachBase64File.attachmentID = map[JsonResponses.id];
      print('Attach64ByteFile.attachmentID ${AttachBase64File.attachmentID}');
      widget.afterUpload!() ?? () {};
      // Navigator.of(context).pop();
    } else {
      Alerts.toastMessage(message: 'Could Not Upload File', positive: false);
    }
    overlay.dismissOverlay();
  }

  void clear() {
    setState(() {
      result = null;
      pickedFile = null;
      isLoading = false;
      uint8list = null;
    });
  }
}
