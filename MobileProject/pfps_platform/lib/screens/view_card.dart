import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pfps_platform/services/networks/network_core.dart';

class ViewCard extends StatelessWidget {
  final int index;

  const ViewCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FutureBuilder(
          future: CoreNetwork().fetchCoreData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final dataSet = snapshot.data![index];
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      dataSet.device_id,
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      dataSet.water_value,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: SizedBox(
                                  child: Text(
                                    'mm',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [
                                    waterValueConvert(
                                        double.parse(dataSet.water_value)),
                                    waterValueConvert(
                                        double.parse(dataSet.water_value))
                                  ],
                                  colors: [
                                    Colors.red.shade300,
                                    Colors.blue.shade300,
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return SpinKitWaveSpinner(
                waveColor: Colors.blue.shade200,
                color: Colors.blue,
                size: 100,
              );
            }
          }),
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
  return animatedHeight <= 100 ? animatedHeight : 1.0;
}
