import 'package:flutter/material.dart';
import 'package:stockpile/widgets/all_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'drawer.dart';

class PandL extends StatefulWidget {
  const PandL({super.key});

  @override
  State<PandL> createState() => _PandLState();
}

class _PandLState extends State<PandL> {
  ZoomPanBehavior? _zoomPanBehavior;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
        // Enables pinch zooming
        zoomMode: ZoomMode.x,
        enablePanning: true,
        enablePinching: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<CaloriesBurntData> caloriesBurnt = [
      CaloriesBurntData(DateTime(2015, 6, 24, 11, 10), 104),
      CaloriesBurntData(DateTime(2015, 7, 24, 11, 30), 87),
      CaloriesBurntData(DateTime(2015, 8, 24, 12, 10), 40),
      CaloriesBurntData(DateTime(2015, 9, 24, 13, 10), 61),
      CaloriesBurntData(DateTime(2015, 10, 24, 15, 10), 35),
    ];

    final List<CaloriesIntakeData> caloriesIntake = [
      CaloriesIntakeData(DateTime(2015, 1, 24, 11, 10), 50),
      CaloriesIntakeData(DateTime(2015, 2, 24, 11, 30), 38),
      CaloriesIntakeData(DateTime(2015, 3, 24, 12, 10), 44),
      CaloriesIntakeData(DateTime(2015, 4, 24, 13, 10), 50),
      CaloriesIntakeData(DateTime(2015, 5, 24, 11, 10), 12),
      CaloriesIntakeData(DateTime(2015, 6, 24, 11, 30), 28),
      CaloriesIntakeData(DateTime(2015, 7, 24, 12, 10), 53),
      CaloriesIntakeData(DateTime(2015, 8, 24, 13, 10), 20),
      CaloriesIntakeData(DateTime(2015, 9, 24, 15, 10), 36),
      CaloriesIntakeData(DateTime(2015, 10, 24, 18, 10), 38),
      CaloriesIntakeData(DateTime(2015, 11, 24, 19, 10), 27),
      CaloriesIntakeData(DateTime(2015, 12, 24, 22, 10), 30),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const MyDrawer(),
      appBar: myAppBar('Profit and Loss'),
      // backgroundColor: Theme.of(context).canvasColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // caloriesBurntFun(context, caloriesBurnt)
            //     .cornerRadius(5)
            //     .pSymmetric(v: 8),
            caloriesIntakeFun(context, caloriesIntake)
                .cornerRadius(5)
                .pSymmetric(v: 8),
          ],
        ).p16(),
      ),
    );
  }

  Card caloriesBurntFun(
      BuildContext context, List<CaloriesBurntData> caloriesBurnt) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Image.asset(
              //   'assets/images/fire.png',
              //   // filterQuality: FilterQuality.low,
              // ).wh(20, 20).pSymmetric(h: 8),
              'Total Profit Gain'.text.bodyText1(context).make(),
              const Spacer(),
              '610k'.text.xl2.bold.orange500.make(),
              ' Cal'.text.headline6(context).make(),
            ],
          ),
          SfCartesianChart(
              legend: Legend(
                  isVisible: true,
                  iconWidth: 20,
                  isResponsive: true,
                  position: LegendPosition.top,
                  overflowMode: LegendItemOverflowMode.wrap),
              zoomPanBehavior: _zoomPanBehavior,
              primaryXAxis: DateTimeAxis(
                  crossesAt: 0,
                  intervalType: DateTimeIntervalType.months,
                  interval: 2),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries>[
                // Renders line chart
                LineSeries<CaloriesBurntData, DateTime>(
                    color: Colors.green,
                    name: 'Calories Burnt',
                    dataSource: caloriesBurnt,
                    markerSettings: const MarkerSettings(isVisible: true),
                    xValueMapper: (CaloriesBurntData PandL, _) => PandL.month,
                    yValueMapper: (CaloriesBurntData PandL, _) => PandL.PandL)
              ]).h(250),
        ],
      ).p8(),
    );
  }

  Card caloriesIntakeFun(
      BuildContext context, List<CaloriesIntakeData> caloriesIntake) {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Image.asset(
              //   'assets/images/chicken.png',
              //   filterQuality: FilterQuality.low,
              // ).wh(20, 20).pSymmetric(h: 8),
              'Total Profit'.text.xl.gray600.bold.make(),
              const Spacer(),
              '510K'.text.xl2.bold.green500.make(),
              ' Rs.'.text.headline6(context).gray600.make(),
            ],
          ),
          SfCartesianChart(
              legend: Legend(
                  isVisible: true,
                  iconWidth: 20,
                  isResponsive: true,
                  position: LegendPosition.top,
                  overflowMode: LegendItemOverflowMode.wrap),
              zoomPanBehavior: _zoomPanBehavior,
              primaryXAxis: DateTimeAxis(
                  crossesAt: 0,
                  intervalType: DateTimeIntervalType.months,
                  interval: 2),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries>[
                // Renders line chart
                LineSeries<CaloriesIntakeData, DateTime>(
                    color: Colors.green,
                    name: 'Profit gained in a year',
                    dataSource: caloriesIntake,
                    markerSettings: const MarkerSettings(isVisible: true),
                    xValueMapper: (CaloriesIntakeData PandL, _) => PandL.month,
                    yValueMapper: (CaloriesIntakeData PandL, _) => PandL.PandL)
              ]).h(250),
        ],
      ).p8(),
    );
  }
}

class CaloriesBurntData {
  CaloriesBurntData(this.month, this.PandL);
  final DateTime month;
  final double PandL;
}

class CaloriesIntakeData {
  CaloriesIntakeData(this.month, this.PandL);
  final DateTime month;
  final double PandL;
}
