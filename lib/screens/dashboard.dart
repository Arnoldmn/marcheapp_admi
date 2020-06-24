import 'package:flutter/material.dart';
import 'package:marcheappadmi/providers/app_state.dart';
import 'package:marcheappadmi/screens/add_product.dart';
import 'package:marcheappadmi/screens/small_card.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<charts.Series<Task, String>> _seriesPieData;

  _getData() {
    var piedata = [
      new Task('Girls', 35.8, Color(0xff3366cc)),
      new Task('Women', 8.3, Color(0xff990099)),
      new Task('Pants', 10.8, Color(0xff109618)),
      new Task('Formal', 15.6, Color(0xfffdbe19)),
      new Task('Shoes', 19.2, Color(0xffff9900)),
      new Task('Other', 10.3, Color(0xffdc3912)),
    ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskValue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorVal),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskValue}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesPieData = List<charts.Series<Task, String>>();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
          child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(1.0, 1.0),
                  blurRadius: 4)
            ]),
            width: 50,
            child: Column(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                InkWell(
                  onTap: () {
                    appState.changeScreen(Screen.DASH);
                  },
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      RotatedBox(
                        quarterTurns: -1,
                        child: Text(
                          'Dashboard',
                        ),
                      ),
                      Visibility(
                        visible: appState.selectedScreen == Screen.DASH,
                        child: Wrap(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 68,
                              width: 5,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    appState.changeScreen(Screen.PRODUCTS);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AddProduct()));
                  },
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      RotatedBox(
                        quarterTurns: -1,
                        child: Text(
                          'Products',
                        ),
                      ),
                      Visibility(
                        visible: appState.selectedScreen == Screen.PRODUCTS,
                        child: Wrap(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 58,
                              width: 5,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    appState.changeScreen(Screen.CATEGORIES);
                  },
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      RotatedBox(
                        quarterTurns: -1,
                        child: Text(
                          'Categories',
                        ),
                      ),
                      Visibility(
                        visible: appState.selectedScreen == Screen.CATEGORIES,
                        child: Wrap(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 68,
                              width: 5,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    appState.changeScreen(Screen.BRANDS);
                  },
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      RotatedBox(
                        quarterTurns: -1,
                        child: Text(
                          'Brands',
                        ),
                      ),
                      Visibility(
                        visible: appState.selectedScreen == Screen.BRANDS,
                        child: Wrap(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 48,
                              width: 5,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      appState.changeScreen(Screen.ORDERS);
                    },
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        RotatedBox(
                          quarterTurns: -1,
                          child: Text(
                            'Orders',
                          ),
                        ),
                        Visibility(
                          visible: appState.selectedScreen == Screen.ORDERS,
                          child: Wrap(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 48,
                                width: 5,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.open_in_new),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 10, bottom: 10, right: 10),
                child: Card(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: 'Revenue\n',
                            style: TextStyle(fontSize: 35, color: Colors.grey)),
                        TextSpan(
                          text: '\$1287.99',
                          style: TextStyle(
                              fontSize: 55,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SmallCard(
                    icon: Icons.person_outline,
                    title: 'Users',
                    value: 1265,
                    color1: Colors.blue,
                    color2: Colors.indigo,
                  ),
                  SmallCard(
                    icon: Icons.shopping_cart,
                    title: 'Orders',
                    value: 30,
                    color1: Colors.blue,
                    color2: Colors.indigo,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SmallCard(
                    icon: Icons.attach_money,
                    title: 'Sales',
                    value: 65,
                    color1: Colors.blue,
                    color2: Colors.indigo,
                  ),
                  SmallCard(
                    icon: Icons.shopping_basket,
                    title: 'Stock',
                    value: 230,
                    color1: Colors.blue,
                    color2: Colors.indigo,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sales per category',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[400],
                              offset: Offset(1.0, 1.0),
                              blurRadius: 4)
                        ]),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: ListTile(
                      title: charts.PieChart(
                        _seriesPieData,
                        animate: true,
                        animationDuration: Duration(seconds: 3),
                        behaviors: [
                          new charts.DatumLegend(
                            outsideJustification:
                                charts.OutsideJustification.endDrawArea,
                            horizontalFirst: false,
                            desiredMaxRows: 2,
                            cellPadding:
                                new EdgeInsets.only(right: 8.0, bottom: 8.0),
                          )
                        ],
                        defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 30,
                          arcRendererDecorators: [
                            new charts.ArcLabelDecorator(
                                labelPosition: charts.ArcLabelPosition.inside)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}

class Task {
  String task;
  double taskValue;
  Color colorVal;

  Task(this.task, this.taskValue, this.colorVal);
}
