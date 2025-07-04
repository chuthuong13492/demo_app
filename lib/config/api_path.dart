import 'package:demo_app/core/extensions/extensions.dart';

class ApiPath {
  ApiPath._();

  static String weather() => 'b9607fd2-bd7a-484e-917f-a5e641ec6cc9'.format;

  static String images() => 'a5d4cf16-1f36-4f2b-b5cd-89772a83e999'.format;
}

extension _FormatPathExt on String {
  String get format {
    String url = this;
    url = url.removeAllWhiteSpace();
    url = url.replaceAll("/''/", '/');
    url = url.replaceAll('//', '/');
    return url;
  }
}
