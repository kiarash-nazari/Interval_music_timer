import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class GymController extends GetxController {
  final playerStartGym = AudioPlayer();
  late Timer starttimerMusicAfterSet;
  late Timer starttimerMusicCircul;

  late Timer timerAfterSet;
  late Timer timerCircule;

  //mute and unmute alarm
  var unmute = true.obs;

  //avoid dublle tap on play button
  var afterSetIconPlay = true.obs;
  var circuleIconPlay = true.obs;

  // to avoid run the music timers
  var aviodRunMusicAfter = true.obs;
  var aviodRunMusicCircule = true.obs;

  // after set varibles
  var percentAfterSet = 0.0.obs;
  var timeOnCenterAfterRest = 0.0.obs;
  var afterRestMillisecond = 10.0.obs;

  // circule set varibles
  var percentCircule = 0.0.obs;
  var timeOnCenterCircule = 0.0.obs;
  var circuleMillisecond = 10.0.obs;

  @override
  onInit() {
    getAudioStartGym();
    super.onInit();
  }

  startAfterSetTimer() {
    if (aviodRunMusicAfter.value) {
      startMusicAfterSetFunc();
      aviodRunMusicAfter.value = false;
    }

    timerAfterSet = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      timeOnCenterAfterRest.value += 0.001;
      percentAfterSet.value += 1 / afterRestMillisecond.value;

      if (percentAfterSet.value >= 1) {
        percentAfterSet.value = 0;
        timeOnCenterAfterRest.value = 0;
        timerAfterSet.cancel();
        afterSetIconPlay.value = true;
      }
    });
  }

  startCirculeTimer() {
    if (aviodRunMusicCircule.value) {
      startMusicCirculFunc();
      aviodRunMusicCircule.value = false;
    }

    timerCircule = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      timeOnCenterCircule.value += 0.001;
      percentCircule.value += 1 / circuleMillisecond.value;

      if (percentCircule.value >= 1) {
        percentCircule.value = 0;
        timeOnCenterCircule.value = 0;
        timerCircule.cancel();
        circuleIconPlay.value = true;
      }
    });
  }

  getAudioStartGym() async {
    await playerStartGym.setAsset("assets/audio/Start.wav");
  }

  Timer startMusicAfterSetFunc() {
    return starttimerMusicAfterSet =
        Timer.periodic(const Duration(milliseconds: 500), (_) {
      if ((afterRestMillisecond.value.round()) -
              ((percentAfterSet.value) * afterRestMillisecond.value).round() <
          5) {
        getAudioStartGym();

        playerStartGym.play();
        aviodRunMusicAfter.value = true;

        starttimerMusicAfterSet.cancel();
      }
    });
  }

  Timer startMusicCirculFunc() {
    return starttimerMusicCircul =
        Timer.periodic(const Duration(milliseconds: 500), (_) {
      if ((circuleMillisecond.value.round()) -
              ((percentCircule.value) * circuleMillisecond.value).round() <
          5) {
        getAudioStartGym();

        playerStartGym.play();
        aviodRunMusicCircule.value = true;

        starttimerMusicCircul.cancel();
      }
    });
  }
}
