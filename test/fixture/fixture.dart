import 'dart:io';

class Fixture {
  const Fixture._();

  static String fromPath(String path) {
    return File(path).readAsStringSync();
  }
}
