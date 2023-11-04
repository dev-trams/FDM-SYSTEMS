import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pfps_platform/models/model_core.dart';
import 'package:pfps_platform/models/model_warning.dart';
import 'package:pfps_platform/services/networks/network_core.dart';
import 'package:pfps_platform/util/option_button.dart';
import 'package:provider/provider.dart';

class BarrierDetailScreen extends StatefulWidget {
  final String deviceId;
  const BarrierDetailScreen({Key? key, required this.deviceId})
      : super(key: key);

  @override
  _BarrierDetailScreenState createState() => _BarrierDetailScreenState();
}

class AnimationModel with ChangeNotifier {
  bool _isMovedRight = false;

  bool get isMovedRight => _isMovedRight;

  void toggleMovedRight() {
    _isMovedRight = !_isMovedRight;
    notifyListeners();
  }
}

class _BarrierDetailScreenState extends State<BarrierDetailScreen> {
  List<CoreClient> _dataList = [];
  List<WarningModel> _barrierList = [];
  late Timer _timer;

  void getDatas() async {
    try {
      List<WarningModel> barrierList =
          await CoreNetwork().fetchWaringModel(widget.deviceId);
      List<CoreClient> coreList = await CoreNetwork().fetchCoreData();
      setState(() {
        _dataList = coreList;
        _barrierList = barrierList;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getDatas();
    _timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
      getDatas();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  bool barrierState() {
    if (_barrierList.first.barrier_control == '0') {
      return false;
    } else {
      return true;
    }
  }

  Color backgroundAppBarColor = const Color(0xFF1C2D4E);

  @override
  Widget build(BuildContext context) {
    // final Insert networking = Insert();
    final animationModel = AnimationModel();

    String manual = 'manual';
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
      body: FutureBuilder(
          future: CoreNetwork().fetchWaringModel(widget.deviceId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            width: barrierState() ? 180 : 150,
                            height: 200,
                            duration: const Duration(seconds: 1),
                            alignment: barrierState()
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Image.asset('assets/images/gate_l.png'),
                          ),
                          AnimatedContainer(
                            width: barrierState() ? 180 : 150,
                            height: 200,
                            duration: const Duration(seconds: 1),
                            alignment: barrierState()
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Image.asset('assets/images/gate_r.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _dataList.isNotEmpty &&
                                          _barrierList.isNotEmpty &&
                                          _barrierList.first.manual == "manual"
                                      ? OptionButton(
                                          enabledIcon: _dataList
                                                      .first.barrier_value ==
                                                  "0"
                                              ? FontAwesomeIcons.toggleOff
                                              : _barrierList.first.manual ==
                                                      "manual"
                                                  ? FontAwesomeIcons.toggleOn
                                                  : Icons.not_interested,
                                          /*_barrierList.isNotEmpty &&
                                  _barrierList.first['barrier_control'] == 0 ?
                              FontAwesomeIcons.toggleOff : _barrierList.first['manual'] == "manual" ? FontAwesomeIcons.toggleOn : Icons.not_interested,*/
                                          disabledIcon: _dataList
                                                      .first.barrier_value ==
                                                  "0"
                                              ? FontAwesomeIcons.toggleOff
                                              : _barrierList.first.manual ==
                                                      "manual"
                                                  ? FontAwesomeIcons.toggleOn
                                                  : Icons.not_interested,
                                          /*_barrierList.isNotEmpty &&
                                  _barrierList.first['barrier_control'] == 0 ?
                              FontAwesomeIcons.toggleOff : _barrierList.first['manual'] == "manual" ? FontAwesomeIcons.toggleOn : Icons.not_interested,*/
                                          onPressed: (value) {
                                            animationModel.toggleMovedRight();

                                            int barrierControl = _barrierList
                                                        .first
                                                        .barrier_control ==
                                                    '0'
                                                ? 1
                                                : 0;
                                            print(
                                                'a-a-a:$barrierControl, b-b-b:${_barrierList.first.barrier_control}');
                                            Insert().insertData(
                                                deviceId: widget.deviceId,
                                                manual: manual,
                                                barrierControl:
                                                    barrierControl.toString());
                                          },
                                        )
                                      : OptionButton(
                                          enabledIcon: _barrierList
                                                      .isNotEmpty &&
                                                  _barrierList.first.manual ==
                                                      "manual"
                                              ? FontAwesomeIcons.toggleOff
                                              : Icons.not_interested,
                                          disabledIcon: Icons.not_interested,
                                          onPressed: (value) {},
                                        ),
                                  OptionButton(
                                    enabledIcon: _barrierList.isNotEmpty &&
                                            _barrierList.first.manual ==
                                                "manual"
                                        ? Icons.lock_open_outlined
                                        : Icons.lock_outline,
                                    disabledIcon: _barrierList.isNotEmpty &&
                                            _barrierList.first.manual == "auto"
                                        ? Icons.lock_outline
                                        : Icons.lock_open_outlined,
                                    onPressed: (value) {
                                      animationModel.toggleMovedRight();

                                      manual = _barrierList.isNotEmpty &&
                                              _barrierList.first.manual ==
                                                  "manual"
                                          ? "auto"
                                          : "manual";
                                      int barrierControl = 1;
                                      Insert().insertData(
                                          deviceId: widget.deviceId,
                                          manual: manual,
                                          barrierControl:
                                              barrierControl.toString());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: SpinKitWaveSpinner(
                  waveColor: Colors.blue.shade200,
                  color: Colors.blue,
                  size: 100,
                ),
              );
            }
          }),
    );
  }
}
