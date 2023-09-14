part of 'package:mawa_package/mawa_package.dart';

class AttachBase64File extends StatefulWidget {
  static const String id = 'attach-file';
  AttachBase64File({
    Key? key,
    this.afterUpload,
    required this.transactionID,
    required this.partnerID,
  }) : super(key: key);
  late String attachmentID;
  final String transactionID;
  final String partnerID;

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
    print('transaction ${widget.transactionID}');
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
      if (kDebugMode) {
        print(e);
      }
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
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 100.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: isLoading
                  ? SnapshotWaitingIndicator()
                  : TextButton(
                      onPressed: pickFile,
                      child: const Text(
                        'Pick File',
                      ),
                    ),
            ),
            pickedFile != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Spacer(),
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
                                    width: 3.0,
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
    final OverlayWidgets overlay = OverlayWidgets(
      context: context,
    );
    FocusScope.of(context).unfocus();
    overlay.showOverlay(
      SnapShortStaticWidgets.snapshotWaitingIndicator(),
    );
    // print(base64.encode(uint8list!));
    dynamic response = await Attachment.attachBase64(uint8list!);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic map = await NetworkRequests.decodeJson(response);
      widget.attachmentID = map[JsonResponses.id];
      print('Attach64ByteFile.attachmentID ${widget.attachmentID}');
      await Attachment(widget.attachmentID).transactionLink(
        transaction: widget.transactionID,
        fileType: pickedFile!.extension ?? '',
      );
      await Attachment(widget.attachmentID).partnerLink(
        partner: widget.partnerID,
        fileType: pickedFile!.extension ?? '',
      );
      widget.afterUpload!() ?? () {};
      dismiss();
    } else {
      Alerts.toastMessage(
        message: 'Could Not Upload File',
        positive: false,
      );
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

  dismiss() {
    Navigator.of(context).pop();
  }
}
