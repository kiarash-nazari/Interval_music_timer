// ignore: file_names
import 'package:get/get.dart';

class ModelOfMusic {
  ModelOfMusic(
      {this.audio,
      this.id,
      this.image,
      required this.percent,
      required this.path, required this.exists});
  String? audio;
  String? image;
  String? id;
  var percent = 0.0.obs;
  String? path;
  var exists = false.obs;
}
