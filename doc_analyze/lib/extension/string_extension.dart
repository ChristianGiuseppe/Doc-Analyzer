import 'dart:io';

extension FileExtension on FileSystemEntity{
  String? get fileName {
    return path.split("/").last;
  }
}