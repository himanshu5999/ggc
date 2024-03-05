import 'dart:typed_data';

import 'package:ggc/fileManager.dart';

class StringStorage {
  late FileManager fileManager;

  StringStorage(String f) {
    fileManager = new FileManager(f);
  }

  Future<DateTime?> getLastModified() async {
    return fileManager.getLastModified();
  }

  Future<String> getFilePath() async {
    return await fileManager.filePath();
  }

  String getFilePathSync() {
    return fileManager.filePathSync();
  }

  Future<String> readFile() async {
    return fileManager.readAsString();
  }

  Future<void> writeFile(String data) async {
    await fileManager.writeAsString(data);
  }

  void writeFileSync(String data) {
    fileManager.writeAsStringSync(data);
  }

  bool fileExists() {
    return fileManager.fileExists();
  }

  Future<bool> deleteFile() async {
    return fileManager.deleteFile();
  }
}

class ProtoBufStorage {
  late FileManager fileManager;
  ProtoBufStorage(String f) {
    fileManager = new FileManager(f);
  }

  Future<DateTime?> getLastModified() async {
    return fileManager.getLastModified();
  }

  Future<Uint8List?> readFile() async {
    return fileManager.readAsBytes();
  }

  Future<void> writeFile(List<int> data) async {
    await fileManager.writeAsBytes(data);
  }

  bool fileExists() {
    return fileManager.fileExists();
  }
}
