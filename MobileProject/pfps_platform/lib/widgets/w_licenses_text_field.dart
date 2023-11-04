import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

StringBuffer licensesBuffer = StringBuffer();

class wLicensesTextField extends StatefulWidget {
  final bool? state;
  const wLicensesTextField({
    super.key,
    required BuildContext context,
    this.state = false,
  });

  @override
  State<wLicensesTextField> createState() => _wLicensesTextFieldState();
}

class _wLicensesTextFieldState extends State<wLicensesTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      width: 30,
      child: TextField(
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (_) => setState(
          () {
            if (licensesBuffer.length > 8) {
              licensesBuffer.clear();
            }
            if (widget.state!) {
              FocusScope.of(context).unfocus();
              licensesBuffer.write(_);
            } else {
              FocusScope.of(context).nextFocus();
              licensesBuffer.write(_);
            }
          },
        ),
      ),
    );
  }
}
