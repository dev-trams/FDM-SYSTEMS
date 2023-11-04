import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(Object context) {
    return Column(
      children: [
        const Text(
          "공공시설 수해 방지 플랫폼",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimerBuilder.periodic(const Duration(seconds: 1),
                builder: (context) {
              // 1초마다 화면을 다시 그리고 현재 시간을 표시
              return Text(
                DateFormat('yyy-MM-d')
                    .format(DateTime.now()), // 현재 시간을 HH:mm:ss 형식으로 표시
                style: const TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              );
            }),
            TimerBuilder.periodic(const Duration(seconds: 1),
                builder: (context) {
              // 1초마다 화면을 다시 그리고 현재 시간을 표시
              return Text(
                DateFormat('a h:mm s')
                    .format(DateTime.now()), // 현재 시간을 HH:mm:ss 형식으로 표시
                style: const TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              );
            }),
          ],
        ),
      ],
    );
  }
}
