import 'package:flutter/material.dart';

class WFContainer extends StatefulWidget {
  const WFContainer({
    super.key,
    required this.calendarData,
    required this.iconCondition,
    required this.temperature,
  });
  final String calendarData;
  final String iconCondition;
  final double temperature;
  @override
  State<WFContainer> createState() => _WFContainerState();
}

class _WFContainerState extends State<WFContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 200,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        boxShadow: const [
          BoxShadow(
            color: Colors.white12,
            spreadRadius: 1,
            blurRadius: 15,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Text(
            widget.calendarData,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          // Image.network("$icon", scale: 1),
          Image.network("https:{$widget.iconCondition}", scale: 1),
          Text(
            "${widget.temperature}°C",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
