import 'package:flutter/material.dart';

class OptionButton extends StatefulWidget {
  final IconData enabledIcon;
  final IconData disabledIcon;
  final Function(bool value)? onPressed;
  final double? padding;

  const OptionButton(
      {super.key,
      required this.enabledIcon,
      required this.disabledIcon,
      this.onPressed,
      this.padding = 8.0});

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  bool powerBtnState = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding ?? 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: IconButton(
          iconSize: 50,
          onPressed: () {
            setState(() {
              powerBtnState = !powerBtnState;
            });
            widget.onPressed?.call(powerBtnState);
          },
          icon: Icon(
            powerBtnState ? widget.enabledIcon : widget.disabledIcon,
          ),
        ),
      ),
    );
  }
}
