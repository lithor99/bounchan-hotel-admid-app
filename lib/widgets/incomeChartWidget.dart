import 'package:bounchan_hotel_admin_app/constants/colors.dart';
import 'package:bounchan_hotel_admin_app/constants/fonts.dart';
import 'package:bounchan_hotel_admin_app/constants/styles.dart';
import 'package:bounchan_hotel_admin_app/models/reportChartModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class IncomeChartWidget extends StatelessWidget {
  IncomeChartWidget({required this.data});

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
        backgroundColor: ColorConstants.black,
        minX: 0,
        maxX: 12,
        maxY: 11,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData:
            LineTouchTooltipData(tooltipBgColor: ColorConstants.danger),
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
        text = '10ລ້ານ';
        break;
      case 2:
        text = '20ລ້ານ';
        break;
      case 3:
        text = '30ລ້ານ';
        break;
      case 4:
        text = '40ລ້ານ';
        break;
      case 5:
        text = '50ລ້ານ';
        break;
      case 6:
        text = '60ລ້ານ';
        break;
      case 7:
        text = '70ລ້ານ';
        break;
      case 8:
        text = '80ລ້ານ';
        break;
      case 9:
        text = '90ລ້ານ';
        break;
      case 10:
        text = '100ລ້ານ';
        break;
      case 11:
        text = '>100ລ້ານ';
        break;
      default:
        return Container();
    }

    return Text(text,
        style: getRegularStyle(fontSize: FontSizes.s8),
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
        text = Text('JAN', style: getRegularStyle(fontSize: FontSizes.s8));
        break;
      case 2:
        text = Text('FEB', style: getRegularStyle(fontSize: FontSizes.s8));
        break;
      case 3:
        text = Text('MAR', style: getRegularStyle(fontSize: FontSizes.s8));
        break;
      case 4:
        text = Text('APR', style: getRegularStyle(fontSize: FontSizes.s8));
        break;
      case 5:
        text = Text('MAY', style: getRegularStyle(fontSize: FontSizes.s8));
        break;
      case 6:
        text = Text('JUN', style: getRegularStyle(fontSize: FontSizes.s8));
        break;
      case 7:
        text = Text('JUL', style: getRegularStyle(fontSize: FontSizes.s8));
        break;
      case 8:
        text = Text('AUG', style: getRegularStyle(fontSize: FontSizes.s8));
        break;
      case 9:
        text = Text('SEP', style: getRegularStyle(fontSize: FontSizes.s8));
        break;
      case 10:
        text = Text('OCT', style: getRegularStyle(fontSize: FontSizes.s8));
        break;
      case 11:
        text = Text('NOV', style: getRegularStyle(fontSize: FontSizes.s8));
        break;
      case 12:
        text = Text('DEC', style: getRegularStyle(fontSize: FontSizes.s8));
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
      color: ColorConstants.primary,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(
          data.result!.length,
          (i) => FlSpot((i + 1).toDouble(),
              double.parse(data.result![i].income!.toString()) / 10000000)));
}
