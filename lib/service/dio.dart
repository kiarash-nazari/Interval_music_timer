import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sport_timer/controller/Timer/active_timer_controller.dart';

class FileDownloader {
  FileDownloader(this.downloadProgress);
  var downloadProgress = 1;
  ActiveTimerController activeTimerController =
      Get.put(ActiveTimerController());
  Future<String> downloadFile(String url, String fileName) async {
    // Request permission to access external storage
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      throw Exception('Permission to access external storage denied');
    }

    // Get the directory for storing the downloaded file
    var directory = await getApplicationDocumentsDirectory();

    // Create a new Dio instance for downloading the file
    var dio = Dio();

    // Set the download path for the file
    var filePath = '${directory.path}/$fileName';

    // Download the file and save it to the specified path
    try {
      await dio.download(
        url,
        filePath,
        onReceiveProgress: (count, total) {
          // print("INJAHAST COUNT:${count / total}");
          activeTimerController.musicsList[downloadProgress - 1].percent.value =
              (count / total);
          // print(activeTimerController
          //     .musicsList[activeTimerController.idChecker.value - 1].id);
          // print(filePath);
          // print("INJAHAST Total:$total");
        },
      );
    } catch (e) {
      throw Exception('Failed to download file: $e');
    }

    return filePath;
  }
}
