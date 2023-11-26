import 'package:permission_handler/permission_handler.dart';

class CheckPermission {
  isStoragePermission() async {
    var isStorage = await Permission.storage.status;
    var isAccesLc = await Permission.accessMediaLocation.status;
    var isManageExt = await Permission.manageExternalStorage.status;

    if (!isManageExt.isGranted ||
        !isStorage.isGranted ||
        !isAccesLc.isGranted) {
      await Permission.storage.request();
      await Permission.accessMediaLocation.request();
      await Permission.manageExternalStorage.request();
      if (!isManageExt.isGranted ||
          !isStorage.isGranted ||
          !isAccesLc.isGranted) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
