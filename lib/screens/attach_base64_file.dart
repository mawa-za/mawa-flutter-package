part of 'package:mawa_package/mawa_package.dart';

class AttachBase64File {
  // static const String id = 'attach-file';
  AttachBase64File({
    Key? key,
    required this.type,
    required this.id,
    required this.context,
    required this.postCreate,
  }) {
    docTypes = [];
    docType = {};
    overlay = OverlayWidgets(
      context: context,
    );
    build();
  }
  final Function postCreate;
  late String attachmentID;
  final String type;
  final String id;
  final BuildContext context;
  late Map<String, dynamic> docType;
  late List<Map<String, dynamic>> docTypes;
  FilePickerResult? result;
  PlatformFile? pickedFile;
  bool isLoading = false;
  bool isFilePicked = false;
  Uint8List? uint8list;
  late final OverlayWidgets overlay;
  final _formKey = GlobalKey<FormState>();

  future() async {
    if (docTypes.isEmpty) {
      docTypes = List<Map<String, dynamic>>.from(
        await Field(
          FieldOptionTypes.documentType,
        ).getOptions(),
      );
    }
    return true;
  }

  pickFile(setState) async {
    try {
      overlay.showOverlay(
        SnapShortStaticWidgets.snapshotWaitingIndicator(),
      );
      isLoading = true;
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
        setState(() {
          pickedFile = result!.files.single;
          uint8list = result!.files.single.bytes;
          isFilePicked = true;
        });
      } else {
        // setState(() {
        isLoading = false;
        // });
      }
      // setState(() {
      isLoading = false;
      // });
      overlay.dismissOverlay();
    } catch (e) {
      // setState(() {
      isLoading = false;
      // });
      if (kDebugMode) {
        print(e);
      }
    }
  }

  build() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (
            context,
            setState,
          ) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.start,
              title: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 27.0,
                    ),
                    child: Text(
                      'File Upload',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              content: Container(
                width: 600.0,
                height: 350.0,
                margin: const EdgeInsets.only(
                  left: 20.00,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 0.0,
                ),
                child: FutureBuilder(
                  future: future(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    Widget widget;
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        widget = Padding(
                          padding: const EdgeInsets.all(
                            10.0,
                          ),
                          child: form(setState),
                        );
                      } else {
                        widget = SnapShortStaticWidgets.futureNoData(
                          displayMessage:
                              'Could Not Retrieve Relevant info For Creating ${Strings.description(type)}',
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      widget =
                          SnapShortStaticWidgets.snapshotWaitingIndicator();
                    } else if (snapshot.hasError) {
                      widget = SnapShortStaticWidgets.snapshotError();
                    } else {
                      widget = SnapShortStaticWidgets.futureNoData(
                        displayMessage: 'No data',
                      );
                    }

                    return widget;
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget form(setState) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: DropdownSearch<Map<String, dynamic>>(
                selectedItem: docType,
                validator: (value) {
                  if (value == null || docType.isEmpty) {
                    return 'Please Select Document type';
                  }
                  return null;
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: 'Document type',
                    hintText: 'Select Document type',
                    prefixIcon: docType.isEmpty
                        ? const Icon(
                            Icons.new_label,
                          )
                        : const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.new_label,
                            ),
                          ),
                    contentPadding: const EdgeInsets.fromLTRB(
                      0,
                      0,
                      0,
                      0,
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                dropdownBuilder: (
                  BuildContext context,
                  Map<String, dynamic>? item,
                ) {
                  return Container(
                    padding: const EdgeInsets.all(
                      1.0,
                    ),
                    child: (item == null || docType.isEmpty)
                        ? const ListTile(
                            contentPadding: EdgeInsets.all(
                              1.0,
                            ),
                            title: Text(
                              'Select Document Type',
                            ),
                          )
                        : ListTile(
                            contentPadding: const EdgeInsets.all(
                              1.0,
                            ),
                            title: Text(
                              item[JsonResponses.description] ?? '',
                            ),
                            subtitle: Text(
                              '${item[JsonResponses.code] ?? ''}',
                            ),
                          ),
                  );
                },
                popupProps: PopupProps.dialog(
                  showSearchBox: true,
                  itemBuilder: (
                    BuildContext context,
                    Map<String, dynamic> item,
                    bool isSelected,
                  ) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      decoration: !isSelected
                          ? null
                          : BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(
                                5.0,
                              ),
                              color: Colors.white,
                            ),
                      child: ListTile(
                        selected: isSelected,
                        title: Text(
                          item[JsonResponses.description] ?? '',
                        ),
                        subtitle: Text(
                          '${item[JsonResponses.code] ?? ''}',
                        ),
                      ),
                    );
                  },
                  emptyBuilder: (context, string) {
                    return const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'No Such Record Found',
                          ),
                        ],
                      ),
                    );
                  },
                  loadingBuilder: (context, string) {
                    return Center(
                      child: SnapShortStaticWidgets.snapshotWaitin(),
                    );
                  },
                  errorBuilder: (context, string, dynamic) {
                    return Center(
                      child: SnapShortStaticWidgets.snapshotError(),
                    );
                  },
                  searchFieldProps: const TextFieldProps(autofocus: true),
                ),
                asyncItems: (find) async {
                  future();
                  List<Map<String, dynamic>> list = [];
                  if (find.isEmpty) {
                    list = docTypes;
                  } else {
                    for (int c = 0; c < docTypes.length; c++) {
                      if ('${docTypes[c][JsonResponses.description] ?? ''} ${docTypes[c][JsonResponses.code] ?? ''}'
                          .contains(find)) {
                        list.add(docTypes[c]);
                      }
                    }
                  }
                  return list;
                },
                onChanged: (data) {
                  docType = Map<String, dynamic>.from(data!);
                },
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Visibility(
              visible: !isFilePicked,
              child: TextButton(
                onPressed: () {
                  pickFile(setState);
                  setState(() {});
                },
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
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              initialValue: pickedFile!.name,
                              readOnly: true,
                              decoration: Tools.textInputDecorations(
                                  'File Name', Icons.abc),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {
                                pickFile(setState);
                                setState(() {});
                              },
                              child: const Text(
                                'Pick Different File',
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      // pickedFile!.extension!.toUpperCase() == 'PNG' ||
                      //         pickedFile!.extension!.toUpperCase() == 'JPEG'
                      //     ? SizedBox(
                      //         height: 300.0,
                      //         width: 400.0,
                      //         child: Image.memory(uint8list as Uint8List),
                      //       )
                      //     : Container(),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: upload,
        icon: const Icon(
          Icons.save_as,
        ),
        label: const Text(
          'Upload',
        ),
        tooltip: 'Upload Attachment',
        heroTag: 'upload att',
      ),
    );
  }

  upload() async {
    if (_formKey.currentState!.validate()) {
      if (isFilePicked) {
        FocusScope.of(context).unfocus();
        overlay.showOverlay(
          SnapShortStaticWidgets.snapshotWaitingIndicator(),
        );
        dynamic response = await Attachment.create(
          uint8list!,
          objectId: id,
          objectType: type,
          documentType: docType[JsonResponses.code],
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> map =
              Map<String, dynamic>.from(await NetworkRequests.decodeJson(
            response,
            negativeResponse: {},
          ));
          attachmentID = map[JsonResponses.id] ?? '';
          dismiss();
          Alerts.toastMessage(
            message: 'File Upload Successful',
            positive: true,
          );
          postCreate();
        } else {
          Alerts.toastMessage(
            message: 'Could Not Upload File',
            positive: false,
          );
        }
        overlay.dismissOverlay();
      } else {
        Alerts.toastMessage(
          message: 'Please Pick File',
          positive: false,
        );
      }
    }
  }

  void clear() {
    result = null;
    pickedFile = null;
    isLoading = false;
    uint8list = null;
  }

  dismiss() {
    Navigator.of(context).pop();
  }
}
