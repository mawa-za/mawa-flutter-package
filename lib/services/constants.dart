part of 'package:mawa_package/mawa_package.dart';

class Constants {

  static const String notFound = 'Not Found';
  static const String notSupplied = 'Not Supplied';

  static  const TextStyle subtitleStyle =
  TextStyle(fontSize: 10.0, color: Colors.grey);

  static final List<dynamic> list = [];

  static textInputDecorations(String textLabel, icon, {String? hint, String? helperTxt}) {
    return InputDecoration(
        helperText: helperTxt ?? '',
        icon: Icon(icon),
        labelText: textLabel,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ));
  }

  static DialogButton dialogCloseButton({required BuildContext context,String? text}) {
    return DialogButton(
      child: Text(text ?? 'Cancel'),
      onPressed: () => Navigator.of(context).pop(),
      color: Colors.red,
    );
  }

  static   promptExit(BuildContext context)  async {

    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Warning!',
      desc: 'Are You Sure You Want To Exit?',
      btnOk: TextButton(
        child: const Text('Yes'),
        onPressed: () {
          exit(0);
        },
      ),
      btnCancel:TextButton(
        child: const Text('No'),
        onPressed: () {
          Navigator.pop(context );
        },
      ),

    ).show();
  }


}