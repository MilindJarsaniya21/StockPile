import 'package:flutter/material.dart';
import 'package:stockpile/widgets/all_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'drawer.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  ZoomPanBehavior? _zoomPanBehavior;
  bool monthlySales = false;
  int flag = 0;

  @override
  void initState() {
    monthlySales = false;
    _zoomPanBehavior = ZoomPanBehavior(
        // Enables pinch zooming
        zoomMode: ZoomMode.x,
        enablePanning: true,
        enablePinching: true);
    super.initState();
  }

  Map<String, int> itemSoldToday = {
    'SmartPhones': 8,
    'Refrigerator': 1,
    'AC': 3,
    'Washing Machine': 0,
    'TV': 3,
    'Laptops': 1,
    'Microwave Oven': 1,
    'Accessories': 15,
  };

  Map<String, int> itemSoldMonthly = {
    'SmartPhones': 84,
    'Refrigerator': 20,
    'AC': 30,
    'Washing Machine': 32,
    'TV': 46,
    'Laptops': 61,
    'Microwave Oven': 12,
    'Accessories': 104,
  };

  @override
  Widget build(BuildContext context) {
    final List<TTotalsales> salesDataToday = [
      TTotalsales(DateTime(2015, 10, 24, 11, 10), 2),
      TTotalsales(DateTime(2015, 10, 24, 11, 30), 8),
      TTotalsales(DateTime(2015, 10, 24, 12, 10), 4),
      TTotalsales(DateTime(2015, 10, 24, 13, 10), 0),
      TTotalsales(DateTime(2015, 10, 24, 15, 10), 6),
      TTotalsales(DateTime(2015, 10, 24, 18, 10), 5),
      TTotalsales(DateTime(2015, 10, 24, 19, 10), 7),
      TTotalsales(DateTime(2015, 10, 24, 22, 10), 3),
    ];

    final List<MTotalsales> salesDataMonthly = [
      MTotalsales(DateTime(2015, 1, 24, 11, 10), 350),
      MTotalsales(DateTime(2015, 2, 24, 11, 30), 338),
      MTotalsales(DateTime(2015, 3, 24, 12, 10), 244),
      MTotalsales(DateTime(2015, 4, 24, 13, 10), 450),
      MTotalsales(DateTime(2015, 5, 24, 11, 10), 312),
      MTotalsales(DateTime(2015, 6, 24, 11, 30), 328),
      MTotalsales(DateTime(2015, 7, 24, 12, 10), 514),
      MTotalsales(DateTime(2015, 8, 24, 13, 10), 240),
      MTotalsales(DateTime(2015, 9, 24, 15, 10), 326),
      MTotalsales(DateTime(2015, 10, 24, 18, 10), 398),
      MTotalsales(DateTime(2015, 11, 24, 19, 10), 297),
      MTotalsales(DateTime(2015, 12, 24, 22, 10), 303),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const MyDrawer(),
      appBar: myAppBar('Sales'),
      // backgroundColor: Theme.of(context).canvasColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      if (flag == 0) {
                        monthlySales = true;
                        flag = 1;
                      } else {
                        monthlySales = false;
                        flag = 0;
                      }
                    });
                  },
                  child: monthlySales
                      ? "Monthly sales"
                          .text
                          .xl3
                          .semiBold
                          .gray600
                          .make()
                          .px20()
                          .py16()
                      : "Today's sales"
                          .text
                          .xl3
                          .semiBold
                          .gray600
                          .make()
                          .px20()
                          .py16()),
              sales(context, monthlySales ? salesDataMonthly : salesDataToday)
                  .cornerRadius(5)
                  .pSymmetric(v: 8),
              "Items sold today".text.xl2.semiBold.gray600.make().p16(),
              Card(
                child: SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: 8,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: ((context, index) => SizedBox(
                          height: 60,
                          child: ListTile(
                            title: Text(
                              itemSoldToday.keys.elementAt(index),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700]),
                            ),
                            subtitle: Text(
                              "Items sold today :${itemSoldToday.values.elementAt(index)}",
                            ),
                          ),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ).p16(),
        ),
      ),
    );
  }

  Card sales(BuildContext context, sales) {
    return Card(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              'Total sales'.text.xl.gray600.bold.make(),
              const Spacer(),
              monthlySales
                  ? '4100'.text.xl2.bold.blue500.make()
                  : '32'.text.xl2.bold.blue500.make(),
              ' items'.text.headline6(context).gray600.make(),
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
                  intervalType: monthlySales
                      ? DateTimeIntervalType.months
                      : DateTimeIntervalType.hours,
                  interval: 2),
              tooltipBehavior: TooltipBehavior(
                enable: true,
              ),
              series: <ChartSeries>[
                // Renders line chart
                monthlySales
                    ? LineSeries<MTotalsales, DateTime>(
                        color: Colors.blue,
                        name: 'Sales',
                        dataSource: sales,
                        markerSettings: const MarkerSettings(isVisible: true),
                        xValueMapper: (MTotalsales sales, _) => sales.month,
                        yValueMapper: (MTotalsales sales, _) => sales.sales)
                    : LineSeries<TTotalsales, DateTime>(
                        color: Colors.blue,
                        name: 'Sales',
                        dataSource: sales,
                        markerSettings: const MarkerSettings(isVisible: true),
                        xValueMapper: (TTotalsales sales, _) => sales.hour,
                        yValueMapper: (TTotalsales sales, _) => sales.sales),
              ]).h(250),
        ],
      ).p8(),
    );
  }
}

class TCaloriesBurntData {
  TCaloriesBurntData(this.hour, this.sales);
  final DateTime hour;
  final double sales;
}

class TCaloriesIntakeData {
  TCaloriesIntakeData(this.hour, this.sales);
  final DateTime hour;
  final double sales;
}

class TTotalsales {
  TTotalsales(this.hour, this.sales);
  final DateTime hour;
  final double sales;
}

class MCaloriesBurntData {
  MCaloriesBurntData(this.month, this.sales);
  final DateTime month;
  final double sales;
}

class MCaloriesIntakeData {
  MCaloriesIntakeData(this.month, this.sales);
  final DateTime month;
  final double sales;
}

class MTotalsales {
  MTotalsales(this.month, this.sales);
  final DateTime month;
  final double sales;
}
