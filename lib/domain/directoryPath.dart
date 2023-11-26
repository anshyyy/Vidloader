import 'dart:io';

class DirectoryPath {
  getPath() async {
    final path = Directory(
        '/storage/emulated/0/Vidloader/media/com.example.download_any_files/files');
    if (await path.exists()) {
      return path.path;
    } else {
      path.create();
      return path.path;
    }
  }
}
