// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:stockpile/drawer.dart';
import 'package:stockpile/widgets/all_widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: const MyDrawer(),
      appBar: myAppBar('StockPile'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox().h(20),
              DateFormat('EEEE, dd MMMM')
                  .format(DateTime.now())
                  .toString()
                  .text
                  .xl
                  .bold
                  .makeCentered(),
              "Today's stock".text.xl3.semiBold.gray600.make().px20().py16(),
              routineListView(),
            ],
          ),
        ),
      ),
    );
  }
}

ListView routineListView() {
  return ListView.builder(
    itemCount: choices.length,
    itemBuilder: (context, index) =>
        SelectCard(choice: choices[index], index: index),
    // scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: const ScrollPhysics(),
  );
}

class Choice {
  const Choice({
    this.appBattitle,
    required this.itemCount,
    required this.title,
    required this.caption,
    this.buttonTitle,
    required this.icon,
  });
  final String title;
  final String caption;
  final String? buttonTitle;
  final int itemCount;
  final FaIcon icon;
  final String? appBattitle;
}

List<Choice> choices = const <Choice>[
  Choice(
      title: 'Smartphones',
      caption: '7 hr 5 min',
      buttonTitle: 'View',
      icon: FaIcon(
        FontAwesomeIcons.mobile,
        color: Colors.red,
        size: 26,
      ),
      appBattitle: 'Sleep',
      // nav: navigatorKey.currentState!.pushNamed(MyRoutes.viewaddrecordRoute),
      itemCount: 30),
  Choice(
    title: 'Refrigerator',
    caption: '600',
    buttonTitle: 'Add',
    icon: FaIcon(
      FontAwesomeIcons.kitchenSet,
      color: Colors.green,
      size: 26,
    ),
    itemCount: 15,
    appBattitle: 'Diet',
  ),
  Choice(
    title: 'AC',
    caption: '56.9',
    buttonTitle: 'Record',
    icon: FaIcon(
      FontAwesomeIcons.wind,
      color: Colors.red,
      size: 26,
    ),
    itemCount: 20,
    appBattitle: 'Weight Update',
  ),
  Choice(
    title: 'Washing Machine',
    caption: '300',
    buttonTitle: 'Record',
    icon: FaIcon(
      FontAwesomeIcons.shirt,
      color: Colors.purple,
      size: 26,
    ),
    itemCount: 20,
  ),
  Choice(
    title: 'TV',
    caption: '40',
    buttonTitle: 'View',
    icon: FaIcon(
      FontAwesomeIcons.television,
      color: Colors.blue,
      size: 26,
    ),
    itemCount: 42,
  ),
  Choice(
    title: 'Laptops',
    caption: '3210 steps',
    buttonTitle: 'View',
    icon: FaIcon(
      FontAwesomeIcons.laptop,
      color: Colors.grey,
      size: 26,
    ),
    itemCount: 50,
  ),
  Choice(
      title: 'Microwave Ovan',
      caption: '120',
      buttonTitle: 'Record',
      icon: FaIcon(
        FontAwesomeIcons.bowlRice,
        color: Colors.red,
        size: 26,
      ),
      itemCount: 20),
  Choice(
      title: 'Accessories',
      caption: '76',
      buttonTitle: 'Record',
      icon: FaIcon(
        FontAwesomeIcons.hardDrive,
        color: Colors.orange,
        size: 26,
      ),
      itemCount: 100),
];

const List<Widget> pages = <Widget>[
  // SleepRoutine(),
  // FoodRoutine(),
  // Weight(),
  // WaterRoutine(),
  // ExerciseRoutine(),
  // Steps(),
  // BloodPressure(),
  // BloodGlucose(),
];

class SelectCard extends StatefulWidget {
  const SelectCard({Key? key, required this.choice, required this.index})
      : super(key: key);
  final Choice choice;
  final int index;
  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  // final TextStyle textStyle = Theme.of(context)./;
  int itemCount = 20;

  @override
  Widget build(BuildContext context) {
    // final screenWidth = (MediaQuery.of(context).size.width / 100)

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  widget.choice.icon,
                  widget.choice.title.text.xl.bold.make().pOnly(left: 10),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (itemCount == 0) ...{
                    "No Stock Available".text.xl.red400.bold.make(),
                  } else ...{
                    "Stock : $itemCount".text.xl.gray600.bold.make(),
                  },
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),

          const Spacer(),
          Container(
            color: Colors.grey[600],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                itemCount != 0
                    ? IconButton(
                        icon: const Icon(
                          Icons.remove,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () => setState(() => itemCount--),
                      )
                    : Container().p(8),
                Container(
                        color: Colors.white,
                        child: itemCount
                            .toString()
                            .text
                            .xl
                            .black
                            .make()
                            .px(8)
                            .py(4))
                    .cornerRadius(5),
                IconButton(
                    icon: const Icon(
                      Icons.add,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () => setState(() => itemCount++))
              ],
            ),
          ).cornerRadius(25).h(50),
          // widget.choice.caption.text.bold.xl3.make(),
        ],
      ).pSymmetric(h: 16, v: 12),
    ).cornerRadius(6).pSymmetric(v: 8, h: 16).h(100);
  }
}
