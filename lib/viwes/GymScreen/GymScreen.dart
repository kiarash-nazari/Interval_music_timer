import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sport_timer/components/Decorations.dart';
import 'package:sport_timer/controller/Gym/GymController.dart';

class GymScreen extends StatelessWidget {
  GymScreen({super.key});
  GymController gymController = Get.put(GymController());

  final afterSetRestInputController = TextEditingController();
  final circuleInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(20, 245, 0, 86),
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gymController.afterSetIconPlay.value
                      ? InkWell(
                          onTap: () {
                            if (gymController.afterSetIconPlay.value) {
                              gymController.afterSetIconPlay.value = false;
                              gymController.startAfterSetTimer();
                              gymController.aviodRunMusicAfter.value = false;
                            }
                          },
                          child: const Icon(
                            Icons.play_arrow,
                            color: Color(0xFF00CCFF),
                            size: 50,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            if (!gymController.afterSetIconPlay.value) {
                              gymController.afterSetIconPlay.value = true;
                              gymController.playerStartGym.pause();
                              gymController.timerAfterSet.cancel();
                            }
                          },
                          child: const Icon(
                            Icons.pause,
                            color: Color(0xFF00CCFF),
                            size: 50,
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
                      percent: gymController.percentAfterSet.value,
                      center: Text(
                        "${(gymController.timeOnCenterAfterRest.value * 1000).toInt()}",
                        style: const TextStyle(
                            fontSize: 70,
                            color: Color.fromARGB(255, 250, 252, 253)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      gymController.afterRestMillisecond.value = 0.0;
                      gymController.percentAfterSet.value = 0.0;
                      gymController.timeOnCenterAfterRest.value = 0.0;
                      afterSetRestInputController.clear();
                    },
                    child: const Icon(
                      MdiIcons.restart,
                      color: Colors.amber,
                      size: 50,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                        width: Get.width / 3,
                        child: TextField(
                          style: const TextStyle(color: Color(0xFF00CCFF)),
                          controller: afterSetRestInputController,
                          keyboardType: TextInputType.number,
                          onSubmitted: (String rest) {
                            gymController.afterRestMillisecond.value =
                                double.parse(rest);
                          },
                          decoration: MyDecoration().inputDecorations(
                            radius: 5,
                            enabledBorderColor: Colors.grey,
                            focusedBorderColor: const Color(0xFF00CCFF),
                            helperText: "Rest in second",
                            helperTextColor: Colors.white,
                            lableText: "after set",
                            lableTextColor: const Color(0xFF00CCFF),
                            prefixIcon: MdiIcons.weatherWindy,
                            prefixIconColor: const Color(0xFF00CCFF),
                            suffixText: "sec",
                            suffixTextColor:
                                const Color.fromARGB(200, 255, 255, 255),
                            hintText: 'rest',
                          ),
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gymController.circuleIconPlay.value
                      ? InkWell(
                          onTap: () {
                            if (gymController.circuleIconPlay.value) {
                              gymController.circuleIconPlay.value = false;
                              gymController.startCirculeTimer();
                              gymController.aviodRunMusicCircule.value = false;
                            }
                          },
                          child: const Icon(
                            Icons.play_arrow,
                            color: Color(0xFF00CCFF),
                            size: 50,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            if (!gymController.circuleIconPlay.value) {
                              gymController.circuleIconPlay.value = true;
                              // gymController.jkob.value = false;
                              gymController.playerStartGym.pause();

                              gymController.timerCircule.cancel();
                            }
                          },
                          child: const Icon(
                            Icons.pause,
                            color: Color(0xFF00CCFF),
                            size: 50,
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
                      percent: gymController.percentCircule.value,
                      center: Text(
                        "${(gymController.timeOnCenterCircule.value * 1000).toInt()}",
                        style: const TextStyle(
                            fontSize: 70,
                            color: Color.fromARGB(255, 250, 252, 253)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      gymController.circuleMillisecond.value = 0.0;
                      gymController.percentCircule.value = 0.0;
                      gymController.timeOnCenterCircule.value = 0.0;
                      circuleInputController.clear();
                    },
                    child: const Icon(
                      MdiIcons.restart,
                      color: Colors.amber,
                      size: 50,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: Get.width / 3,
                      child: TextField(
                        style: const TextStyle(color: Color(0xFF00CCFF)),
                        controller: circuleInputController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (String rest) {
                          gymController.circuleMillisecond.value =
                              double.parse(rest);
                        },
                        decoration: MyDecoration().inputDecorations(
                          radius: 5,
                          enabledBorderColor: Colors.grey,
                          focusedBorderColor: const Color(0xFF00CCFF),
                          helperText: "Rest in second",
                          helperTextColor: Colors.white,
                          lableText: "cyrcule",
                          lableTextColor: const Color(0xFF00CCFF),
                          prefixIcon: MdiIcons.weatherWindy,
                          prefixIconColor: const Color(0xFF00CCFF),
                          suffixText: "sec",
                          suffixTextColor:
                              const Color.fromARGB(200, 255, 255, 255),
                          hintText: 'rest',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              gymController.unmute.value
                  ? InkWell(
                      onTap: () {
                        gymController.unmute.value = false;
                        gymController.playerStartGym.setVolume(0.0);
                      },
                      child: const Icon(
                        MdiIcons.volumeHigh,
                        color: Color(0xFFDA1F05),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        gymController.unmute.value = true;
                        gymController.playerStartGym.setVolume(1.0);
                      },
                      child: const Icon(
                        MdiIcons.volumeOff,
                        color: Colors.grey,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
