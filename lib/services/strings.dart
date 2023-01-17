part of 'package:mawa_package/mawa_package.dart';

class Strings{

  static String keysToDescriptions(text) {
    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    text = '${text[0].toUpperCase()}${text.substring(1)}';
    String result =
    text.replaceAllMapped(exp, (Match m) => (' ${m.group(0)!}'));
    return result;
  }

  static camelCaseToDescription(entries){
    Map entry = {};
    for (int h = 0; h < entries.length; h++) {
      print('${entries.entries.elementAt(h).value.runtimeType}');
      print('${entries.entries.elementAt(h).value.runtimeType == String}');
      if (entries.entries.elementAt(h).value.runtimeType == String) {
        String key =
            '${entries.entries.elementAt(h).key}'; //keysToDescriptions('${data.entries.elementAt(h).key}');
        String value = '${entries.entries.elementAt(h).value}';
        print('$key : $value');
        entry[key] = value;
      }
    }
  }

  static String personNameFromJson(json){
    if(json != null){
      return
        '${json[JsonResponses
            .personLastName] ?? ''}, ${json[JsonResponses
            .personFirstName] ?? ''} ${json[JsonResponses.personMiddleName] ??
            ''}';
    }
    else{
      return '';
    }
  }

}