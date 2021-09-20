part of mawa;

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

  static Future<bool> promptExit(BuildContext c)  async {

    bool? canExit;

    dynamic dlg =

    AwesomeDialog(
      context: c,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Warning!',
      desc: 'Are You Sure You Want To Exit?',
      btnOk: TextButton(
        child: const Text('Yes'),
        onPressed: () {
          canExit = true;
          Navigator.pop(c, canExit!);
        },
      ),
      btnCancel:TextButton(
        child: const Text('No'),
        onPressed: () {
          canExit = false;
          Navigator.pop(c, canExit!);
        },
      ),

    );

    await dlg.show();
    return Future.value(canExit!);
  }

}