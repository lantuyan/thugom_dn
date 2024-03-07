import 'package:flutter/material.dart';

class PieChartModel{
  final String name;
  final double percent;
  final int quantity;
  final Color color;
  PieChartModel(this.name, this.percent, this.quantity, this.color);
}