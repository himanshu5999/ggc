import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'util.dart';

class FileManager {
  String fileName = "";

  FileManager(String f) {
    fileName = f;
    if (!f.contains("/")) {
      fileName = "/flutter-$fileName";
    }
  }

  Future<DateTime?> getLastModified() async {
    DateTime? lastModified;
    try {
      final file = await _localFile;
      lastModified = await file.lastModified();
    } catch (e) {}
    return lastModified;
  }

  Future<String> get _localPath async {
    final directory = await Util.getFlutterDocumentDir();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path$fileName');
  }

  File get _localFileSync {
    final path = Util.flutterDocumentDir!.path;
    return File('$path$fileName');
  }

  Future<String> filePath() async {
    final path = await _localPath;
    return '$path$fileName';
  }

  String filePathSync() {
    final path = Util.flutterDocumentDir!.path;
    return '$path$fileName';
  }

  Future<String> readAsString() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // print("Exception when reading file:" + e.toString());
      return "";
    }
  }

  Future<Uint8List?> readAsBytes() async {
    try {
      final file = await _localFile;

      // Read the file
      Uint8List contents = await file.readAsBytes();

      return contents;
    } catch (e) {
      // print("Exception when reading file:" + e.toString());
      return null;
    }
  }

  Future<File> writeAsString(String data) async {
    final file = await _localFile;

    // Write the file
    return await file.writeAsString(data);
  }

  void writeAsStringSync(String data) {
    final file = _localFileSync;

    // Write the file
    return file.writeAsStringSync(data);
  }

  Future<File> writeAsBytes(List<int> data) async {
    final file = await _localFile;

    // Write the file
    return await file.writeAsBytes(data);
  }

  Future<bool> deleteFile() async {
    try {
      final file = await _localFile;

      // Delete the file
      await file.delete();

      return true;
    } catch (e) {
      // print("Exception when deleting file:" + e.toString());
      return false;
    }
  }

  bool fileExists() {
    try {
      final file = _localFileSync;

      // Check if file exists
      bool exists = file.existsSync();
      return exists;
    } catch (e) {
      return false;
    }
  }
}
