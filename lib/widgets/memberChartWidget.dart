import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/reportChartModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class MemberChartWidget extends StatelessWidget {
  MemberChartWidget({required this.data});

  final ReportChartModel data;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      duration: Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        backgroundColor: ColorConstants.white,
        minX: 0,
        maxX: 12,
        maxY: 11,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData:
            LineTouchTooltipData(tooltipBgColor: ColorConstants.black),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 1:
        text = '100ຄົນ';
        break;
      case 2:
        text = '200ຄົນ';
        break;
      case 3:
        text = '300ຄົນ';
        break;
      case 4:
        text = '400ຄົນ';
        break;
      case 5:
        text = '500ຄົນ';
        break;
      case 6:
        text = '600ຄົນ';
        break;
      case 7:
        text = '700ຄົນ';
        break;
      case 8:
        text = '800ຄົນ';
        break;
      case 9:
        text = '900ຄົນ';
        break;
      case 10:
        text = '1000ຄົນ';
        break;
      case 11:
        text = '>1000ຄົນ';
        break;
      default:
        return Container();
    }

    return Text(text,
        style: getRegularStyle(
            fontSize: FontSizes.s8, color: ColorConstants.black),
        textAlign: TextAlign.right);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('ມັງກອນ',
            style: getRegularStyle(
                fontSize: FontSizes.s8, color: ColorConstants.black));
        break;
      case 2:
        text = Text('ກຸມພາ',
            style: getRegularStyle(
                fontSize: FontSizes.s8, color: ColorConstants.black));
        break;
      case 3:
        text = Text('ມີນາ',
            style: getRegularStyle(
                fontSize: FontSizes.s8, color: ColorConstants.black));
        break;
      case 4:
        text = Text('ເມສາ',
            style: getRegularStyle(
                fontSize: FontSizes.s8, color: ColorConstants.black));
        break;
      case 5:
        text = Text('ພຶດສະພາ',
            style: getRegularStyle(
                fontSize: FontSizes.s8, color: ColorConstants.black));
        break;
      case 6:
        text = Text('ມີຖຸນາ',
            style: getRegularStyle(
                fontSize: FontSizes.s8, color: ColorConstants.black));
        break;
      case 7:
        text = Text('ກໍລະກົດ',
            style: getRegularStyle(
                fontSize: FontSizes.s8, color: ColorConstants.black));
        break;
      case 8:
        text = Text('ສິງຫາ',
            style: getRegularStyle(
                fontSize: FontSizes.s8, color: ColorConstants.black));
        break;
      case 9:
        text = Text('ກັນຍາ',
            style: getRegularStyle(
                fontSize: FontSizes.s8, color: ColorConstants.black));
        break;
      case 10:
        text = Text('ຕຸລາ',
            style: getRegularStyle(
                fontSize: FontSizes.s8, color: ColorConstants.black));
        break;
      case 11:
        text = Text('ພະຈິກ',
            style: getRegularStyle(
                fontSize: FontSizes.s8, color: ColorConstants.black));
        break;
      case 12:
        text = Text('ທັນວາ',
            style: getRegularStyle(
                fontSize: FontSizes.s8, color: ColorConstants.black));
        break;
      default:
        text = Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: ColorConstants.primary.withOpacity(0.1), width: 2),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );
  LineChartBarData get lineChartBarData => LineChartBarData(
      isCurved: true,
      color: ColorConstants.success,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          data.result!.length,
          (i) => FlSpot((i + 1).toDouble(),
              double.parse(data.result![i].member.toString()) / 100)));
}
