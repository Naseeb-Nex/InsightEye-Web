import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:insighteye_web/constants/constants.dart';

class LineChartwidget extends StatefulWidget {
  const LineChartwidget({Key? key}) : super(key: key);

  @override
  State<LineChartwidget> createState() => _LineChartwidgetState();
}

class _LineChartwidgetState extends State<LineChartwidget> {
  List<Color> gradientColors = [
    hpColor,
    hpColor,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: LineChart(
            mainData(),
          ),
        ),
      ],
    );
  }

  // Bottom chart titles
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontFamily: "Montserrat",
      fontWeight: FontWeight.w400,
      color: Color(0xFFA0A0A0),
      fontSize: 13,
    );

    final int weekNumber = value.toInt();

    Widget text;
    // tittle value selections
    switch (weekNumber) {
      case 1:
        text = const Text('Mon', style: style);
        break;
      case 2:
        text = const Text('Tue', style: style);
        break;
      case 3:
        text = const Text('Wed', style: style);
        break;
      case 4:
        text = const Text('Thu', style: style);
        break;
      case 5:
        text = const Text('Fri', style: style);
        break;
      case 6:
        text = const Text('Sat', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    // Return SideTitle
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  // Left chart titles
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const numstyle = TextStyle(
        color: Color(0xFFA0A0A0),
        fontSize: 10,
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w500);

    final int leftValue = value.toInt();

    Widget text;
    // Title value selections
    switch (leftValue) {
      case 0:
        text = const Text('0', style: numstyle, textAlign: TextAlign.left,);
        break;
      case 10:
        text = const Text('10', style: numstyle);
        break;
      case 20:
        text = const Text('20', style: numstyle);
        break;
      case 30:
        text = const Text('30', style: numstyle);
        break;
      case 40:
        text = const Text('', style: numstyle);
        break;
      default:
        return Container();
    }

    // Return SideTitle
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      // grid on the background
      gridData: FlGridData(
        show: true, // Set this to true to show the horizontal grid lines
        horizontalInterval:
            10, // Set the interval for the horizontal grid lines
        drawVerticalLine: false, // Disable vertical grid lines
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color.fromARGB(165, 233, 228, 255), // Set the color of the horizontal grid lines
            strokeWidth: 0.8,
            dashArray: [6, 5], // Set the width of the horizontal grid lines
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        // right Titles disabled
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        // Top title disabled
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        // bottom titles
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),

        // left titles
        leftTitles: AxisTitles(
          axisNameSize: 35,
          sideTitles: SideTitles(
            showTitles: true,
            interval: 10,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      // border Disabled
      borderData: FlBorderData(
        show: false, // Set this to true to show the border
      ),
      minX: 1,
      maxX: 6,
      minY: 0,
      maxY: 40,
      lineBarsData: [
        // line chart spots
        LineChartBarData(
          spots: [
            const FlSpot(1, 10),
            const FlSpot(2, 15),
            const FlSpot(3, 25),
            const FlSpot(4, 0),
            const FlSpot(5, 0),
            const FlSpot(6, 0),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          // below portions of line chart
          belowBarData: BarAreaData(
            show: true,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[white, white],
            ),
          ),
        ),
      ],
      // line Touch events
      lineTouchData: LineTouchData(
        // customized Dot and dashed line
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> indicators) {
          return indicators.map(
            (int index) {
              final line = FlLine(
                  color: hpColor.withOpacity(0.5),
                  strokeWidth: 1.5,
                  dashArray: [6, 5]);
              return TouchedSpotIndicatorData(
                line,
                FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                    radius: 8,
                    color: hpColor,
                    strokeWidth: 6,
                    strokeColor: hpColor.withOpacity(0.2),
                  ),
                ),
              );
            },
          ).toList();
        },
        // Tool tip customization
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: hpColor.withOpacity(0.8),
          tooltipRoundedRadius: 8,
          tooltipBorder:  BorderSide(width: 2, color: hpColor.withOpacity(0.4)),
          getTooltipItems: ((List<LineBarSpot> line) {
            // passing each data to each tooltip
            return line.map((LineBarSpot data) {
              String tipsvalue = data.y.toString();
              return LineTooltipItem(
                tipsvalue,
                const TextStyle(
                  fontFamily: "Nunito",
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              );
            }).toList();
          }),
        ),
      ),
    );
  }
}
