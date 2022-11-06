import 'package:flutter/material.dart';
import 'package:stockpile/myhomepage.dart';
import 'package:stockpile/pandl.dart';
import 'package:stockpile/sales.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
              accountName: Text(
                'Team StockPile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text('stockpile@info.in')),
          ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: icons.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                title[index],
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              leading: icons[index],
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => classes[index]));
              },
            ),
          ),
        ],
      ),
    );
  }

  List<String> title = ['DashBoard', 'Sales', 'P/L report', 'Stock'];

  List<Widget> classes = [Dashboard(), Sales(), PandL(), Dashboard()];

  List<Icon> icons = const [
    Icon(
      Icons.dashboard_customize,
      size: 20,
    ),
    Icon(
      Icons.auto_graph,
      size: 20,
    ),
    Icon(
      Icons.money,
      size: 20,
    ),
    Icon(
      Icons.add_box,
      size: 20,
    )
  ];
}
