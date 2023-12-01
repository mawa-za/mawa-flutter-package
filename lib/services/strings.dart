part of 'package:mawa_package/mawa_package.dart';

class Strings{

  static String keyToDescription(text) {
    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    text = '${text[0].toUpperCase()}${text.substring(1)}';
    String result =
    text.replaceAllMapped(exp, (Match m) => (' ${m.group(0)!}'));
    return result;
  }

  static String description(text) {
    String result  = '';
    int index = text.indexOf(' ');
    if(text.length > 1){
      if (index > 1) {
        while (index > 1) {
          result +=
          ' ${text[0].toUpperCase()}${text.substring(1, index).toLowerCase()}';
          text = text.substring(index + 1);
          index = text.indexOf(' ');
          if (text.length > 0 && index < 0) {
            result +=
            ' ${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
          }
        }
      } else {
        result = '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
      }
    }
    else{
      result = text;
    }
    return result.trim();
  }

  static camelCaseToDescription(entries){
    Map entry = {};
    for (int h = 0; h < entries.length; h++) {
      if (kDebugMode) {
        print('${entries.entries.elementAt(h).value.runtimeType}');
        print('${entries.entries.elementAt(h).value.runtimeType == String}');
      }
      if (entries.entries.elementAt(h).value.runtimeType == String) {
        String key =
        // '${entries.entries.elementAt(h).key}';
        keyToDescription('${entries.entries.elementAt(h).key}');
        String value = '${entries.entries.elementAt(h).value}';
        if (kDebugMode) {
          print('$key : $value');
        }
        entry[key] = value;
      }
    }
  }

  static String personNameFromJson(json) {
    if (json != null) {
      try{
        Map title = Map.from(json[JsonResponses.title] ?? {});
        String name =
            '${title.isNotEmpty ? title[JsonResponses.description] ?? '' : ''} ${json[JsonResponses.personLastName] ?? json[JsonResponses.name1] ?? json[JsonResponses.surname] ?? ''}, ${json[JsonResponses.personFirstName] ??json[JsonResponses.name2] ?? ''} ${json[JsonResponses.personMiddleName] ??json[JsonResponses.name3] ?? ''}';
        return name == ' ,  ' ? '' : name;
      }catch(e){
        if (kDebugMode) {
          print(e);
        }
        return 'Error Deciphering Name';
      }
    } else {
      return '';
    }
  }

}