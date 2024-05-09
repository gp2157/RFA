import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'generateNcolors.dart';
import 'indicator.dart';

class MyPieChart extends StatefulWidget {
  final List<dynamic> labelList;
  final List<double> valueList;
  final bool donut;

  MyPieChart(
      {super.key,
      required this.labelList,
      required this.valueList,
      this.donut = false}) {
    // Check if the xdataList and ydataList have the same size
    if (labelList.length != valueList.length) {
      throw Exception("xdataList and ydataList must have the same size.");
    }
  }

  @override
  State<MyPieChart> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  late int touchedIndex;
  late int datasize;
  late List<Color> colors;

  @override
  void initState() {
    super.initState();
    touchedIndex = -1;
    datasize = widget.labelList.length;
    colors = generateUniqueRandomColors(datasize);
  }

  @override
  Widget build(BuildContext context) {
     
    double screenWidth = MediaQuery.of(context).size.width;
    int itemsPerRow = getItemsPerRow(screenWidth);

    // Creating columns of widgets
    List<List<Widget>> columns = List.generate(itemsPerRow, (i) => []);

    for (var i = 0; i < datasize; i++) {
      columns[i % itemsPerRow].add(
        Indicator(
          color: colors[i],
          text: widget.labelList[i],
          isSquare: false,
          size: touchedIndex == i ? 18 : 16,
          textColor:
              touchedIndex == i ? Colors.black : Colors.black.withOpacity(0.5),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: MediaQuery.of(context).size.height < 600
            ? 500
            : MediaQuery.of(context).size.height / 1.035,
        width: MediaQuery.of(context).size.width < 770
            ? 760
            : (MediaQuery.of(context).size.width > 1000
                ? 1000
                : MediaQuery.of(context).size.width /
                    1.035), // Will need to change this value in future
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 28,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: columns
                      .map((widgetList) => Column(children: widgetList))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    startDegreeOffset: 180,
                    borderData: FlBorderData(
                      show: true,
                    ),
                    sectionsSpace: 1,
                    centerSpaceRadius: widget.donut ? 50 : 0,
                    sections: List.generate(datasize, (index) {
                      return PieChartSectionData(
                        color: colors[index],
                        value: widget.valueList[index],
                        title: widget.labelList[index],
                        radius: 80,
                        titlePositionPercentageOffset: 0.55,
                        borderSide: index == touchedIndex
                            ? const BorderSide(color: Colors.white, width: 6)
                            : BorderSide(color: Colors.white.withOpacity(0)),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    int getItemsPerRow(double screenWidth) {
    if (screenWidth < 500) {
      // define your own break-point
      return 3; // 3 items per row if width is less than 500 pts
    } else {
      return 4; // 4 items per row if width is 500 pts or more
    }
  }
}
