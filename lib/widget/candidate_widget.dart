import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CandidateWidget extends StatefulWidget {
  final VoidCallback tap;
  final String text;
  final int index;
  final double width;
  bool answerState;
  CandidateWidget({
    super.key,
    required this.tap,
    required this.text,
    required this.index,
    required this.width,
    required this.answerState,
  });
  @override
  State<CandidateWidget> createState() => _CandidateWidgetState();
}

class _CandidateWidgetState extends State<CandidateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.8,
      height: widget.width * 0.1,
      padding: EdgeInsets.fromLTRB(
        widget.width * 0.048,
        widget.width * 0.024,
        widget.width * 0.048,
        widget.width * 0.024,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurple),
        color: widget.answerState ? Colors.deepPurple : Colors.white,
      ),
      child: InkWell(
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.width * 0.035,
            color: widget.answerState ? Colors.white : Colors.black,
          ),
        ),
        onTap: () {
          setState(() {
            widget.tap();
            widget.answerState = !widget.answerState;
          });
        },
      ),
    );
  }
}
