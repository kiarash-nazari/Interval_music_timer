import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:sport_timer/controller/Timer/active_timer_controller.dart';
import 'package:just_audio/just_audio.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sport_timer/service/dio.dart';

import '../../components/Decorations.dart';
import '../../controller/NavigationBar/NavigationBarController.dart';

class IntervallScreen extends StatelessWidget {
  IntervallScreen({super.key});

  ActiveTimerController activeTimerController =
      Get.put(ActiveTimerController(), permanent: true);
  NavigationBarController navigationBarController =
      Get.put(NavigationBarController());

  final player1 = AudioPlayer();
  final activeInputController = TextEditingController();
  final restInputController = TextEditingController();
  final loopInputController = TextEditingController();
  // var pageIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(20, 245, 0, 86),
      body: SafeArea(
          child: Center(
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                firstIconShowRepsCount(),
                //Row of circular percent indecators
                rowOfTowPercentIndecators(),
                const SizedBox(
                  height: 15,
                ),
                //Row of Active and rest input
                rowOfFirstAndSeconInputs(),
                const SizedBox(
                  height: 5,
                ),
                //loop input
                thirdInput(),
                const SizedBox(
                  height: 10,
                ),
                //Row of play and pause buttom
                playAndPauseContainer(),

                //Slider
                slider(),
              ],
            ),
          ),
        ),
      )),
    );
  }

  SizedBox slider() {
    return SizedBox(
      height: 210,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 185.0,
          viewportFraction: 0.6,
          initialPage: 0,
          enlargeCenterPage: true,
          enlargeFactor: 0.4,
        ),
        items: activeTimerController.musicsList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  activeTimerController.idChecker.value = int.parse(i.id!);
                  activeTimerController.backgroundPhoto.value = i.image!;
                  if (activeTimerController.mainMusic.value == i.audio) {
                    if (activeTimerController.mixPlayerVolume.value) {
                      activeTimerController.playerMix.setVolume(0.0);
                      activeTimerController.mixPlayerVolume.value = false;
                    } else {
                      activeTimerController.playerMix.setVolume(1.0);
                      activeTimerController.mixPlayerVolume.value = true;
                    }
                  } else {
                    activeTimerController.mainMusic.value = i.audio!;
                    activeTimerController.getMixMusic();
                    activeTimerController.playerMix.setVolume(1.0);
                    activeTimerController.mixPlayerVolume.value = true;
                  }
                  if (activeTimerController.playerMix.playing) {
                  } else {
                    activeTimerController.getMixMusic();
                    activeTimerController.mixPlayerVolume.value = true;
                  }
                },
                child: Container(
                  width: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                      image: AssetImage(i.image!),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(127, 188, 186, 186),
                        blurRadius: 30.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          10.0, // Move to right 10  horizontally
                          25.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  child: Obx(
                    () => Stack(
                      children: [
                        CircularPercentIndicator(
                            linearGradient: const LinearGradient(
                                colors: [
                                  Color(0xFF3366FF),
                                  Color(0xFF00CCFF),
                                ],
                                begin: FractionalOffset(0.0, 0.0),
                                end: FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            radius: Get.width / 15,
                            backgroundColor: Colors.grey.shade700,
                            lineWidth: 5,
                            circularStrokeCap: CircularStrokeCap.round,
                            percent: activeTimerController
                                .musicsList[int.parse(i.id!) - 1].percent.value,
                            center: Icon(
                              i.exists.value == false
                                  ? Icons.download
                                  : Icons.play_arrow,
                              color: Colors.amber,
                            )),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Container playAndPauseContainer() {
    return Container(
      width: Get.width - 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
              image: AssetImage(activeTimerController.backgroundPhoto.value),
              opacity: 0.9,
              fit: BoxFit.cover)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 25,
                    spreadRadius: -5)
              ],
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white60, Colors.white10]),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  child: Icon(activeTimerController.mixPlayerVolume.value
                      ? Icons.volume_up
                      : Icons.volume_off),
                  onTap: () {
                    if (activeTimerController.mixPlayerVolume.value) {
                      activeTimerController.playerMix.setVolume(0.0);
                      activeTimerController.mixPlayerVolume.value = false;
                    } else {
                      activeTimerController.playerMix.setVolume(1.0);
                      activeTimerController.mixPlayerVolume.value = true;
                    }
                  },
                ),
                // const Expanded(child: SizedBox()),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (activeTimerController.handlePlayButton.value) {
                            activeTimerController.getAudioStart();
                            Future.delayed(const Duration(milliseconds: 3000),
                                () {
                              try {
                                ///load inputs
                                activeTimerController.activMillisecond.value =
                                    double.parse(activeInputController.text);
                                activeTimerController.restMillisecond.value =
                                    double.parse(restInputController.text);
                                activeTimerController.loop.value =
                                    int.parse(loopInputController.text);

                                ///call timers and music
                                activeTimerController.startActivitiTimer();
                                if (activeTimerController.playerMix.playing) {
                                } else {
                                  activeTimerController.getMixMusic();
                                  activeTimerController.mixPlayerVolume.value =
                                      true;
                                }

                                if (activeTimerController.playEndMusic.value) {
                                  activeTimerController.endMusicFunc();

                                  activeTimerController.playEndMusic.value =
                                      false;
                                  activeTimerController.handlePlayButton.value =
                                      false;
                                }
                              } on Exception catch (e) {
                                // print("fill the form $e");
                              }
                            });
                          }

                          ///empty Loop Screen
                          activeTimerController.loopOnScreen.value = 0;
                        },
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          size: 90,
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          activeTimerController.playerMix.stop();
                          activeTimerController.mixPlayerVolume.value = false;

                          // For clear all text inputs and reset all timers
                          activeTimerController.percent.value = 0.0;
                          activeTimerController.percentRest.value = 0.0;
                          activeTimerController.timeOnCenter.value = 0;
                          activeTimerController.timeOnCenterRest.value = 0;
                          //inputs
                          activeInputController.text = "";
                          restInputController.text = "";
                          loopInputController.text = "";

                          activeTimerController.handlePlayButton.value = true;
                          // activeTimerController.mainMusic.value =
                          //     "";
                          // activeTimerController
                          //     .backgroundPhoto.value = "";

                          if (activeTimerController.playEndMusic.value ==
                              false) {
                            // stop musics and cancel timers
                            activeTimerController.playEndMusic.value = true;
                            activeTimerController.playerStart.stop();
                            activeTimerController.player1.stop();
                            activeTimerController.timerActive.cancel();
                            activeTimerController.timerRest.cancel();
                            activeTimerController.starttimerMusic.cancel();
                            activeTimerController.timerMusic.cancel();
                          }
                          navigationBarController.pageIndex.value = 2;
                        },
                        child: const Icon(
                          Icons.stop,
                          size: 90,
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ),
                // const Expanded(child: SizedBox())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding thirdInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          SizedBox(
            width: Get.width / 3,
            child: TextField(
              style: const TextStyle(color: Color(0xFF00CCFF)),
              controller: loopInputController,
              keyboardType: TextInputType.number,
              onSubmitted: (String rest) {
                activeTimerController.loop.value = int.parse(rest);
              },
              decoration: MyDecoration().inputDecorations(
                radius: 30,
                enabledBorderColor: Colors.grey,
                focusedBorderColor: const Color(0xFF00CCFF),
                helperText: "How many reps",
                helperTextColor: Colors.white,
                lableText: "-> Loop",
                lableTextColor: const Color(0xFF00CCFF),
                prefixIcon: MdiIcons.autorenew,
                prefixIconColor: const Color(0xFF00CCFF),
                suffixText: "rep",
                suffixTextColor: const Color.fromARGB(200, 255, 255, 255),
                hintText: 'loop',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row rowOfFirstAndSeconInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                width: Get.width / 3,
                child: TextField(
                  style: const TextStyle(color: Color(0xFFDA1F05)),
                  controller: activeInputController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (String activi) {
                    activeTimerController.activMillisecond.value =
                        double.parse(activi);
                  },
                  decoration: MyDecoration().inputDecorations(
                    radius: 5,
                    enabledBorderColor: Colors.grey,
                    focusedBorderColor: const Color(0xFFDA1F05),
                    helperText: "Activiti in second",
                    helperTextColor: Colors.white,
                    lableText: "Activiti",
                    lableTextColor: const Color(0xFFDA1F05),
                    prefixIcon: MdiIcons.fire,
                    prefixIconColor: const Color(0xFFDA1F05),
                    suffixText: "sec",
                    suffixTextColor: const Color.fromARGB(200, 255, 255, 255),
                    hintText: 'activiti',
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                  width: Get.width / 3,
                  child: TextField(
                    style: const TextStyle(color: Color(0xFF00CCFF)),
                    controller: restInputController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (String rest) {
                      activeTimerController.restMillisecond.value =
                          double.parse(rest);
                    },
                    decoration: MyDecoration().inputDecorations(
                      radius: 5,
                      enabledBorderColor: Colors.grey,
                      focusedBorderColor: const Color(0xFF00CCFF),
                      helperText: "Rest in second",
                      helperTextColor: Colors.white,
                      lableText: "Rest",
                      lableTextColor: const Color(0xFF00CCFF),
                      prefixIcon: MdiIcons.weatherWindy,
                      prefixIconColor: const Color(0xFF00CCFF),
                      suffixText: "sec",
                      suffixTextColor: const Color.fromARGB(200, 255, 255, 255),
                      hintText: 'rest',
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }

  Row rowOfTowPercentIndecators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // RotatedBox(
        //   quarterTurns: -1,
        //   child: Slider(
        //       value: activeTimerController.player1.volume,
        //       onChanged: (value) {
        //         activeTimerController.player1.setVolume(value);
        //       }),
        //
        // LinearPercentIndicator(
        //     linearGradient: const LinearGradient(
        //       colors: [
        //         Color(0xFFFFC11F),
        //         Color(0xFFFE650D),
        //         Color(0xFFF33C04),
        //         Color(0xFFDA1F05),
        //         Color(0xFFA10100),
        //         Color.fromARGB(255, 243, 24, 4),
        //       ],
        //       begin: FractionalOffset(0.0, 0.0),
        //       end: FractionalOffset(1.0, 0.0),
        //     ),
        //     backgroundColor: Colors.grey.shade700,
        //     alignment: MainAxisAlignment.start,
        //     width: Get.width / 3,
        //     lineHeight: 10,
        //     percent: 1.0,
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: CircularPercentIndicator(
            linearGradient: const LinearGradient(
                colors: [
                  Color(0xFFFFC11F),
                  Color(0xFFFE650D),
                  Color(0xFFF33C04),
                  Color(0xFFDA1F05),
                  Color(0xFFA10100),
                  Color.fromARGB(255, 243, 24, 4),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                tileMode: TileMode.clamp),
            radius: Get.width / 5,
            backgroundColor: Colors.grey.shade700,
            lineWidth: 16,
            // progressColor: Colors.lightBlue,
            circularStrokeCap: CircularStrokeCap.round,
            percent: activeTimerController.percent.value,
            center: Text(
              "${(activeTimerController.timeOnCenter.value * 1000).toInt()}",
              style: const TextStyle(
                  fontSize: 70, color: Color.fromARGB(255, 253, 253, 253)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: CircularPercentIndicator(
            linearGradient: const LinearGradient(
                colors: [
                  Color(0xFF3366FF),
                  Color(0xFF00CCFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            radius: Get.width / 5,
            backgroundColor: Colors.grey.shade700,
            lineWidth: 16,
            // progressColor: Colors.lightBlue,
            circularStrokeCap: CircularStrokeCap.round,
            percent: activeTimerController.percentRest.value,
            center: Text(
              "${(activeTimerController.timeOnCenterRest.value * 1000).toInt()}",
              style: const TextStyle(
                  fontSize: 70, color: Color.fromARGB(255, 250, 252, 253)),
            ),
          ),
        ),
      ],
    );
  }

  Stack firstIconShowRepsCount() {
    return Stack(
      children: [
        const Icon(
          Icons.loop,
          color: Colors.grey,
          size: 50,
        ),
        Positioned(
          left: 20,
          top: 17,
          child: Text(
            activeTimerController.loopOnScreen.value.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
