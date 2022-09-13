import 'package:file_picker/file_picker.dart';
import 'package:mawa_package/screens/alerts.dart';
import 'package:open_file/open_file.dart';
import 'package:mawa_package/mawa_package.dart' as mawa;
import 'package:flutter/material.dart';

class Attachments extends StatefulWidget {

  static const String id = 'Attachments';
  Attachments({Key? key,
    required parentReference,
    required documentType,
    required parentType})
      : super(key: key) {
    reference = parentReference;
    parent = parentType;
    document = documentType;
  }

  static late String reference;
  static late String parent;
  static late String document;

  @override
  _AttachmentsState createState() => _AttachmentsState();
}

class _AttachmentsState extends State<Attachments> {

  FilePickerResult? result;
  PlatformFile? file;
  late String myPath = "";
  late  final _controller = TextEditingController();
  bool lockTouch = false;

  void dispose() {
    // Clean up the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    mawa.Tools.isTouchLocked = false;
    super.initState();
  }


  // @override
  // Widget build(BuildContext context) {
  //   _controller.text = myPath;
  //   return MaterialApp(
  //     title: 'Choose file to upload',
  //     home: Scaffold(
  //         body: Container(
  //           padding: const EdgeInsets.all(10.0),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               const Align(
  //                 alignment: Alignment.topLeft,
  //                 child: Text("Choose File To Upload", style: TextStyle(fontSize: 20,),),
  //               ),
  //               const Divider(
  //                 color: Colors.grey,
  //               ),
  //               const SizedBox(height: 20,),
  //               Row(
  //                 //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   Flexible(
  //                     child: TextFormField(
  //                       controller: _controller,
  //                       decoration: const InputDecoration(
  //                         hintText: 'file to upload',
  //                         contentPadding: EdgeInsets.all(10),
  //                         isDense: true,
  //                         enabled: false,
  //                         border: OutlineInputBorder(
  //                             borderSide: BorderSide(color: Colors.grey)),
  //                       ),
  //                       style: const TextStyle(fontStyle: FontStyle.italic,),
  //                       //     overflow: TextOverflow.clip),
  //                     ),
  //                   ),
  //                   //Flexible(
  //                   const SizedBox(
  //                     width: 5,
  //                   ),
  //                   SizedBox(
  //                     height: 40,
  //                     child: ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                           primary: Colors.white,
  //                           side: const BorderSide(color: Colors.grey,
  //                           )),
  //                       onPressed: () {
  //                         _selectAttachment();
  //                         setState(() {});
  //                       }, child: const Text("Browse...", style: TextStyle(color: Colors.blue),),
  //                     ),
  //                   ),
  //
  //                   // )
  //                 ],
  //               ),
  //               const SizedBox(height: 20,),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   const SizedBox(
  //                     width:10,
  //                   ),
  //
  //                   if (file != null)//view button will only appear if file has value
  //                     ElevatedButton.icon(
  //
  //                       style: ElevatedButton.styleFrom(primary: Colors.green, ),
  //                       onPressed: (){
  //                         _viewFile(file!);
  //                       },
  //                       label: const Text('View'),
  //                       icon: const Icon(Icons.remove_red_eye_outlined),
  //                     ),
  //                   const SizedBox(
  //                     width:10,
  //                   ),
  //                   if (file != null)//view button will only appear if file has value
  //                     ElevatedButton.icon(
  //                       style: ElevatedButton.styleFrom(primary: Colors.blue),
  //                       onPressed: () async {
  //                         dynamic resp = await mawa.Attachments().uploadAttachment(file,
  //                             documentType: LeaveAttachment.document,
  //                             parentType: LeaveAttachment.parent,
  //                             parentReference: LeaveAttachment.reference);
  //
  //                         //code to upload file
  //                         Alerts.flushbar(context: context, message: resp.statusMessage);
  //                         if(NetworkRequests.statusCode == 200)
  //                         {
  //                           _controller.clear();
  //                         }
  //
  //                       },  label: const Text("Upload File"), //label text
  //                       icon: const Icon(Icons.upload_rounded),
  //
  //
  //
  //                     ),
  //                 ],
  //               ),
  //               const SizedBox(height: 50,),
  //               const Divider(
  //                 color: Colors.grey,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   ElevatedButton.icon(
  //
  //                     style: ElevatedButton.styleFrom(
  //                         primary: Colors.white,
  //                         side: const BorderSide(color: Colors.red,
  //                         )),
  //                     onPressed: () {
  //                       // mawa.Tools.previousContext;
  //                      // Navigator.pop(mawa.Tools.context,true);
  //                       // Navigator.of(mawa.Tools.context).pop(true);
  //                       Navigator.of(mawa.Tools.context).pop();
  //                     },
  //                     label: const Text("Back",style: TextStyle(color: Colors.red)),
  //                     icon: const Icon(Icons.arrow_back_outlined, color: Colors.red,),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         )
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    _controller.text = myPath;
    return SafeArea(
      child: AbsorbPointer(
        absorbing:lockTouch,
        child: MaterialApp(
          title: 'Choose file to upload',
          home: Scaffold(
              body: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Choose File To Upload", style: TextStyle(fontSize: 20,),),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'file to upload',
                              contentPadding: EdgeInsets.all(10),
                              isDense: true,
                              enabled: false,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                            style: const TextStyle(fontStyle: FontStyle.italic,),
                            //     overflow: TextOverflow.clip),
                          ),
                        ),
                        //Flexible(
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                side: const BorderSide(color: Colors.grey,
                                )),
                            onPressed: () {
                              _selectAttachment();
                              setState(() {});
                            }, child: const Text("Browse...", style: TextStyle(color: Colors.blue),),
                          ),
                        ),

                        // )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          width:10,
                        ),

                        if (file != null)//view button will only appear if file has value
                          ElevatedButton.icon(

                            style: ElevatedButton.styleFrom(primary: Colors.green, ),
                            onPressed: (){
                              _viewFile(file!);
                            },
                            label: const Text('View'),
                            icon: const Icon(Icons.remove_red_eye_outlined),
                          ),
                        const SizedBox(
                          width:10,
                        ),
                        if (file != null)//view button will only appear if file has value
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(primary: Colors.blue),
                            onPressed: () async {

                              dynamic resp = await mawa.Attachments().uploadAttachment(file,
                                  documentType: Attachments.document,
                                  parentType: Attachments.parent,
                                  parentReference: Attachments.reference);
                              Alerts.flushbar(context: context, message: resp.statusMessage);

                              if (mawa.NetworkRequests.statusCode == 200) {
                                _controller.clear();
                              }
                            },  label: const Text("Upload File"), //label text
                            icon: const Icon(Icons.upload_rounded),
                          ),
                      ],
                    ),
                    const SizedBox(height: 50,),
                    const Divider(
                      color: Colors.grey,
                    ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(

                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              side: const BorderSide(color: Colors.red,
                              )),
                          onPressed: () {
                              Navigator.of(mawa.Tools.context).pop();
                          },
                          label: const Text("Back",style: TextStyle(color: Colors.red)),
                          icon: const Icon(Icons.arrow_back_outlined, color: Colors.red,),
                        ),
                      ],
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

  void _selectAttachment() async {
    result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null) return;
    setState(() {
      file = result!.files.first;
      myPath = file!.name;
    });
  }
  void _viewFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

}