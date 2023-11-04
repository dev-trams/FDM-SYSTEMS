import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pfps_platform/models/model_core.dart';
import 'package:pfps_platform/screens/screen_detail_barrier.dart';
import 'package:pfps_platform/services/networks/network_core.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  const DetailScreen({super.key, required this.index});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final Color backgroundAppBarColor = const Color(0xFF1C2D4E);
  late Future<List<CoreClient>> a = CoreNetwork().fetchCoreData();
  double waveValue = 1.0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        a = CoreNetwork().fetchCoreData();
      });
    });
  }

  String deviceId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PFPS-PLATFORM',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '공공수해재난스마트플랫폼',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: backgroundAppBarColor,
        shadowColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: CoreNetwork().fetchCoreData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final datas = snapshot.data![widget.index];
                  deviceId = datas.device_id;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconDataMonitorBtn(
                        dataLabel: '${datas.temp_value}℃',
                        icon: Typicons.thermometer,
                        dataInputState: true,
                      ),
                      IconDataMonitorBtn(
                        dataLabel: '${datas.humi_value}%',
                        icon: Icons.water_drop,
                        dataInputState: true,
                      ),
                      IconDataMonitorBtn(
                        dataLabel: '${datas.water_value}cm',
                        icon: Icons.water,
                        dataInputState: true,
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconDataMonitorBtn(
                        dataLabel: '',
                        icon: Typicons.thermometer,
                        dataInputState: false,
                      ),
                      IconDataMonitorBtn(
                        dataLabel: '',
                        icon: Icons.water_drop,
                        dataInputState: false,
                      ),
                      IconDataMonitorBtn(
                        dataLabel: '',
                        icon: Icons.water,
                        dataInputState: false,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 225, 225, 225),
              child: FutureBuilder(
                future: a,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final datas = snapshot.data![widget.index];
                    waveValue = double.parse(datas.water_value);
                    print(waveValue);
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(400),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: WaveWidget(
                              config: CustomConfig(
                                colors: [
                                  const Color(0xFF3A78D4),
                                  const Color(0xFFECF7FF),
                                  const Color(0xFF4AC9FF),
                                ],
                                durations: [5000, 6000, 7000],
                                heightPercentages: [
                                  waterValueConvert(waveValue),
                                  waterValueConvert(waveValue),
                                  waterValueConvert(waveValue)
                                ],
                              ),
                              size:
                                  const Size(double.infinity, double.infinity)),
                        ),
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 10, color: const Color(0xFF004186)),
                            borderRadius: BorderRadius.circular(400),
                          ),
                          clipBehavior: Clip.hardEdge,
                        ),
                        Center(
                          child: Text('${datas.water_value}cm'),
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SimpleBorderButton(
                  text: '차수벽',
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BarrierDetailScreen(
                          deviceId: deviceId,
                        ),
                      )),
                ),
                const SimpleBorderButton(
                  text: '자동모드',
                  gradientBorder: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleBorderButton extends StatelessWidget {
  final String text;
  final double? borderWidth;
  final int? borderColor;
  final double? borderRadius;
  final Function()? onTap;
  final bool? gradientBorder;
  const SimpleBorderButton({
    super.key,
    required this.text,
    this.borderWidth,
    this.borderColor,
    this.borderRadius,
    this.onTap,
    this.gradientBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(borderRadius ?? 20.0),
        child: Container(
          decoration: BoxDecoration(
            border: !gradientBorder!
                ? Border.all(
                    color: Color(borderColor ?? 0xFFD1E9FD),
                    width: borderWidth ?? 5,
                  )
                : GradientBoxBorder(
                    gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xFF0A0F87),
                        Color(0xFF216BBA),
                        Color(0xFFE3F2FD),
                      ],
                    ),
                    width: borderWidth ?? 5,
                  ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextButton(
            onPressed: onTap ?? () => print('clicked!!'),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IconDataMonitorBtn extends StatelessWidget {
  IconData icon;
  String dataLabel;
  bool dataInputState;
  IconDataMonitorBtn({
    super.key,
    required this.icon,
    required this.dataLabel,
    required this.dataInputState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: const Color(0xFFD1E9FD), width: 10),
        borderRadius: BorderRadius.circular(60),
      ),
      width: 80,
      height: 80,
      child: GestureDetector(
        onTap: () => print('clicked!!'),
        child: dataInputState
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon),
                  Text(
                    dataLabel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : SpinKitWaveSpinner(
                waveColor: Colors.blue.shade200,
                color: Colors.blue,
                size: 100,
              ),
      ),
    );
  }
}

double waterValueConvert(double waveValue) {
  double minPercentage = 0.0; // 최소 퍼센트
  double maxPercentage = 15.0; // 최대 퍼센트

  double minValue = 0.0; // 최소 값
  double maxValue = 1.0; // 최대 값

  double percentage = waveValue; // 변환할 퍼센트 값

// 퍼센트 값을 최소 값과 최대 값 사이로 변환
  double animatedHeight = (maxValue - minValue) *
          (percentage - minPercentage) /
          (maxPercentage - minPercentage) +
      minValue;
  print(animatedHeight);
  return animatedHeight <= 15 ? animatedHeight : 1.0;
}
