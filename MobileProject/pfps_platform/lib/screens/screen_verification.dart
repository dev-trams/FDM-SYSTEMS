import 'package:flutter/material.dart';
import 'package:pfps_platform/screens/screen_detail.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatelessWidget {
  final String license;
  final int index;
  VerificationScreen({super.key, required this.license, required this.index});

  final Color backgroundAppBarColor = const Color(0xFF1C2D4E);
  String _code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  child: Image.network(
                    'https://ipsi.kcce.or.kr/file/UNIV_LOGO/2021_73011000_1614673588738.png',
                    scale: 2,
                  ),
                ),
                const SizedBox(
                  child: Text(
                    'PFPS-PLATFORM',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  child: Text('공공 수해 재난 스마트 플랫폼'),
                ),
              ],
            ),
            // Image.asset('images/logo_kbu.png')
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: PinCodeTextField(
                            appContext: context,
                            length: 8,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onCompleted: (code) => _code = code,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: backgroundAppBarColor,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextButton(
                        style: const ButtonStyle(),
                        onPressed: () {
                          if (_code == license) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  index: index,
                                ),
                              ),
                            );
                          } else {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                padding: const EdgeInsets.all(30.0),
                                child: const Text(
                                  '라이센스 키가 유효하지 않습니다.\n다시 확인해주세요!',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          '인증',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
