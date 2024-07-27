import 'package:bounchan_hotel_admin_app/models/reportChartModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MemberChartBar extends StatefulWidget {
  MemberChartBar({super.key, required this.data});
  final ReportChartModel data;
  final Color leftBarColor = Color.fromARGB(255, 6, 20, 214);
  final Color rightBarColor = Colors.red;
  final Color avgColor = Colors.yellow;
  @override
  State<StatefulWidget> createState() => MemberChartBarState();
}

class MemberChartBarState extends State<MemberChartBar> {
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);
    final barGroup8 = makeGroupData(7, 10, 1.5);
    final barGroup9 = makeGroupData(8, 10, 1.5);
    final barGroup10 = makeGroupData(9, 10, 1.5);
    final barGroup11 = makeGroupData(10, 10, 1.5);
    final barGroup12 = makeGroupData(11, 10, 1.5);

    // final items = [
    //   barGroup1,
    //   barGroup2,
    //   barGroup3,
    //   barGroup4,
    //   barGroup5,
    //   barGroup6,
    //   barGroup7,
    //   barGroup8,
    //   barGroup9,
    //   barGroup10,
    //   barGroup11,
    //   barGroup12,
    // ];

    final items = List.generate(
        widget.data.result!.length,
        (i) => makeGroupData(
            i,
            widget.data.result![i].member!.toDouble() / 100,
            widget.data.result![i].member!.toDouble() / 100));

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: <Widget>[
              //     makeTransactionsIcon(),
              //     const SizedBox(
              //       width: 38,
              //     ),
              //     const Text(
              //       'Transactions',
              //       style: TextStyle(color: Colors.white, fontSize: 22),
              //     ),
              //     const SizedBox(
              //       width: 4,
              //     ),
              //     const Text(
              //       'state',
              //       style: TextStyle(color: Color(0xff77839a), fontSize: 16),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 38,
              // ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 8,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        // getTooltipColor: ((group) {
                        //   return Colors.grey;
                        // }),
                        getTooltipItem: (a, b, c, d) => null,
                      ),
                      touchCallback: (FlTouchEvent event, response) {
                        if (response == null || response.spot == null) {
                          setState(() {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                          });
                          return;
                        }

                        touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                        setState(() {
                          if (!event.isInterestedForInteractions) {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                            return;
                          }
                          showingBarGroups = List.of(rawBarGroups);
                          if (touchedGroupIndex != -1) {
                            var sum = 0.0;
                            for (final rod
                                in showingBarGroups[touchedGroupIndex]
                                    .barRods) {
                              sum += rod.toY;
                            }
                            final avg = sum /
                                showingBarGroups[touchedGroupIndex]
                                    .barRods
                                    .length;

                            showingBarGroups[touchedGroupIndex] =
                                showingBarGroups[touchedGroupIndex].copyWith(
                              barRods: showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .map((rod) {
                                return rod.copyWith(
                                    toY: avg, color: widget.avgColor);
                              }).toList(),
                            );
                          }
                        });
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        axisNameSize: 10,
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                          reservedSize: 52,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          interval: 1,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: const FlGridData(show: false),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );
    String text;
    if (value == 1) {
      text = '100ຄົນ';
    } else if (value == 2) {
      text = '200ຄົນ';
    } else if (value == 3) {
      text = '300ຄົນ';
    } else if (value == 4) {
      text = '400ຄົນ';
    } else if (value == 5) {
      text = '500ຄົນ';
    }else if (value == 6) {
      text = '600ຄົນ';
    }else if (value == 7) {
      text = '700ຄົນ';
    }else if (value == 8) {
      text = '800ຄົນ';
    }else if (value == 9) {
      text = '900ຄົນ';
    }else if (value == 10) {
      text = '1000ຄົນ';
    }else if (value == 11) {
      text = '<1000ຄົນ';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
     'ມກ',
      'ກພ',
      'ມນ',
      'ມສ',
      'ພສພ',
      'ມຖນ',
      'ກລກ',
      'ສຫ',
      'ກຍ',
      'ຕລ',
      'ພຈ',
      'ທວ',
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color.fromARGB(255, 224, 36, 149),
        fontWeight: FontWeight.bold,
        fontSize: 9,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: widget.leftBarColor,
          width: width,
        ),
        // BarChartRodData(
        //   toY: y2,
        //   color: widget.rightBarColor,
        //   width: width,
        // ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
