
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:restraunt/graph/barchart.dart';
import 'package:restraunt/graph/linechart.dart';
import 'package:restraunt/graph/piechart.dart';
import 'package:restraunt/Dashboard/queries.dart';
import '../../provider/dbaseProvider.dart';


class DDashboard extends StatefulWidget {
  final List<dynamic> graphs;

  const DDashboard({Key? key, required this.graphs}) : super(key: key);

  @override
  _DDashboardState createState() => _DDashboardState();
}

class _DDashboardState extends State<DDashboard> {
  late Queries queries;

  late List<List<String>> itemsList;
  late List<List<String>> durationsList;
  late List<List<String>> daysDivisionsList;
  late List<List<String>> categoryDivisionList;
  late List<List<String>> monthList;
  late List<List<String>> quarterList;
  late List<List<String>> productList2;
  late List<List<String>> categoryList2;

  late List<String> itemValues;
  late List<String> durationValues;
  late List<String> dayDivisionValues;
  late List<String> categoryDivision;
  late List<String> month;
  late List<String> quarter;
  late List<String> product2;
  late List<String> category2;

  final double defaultContainerWidth = 520.0;
  final int maxColumns = 3;

  @override
  void initState() {
    super.initState();
    fetch();
    print(widget.graphs.length);
    print('############');
    // Initialize lists for dropdown values
    itemsList = List.generate(
        widget.graphs.length, (index) => ['2023', '2022', '2021']);
    durationsList = List.generate(widget.graphs.length,
        (index) => ['Yearly', 'Semi Annually', 'Quarterly', 'Monthly']);
    daysDivisionsList = List.generate(
        widget.graphs.length, (index) => ['Jan to Jun', 'Jul to Dec']);
    categoryDivisionList = List.generate(
        widget.graphs.length, (index) => ['Total', 'P wise', 'C wise']);
    monthList = List.generate(
        widget.graphs.length,
        (index) => [
              'Jan',
              'Feb',
              'Mar',
              'Apr',
              'May',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec',
            ]);
    quarterList = List.generate(
        widget.graphs.length,
        (index) =>
            ['1st Quarter', '2st Quarter', '3st Quarter', '4st Quarter']);
    // Initialize lists for dropdown selected values
    itemValues =
        List.generate(widget.graphs.length, (index) => itemsList[index][0]);
    durationValues =
        List.generate(widget.graphs.length, (index) => durationsList[index][0]);
    dayDivisionValues = List.generate(
        widget.graphs.length, (index) => daysDivisionsList[index][0]);
    categoryDivision = List.generate(
        widget.graphs.length, (index) => categoryDivisionList[index][0]);
    month = List.generate(widget.graphs.length, (index) => monthList[index][0]);
    quarter =
        List.generate(widget.graphs.length, (index) => quarterList[index][0]);
    queries = Queries();
    categoryList2 = List.generate(
        widget.graphs.length,
        (index) =>
            ['1st Quarter', '2st Quarter', '3st Quarter', '4st Quarter']);
    category2 =
        List.generate(widget.graphs.length, (index) => categoryList2[index][0]);
    productList2 = List.generate(
        widget.graphs.length,
        (index) =>
            ['1st Quarter', '2st Quarter', '3st Quarter', '4st Quarter']);
    product2 =
        List.generate(widget.graphs.length, (index) => categoryList2[index][0]);

    fetchCategoryAndProducts();
  }

  Future<void> fetchCategoryAndProducts() async {
    List<String> categoryList = [];
    List<String> productList = [];
    dbaseProvider db = new dbaseProvider();
    List<Map<String, dynamic>> cl =
        await db.fetchData('Select distinct Category from pokemon;');
    print(cl);
    for (var product in cl) {
      String productName = product["Category"];
      if (productName != null) {
        categoryList.add(productName);
      }
    }

    List<Map<String, dynamic>> pl =
        await db.fetchData('Select distinct productNames from pokemon;');
    print(pl);
    for (var product in pl) {
      String productName = product["productNames"];
      if (productName != null) {
        productList.add(productName);
      }
    }

    setState(() {
      setState(() {
        productList2 =
            List.generate(widget.graphs.length, (index) => [...productList]);
        product2 = List.generate(
            widget.graphs.length, (index) => productList2[index][0]);
        categoryList2 =
            List.generate(widget.graphs.length, (index) => [...categoryList]);
        category2 = List.generate(
            widget.graphs.length, (index) => categoryList2[index][0]);
      });
    });
  }

  Future<void> fetchGraph1(String q, int index) async {
    dbaseProvider db = new dbaseProvider();
    List<String> tempss = [];
    List<double> tempss2 = [];
    List<Map<String, dynamic>> itemsData = await db.fetchData(q);

    if (index == 0) {
      List<String> food = [
        'Pizza',
        'Burger',
        'Sushi',
        'Pasta',
        'Taco',
        'Salad',
        'Steak',
        'Curry',
        'Sandwich',
        'Soup',
        'Rice',
        'Noodles',
        'Fries',
        'Chicken',
        'Fish',
        'Shrimp',
        'Burrito',
        'Wrap',
        'Donut',
        'Cake'
      ];
      List<String> shuffledFood = List.from(food)..shuffle();
      List<String> selectedFood = shuffledFood.toSet().take(5).toList();
      tempss.addAll(selectedFood);
      for (var item in itemsData) {
        tempss2.add(item['TotalSales']);
      }
    } else if (index == 1) {
      List<String> food = [
        'Italian',
        'American',
        'Japanese',
        'Indian',
        'Mexican',
        'Chinese',
        'Thai',
        'French',
        'Greek',
        'Spanish',
        'Mediterranean',
        'Vietnamese',
        'Korean',
        'Turkish',
        'Brazilian',
        'Lebanese',
        'German',
        'British',
        'Moroccan',
        'Russian'
      ];
      List<String> shuffledFood = List.from(food)..shuffle();
      List<String> selectedFood = shuffledFood.toSet().take(5).toList();
      tempss.addAll(selectedFood);
      for (var item in itemsData) {
        tempss2.add(item['TotalSales']);
      }
    } else if (index == 3) {
      List<String> food = [
        'Food',
        'Labor',
        'Rent',
        'Utilities',
        'Insurance',
        'Marketing',
        'Maintenance',
        'Cleaning',
        'Supplies',
        'Tableware',
        'Technology',
        'Taxes',
        'Interest',
        'Services',
        'Training',
        'Waste',
        'Repairs',
        'Miscellaneous'
      ];

      List<String> shuffledFood = List.from(food)..shuffle();
      List<String> selectedFood = shuffledFood.toSet().take(5).toList();
      tempss.addAll(selectedFood);
      for (var item in itemsData) {
        tempss2.add(item['TotalExpenses']);
      }
    } else if (index == 4 || index == 5) {
      List<String> food = [
        'John',
        'Emma',
        'Michael',
        'Sophia',
        'William',
        'Olivia',
        'James',
        'Ava',
        'Alexander',
        'Mia',
        'Ethan',
        'Charlotte',
        'Daniel',
        'Amelia',
        'Matthew',
        'Harper',
        'David',
        'Evelyn',
        'Andrew',
        'Abigail'
      ];

      List<String> shuffledFood = List.from(food)..shuffle();
      List<String> selectedFood = shuffledFood.toSet().take(5).toList();
      tempss.addAll(selectedFood);
      for (var item in itemsData) {
        ;
        var totalExpenses = item['TotalPurchases'];
        tempss2.add(totalExpenses.toDouble());
      }
    } else if (index == 7 || index == 8) {
      for (var item in itemsData) {
        var totalExpenses = item['TotalSales'];
        tempss2.add(totalExpenses.toDouble());
      }
      while (tempss2.length < 12) {
        tempss2.add(0.0);
      }
      setState(() {
        widget.graphs[index] = LineGraph(xdataList: const [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ], ydataList: tempss2);
      });
    } else if (index == 9) {
      for (var item in itemsData) {
        var totalExpenses = item['Profit'];
        tempss2.add(totalExpenses.toDouble());
      }
      while (tempss2.length < 12) {
        tempss2.add(0.0);
      }
      setState(() {
        widget.graphs[index] = LineGraph(xdataList: const [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ], ydataList: tempss2);
      });
    }
    print(tempss);
    print(tempss2);
    if (index <= 6) {
      setState(() {
        widget.graphs[index] =
            MyPieChart(labelList: tempss, valueList: tempss2);
      });
    }
  }

  Future<void> fetch() async {
    dbaseProvider db = new dbaseProvider();
    // Fetch data for items list
    List<String> tempss = [];
    List<double> tempss2 = [];
    List<Map<String, dynamic>> itemsData = await db.fetchData(
        'SELECT p.productNames, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'2023\' GROUP BY t.HSN ORDER BY TotalSales DESC LIMIT 5;');

    for (var item in itemsData) {
      tempss.add(item['productNames']);
      tempss2.add(item['TotalSales']);
    }
    setState(() {
      widget.graphs[0] = MyPieChart(labelList: tempss, valueList: tempss2);
    });
    tempss = [];
    tempss2 = [];
    itemsData = await db.fetchData(
        'SELECT p.Category, SUM(t.amountPaid) AS TotalSales FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE substr(t.DateOfPurchase, -4) = \'2023\' GROUP BY p.Category ORDER BY TotalSales DESC LIMIT 5;');
    for (var item in itemsData) {
      tempss.add(item['Category']);
      tempss2.add(item['TotalSales']);
    }
    setState(() {
      widget.graphs[1] = MyPieChart(labelList: tempss, valueList: tempss2);
    });
    tempss = [];
    tempss2 = [];
    itemsData = await db.fetchData(
        'SELECT p.productNames, SUM(t.amountPaid) AS TotalExpenses FROM transactions t JOIN pokemon p ON t.HSN = p.HSN WHERE t.NatureOfPurchase = \'Sell\' AND substr(t.DateOfPurchase, -4) = \'2023\' GROUP BY p.productNames ORDER BY TotalExpenses DESC LIMIT 5;');
    for (var item in itemsData) {
      tempss.add(item['productNames']);
      tempss2.add(item['TotalExpenses']);
    }
    print("-------------------------------------------------------");
    print(itemsData);
    print(tempss2);
    setState(() {
      widget.graphs[3] = MyPieChart(labelList: tempss, valueList: tempss2);
    });
    tempss = [];
    tempss2 = [];
    itemsData = await db.fetchData(
        'SELECT CustomerName, COUNT(*) AS TotalPurchases FROM transactions WHERE NatureOfPurchase = \'Buy\' AND substr(DateOfPurchase, -4) = \'2023\' GROUP BY CustomerName ORDER BY TotalPurchases DESC LIMIT 5;');
    for (var item in itemsData) {
      tempss.add(item['CustomerName']);
      var totalExpenses = item['TotalPurchases'];
      tempss2.add(totalExpenses.toDouble());
    }
    setState(() {
      widget.graphs[4] = MyPieChart(labelList: tempss, valueList: tempss2);
    });
    tempss = [];
    tempss2 = [];
    itemsData = await db.fetchData(
        'SELECT CustomerName, COUNT(*) AS TotalPurchases FROM transactions WHERE NatureOfPurchase = \'Sell\' AND substr(DateOfPurchase, -4) = \'2023\' GROUP BY CustomerName ORDER BY TotalPurchases DESC LIMIT 5;');
    for (var item in itemsData) {
      tempss.add(item['CustomerName']);
      var totalExpenses = item['TotalPurchases'];
      tempss2.add(totalExpenses.toDouble());
    }
    setState(() {
      widget.graphs[5] = MyPieChart(labelList: tempss, valueList: tempss2);
    });
    List<double> profit = [];
    tempss2 = [];
    itemsData = await db.fetchData(
        'SELECT SUM(amountPaid) AS TotalSales FROM transactions WHERE substr(DateOfPurchase, -4) = \'2023\'  AND NatureOfPurchase = \'Sell\' GROUP BY substr(DateOfPurchase, 4, 2);');
    for (var item in itemsData) {
      var totalExpenses = item['TotalSales'];
      tempss2.add(totalExpenses.toDouble());
      profit.add(totalExpenses.toDouble());
    }

    int xx = 0;
    tempss = [];
    tempss2 = [];
    itemsData = await db.fetchData(
        'SELECT SUM(amountPaid) AS TotalSales FROM transactions WHERE substr(DateOfPurchase, -4) = \'2023\' AND NatureOfPurchase = \'Buy\' GROUP BY substr(DateOfPurchase, 4, 2);');
    for (var item in itemsData) {
      var totalExpenses = item['TotalSales'];
      tempss2.add(totalExpenses.toDouble());
      profit[xx] -= totalExpenses;
      xx++;
    }

    tempss = [];
    tempss2 = [];
    itemsData = await db.fetchData(
        'SELECT SUM(amountPaid) AS TotalSales FROM transactions WHERE substr(DateOfPurchase, -4) = \'2023\' AND (NatureOfPurchase = \'Buy\' OR NatureOfPurchase = \'Credit Note\') GROUP BY substr(DateOfPurchase, 4, 2);');

    for (var item in itemsData) {
      var totalExpenses = item['TotalSales'];
      tempss2.add(totalExpenses.toDouble());
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int columns = (screenWidth / defaultContainerWidth).floor();
    columns = columns > maxColumns ? maxColumns : columns;
    double containerWidth = (screenWidth - (columns + 1) * 20.0) / columns;

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        dbaseProvider db = new dbaseProvider();
        // await db.executeRawQuery('create table stock(name varchar(20),quantity int(5),ppu int(5));');
        await db.executeRawQuery('create table stocks(name varchar(20), quantity int(5),ppu int(5));');
        await db.executeRawQuery('insert into stocks values(\'Salt\',100,30)');
        var data = await db.fetchData('select * from stock');
        print(data);
      }),
      appBar: AppBar(
        title: const Text('Restaurant Finance Administration'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              spacing: 20.0, // Default horizontal spacing
              runSpacing: 20.0, // Default vertical spacing
              children: List.generate(widget.graphs.length, (index) {
                return Container(
                  width: containerWidth,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButton(
                              value: itemValues[index],
                              items: itemsList[index].map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  itemValues[index] = newValue!;
                                });
                              },
                              iconEnabledColor: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Visibility(
                            visible: !(index > 6 && index < 11),
                            child: Expanded(
                              child: DropdownButton(
                                value: durationValues[index],
                                items: durationsList[index].map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    durationValues[index] = newValue!;
                                  });
                                },
                                iconEnabledColor: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Visibility(
                            visible: durationValues[index] == 'Semi Annually',
                            child: Expanded(
                              child: DropdownButton(
                                value: dayDivisionValues[index],
                                items: daysDivisionsList[index]
                                    .map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dayDivisionValues[index] = newValue!;
                                  });
                                },
                                iconEnabledColor: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Visibility(
                            visible: durationValues[index] == 'Monthly',
                            child: Expanded(
                              child: DropdownButton(
                                value: month[index],
                                items: monthList[index].map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    month[index] = newValue!;
                                  });
                                },
                                iconEnabledColor: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Visibility(
                            visible: durationValues[index] == 'Quarterly',
                            child: Expanded(
                              child: DropdownButton(
                                value: quarter[index],
                                items: quarterList[index].map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    quarter[index] = newValue!;
                                  });
                                },
                                iconEnabledColor: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Visibility(
                            visible: index >= 6,
                            child: Expanded(
                              child: DropdownButton(
                                value: categoryDivision[index],
                                items: categoryDivisionList[index]
                                    .map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    categoryDivision[index] = newValue!;
                                  });
                                },
                                iconEnabledColor: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Visibility(
                            visible: categoryDivision[index] == 'C wise',
                            child: Expanded(
                              child: DropdownButton(
                                value: category2[index],
                                items: categoryList2[index].map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    category2[index] = newValue!;
                                  });
                                },
                                iconEnabledColor: Colors.grey,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: categoryDivision[index] == 'P wise',
                            child: Expanded(
                              child: DropdownButton(
                                value: product2[index],
                                items: productList2[index].map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    product2[index] = newValue!;
                                  });
                                },
                                iconEnabledColor: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Fetch data for graph at index
                          if (index == 0) {
                            String q = queries.graph1(
                                itemValues[0],
                                durationValues[0],
                                dayDivisionValues[0],
                                month[0],
                                quarter[0]);
                            if (q != 'Same') {
                              print(q);
                              fetchGraph1(q, index);
                            }
                          } else if (index == 1) {
                            String q = queries.graph2(
                                itemValues[1],
                                durationValues[1],
                                dayDivisionValues[1],
                                month[1],
                                quarter[1]);
                            if (q != 'Same') {
                              fetchGraph1(q, index);
                            }
                          } else if (index == 3) {
                            String q = queries.graph4(
                                itemValues[3],
                                durationValues[3],
                                dayDivisionValues[3],
                                month[3],
                                quarter[3]);
                            if (q != 'Same') {
                              fetchGraph1(q, index);
                            }
                          } else if (index == 4) {
                            String q = queries.graph5(
                                itemValues[4],
                                durationValues[4],
                                dayDivisionValues[4],
                                month[4],
                                quarter[4]);
                            if (q != 'Same') {
                              fetchGraph1(q, index);
                            }
                          } else if (index == 5) {
                            String q = queries.graph6(
                                itemValues[5],
                                durationValues[5],
                                dayDivisionValues[5],
                                month[5],
                                quarter[5]);
                            if (q != 'Same') {
                              fetchGraph1(q, index);
                            }
                          } else if (index == 7) {
                            String q = queries.graph8(itemValues[7],
                                categoryDivision[7], product2[7], category2[7]);
                            fetchGraph1(q, index);
                          } else if (index == 8) {
                            String q = queries.graph9(itemValues[8],
                                categoryDivision[8], product2[8], category2[8]);
                            fetchGraph1(q, index);
                          } else if (index == 9) {
                            String q = queries.graph10(itemValues[9],
                                categoryDivision[9], product2[9], category2[9]);
                            fetchGraph1(q, index);
                          }
                        },
                        child: const Text('Fetch Data'),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      _buildGraphContainer(
                        getTitle(widget.graphs[index],index),
                        'Pie Chart',
                        widget.graphs[index],
                        containerWidth,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGraphContainer(
    String title,
    String description,
    Widget graphWidget,
    double containerWidth,
  ) {
    return Container(
      width: containerWidth, // Adjusted container width
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: graphWidget,
                      );
                    },
                  );
                },
                child: const Text('Expand'),
              ),
            ],
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 300,
            child: graphWidget,
          ),
        ],
      ),
    );
  }
}

String getTitle(dynamic graph,int index) {
  if(index==0) return 'Top Dishes';
  else if(index==1) return 'Top cuisines';
  else if(index==2) return 'Share Holders';
  else if(index==3) return 'Top Expenses';
  else if(index==4) return 'Top Vendors';
  else if(index==5) return 'Top Customers';
  if (graph is LineGraph) {
    return 'Line Graph';
  } else if (graph is BarGraph) {
    return 'Bar Graph';
  } else if (graph is MyPieChart) {
    return 'Pie Chart';
  }
  return '';
}
List<dynamic> generateGraphs() {
  final List<dynamic> graphs = [];

  int n = 6;

  for (int i = 0; i < n; i++) {
    int graphType = 0;
    if (i <= 6)
      graphType = 2;
    else if (i <= 10)
      graphType = 0;
    else
      graphType = 1;

    if (graphType == 0) {
      graphs.add(LineGraph(
        xdataList: const ["Burrito", "Salad", "Soup", "Fries", "Steak"],
        ydataList: const [42.5, 67.8, 18.3, 93.7, 5.2],
      ));
    } else if (graphType == 1) {
      graphs.add(BarGraph(
        xdataList: const [
          "Moroccon",
          "Italian",
          "German",
          "Mexican",
          "Lebanese"
        ],
        ydataList: const [42.5, 67.8, 18.3, 93.7, 5.2],
      ));
    } else if (graphType == 2) {
      if (i == 0) {
        graphs.add(MyPieChart(
          labelList: const ["Burrito", "Salad", "Soup", "Fries", "Steak"],
          valueList: const [42.5, 67.8, 18.3, 93.7, 5.2],
        ));
      } else if (i == 1) {
        graphs.add(MyPieChart(
          labelList: const [
            "Moroccon",
            "Italian",
            "German",
            "Mexican",
            "Lebanese"
          ],
          valueList: const [42.5, 67.8, 18.3, 93.7, 5.2],
        ));
      } else if (i == 2) {
        graphs.add(MyPieChart(
          labelList: const ["Gaurav", "Kunal", "Aditya", "Virat", "Rohit"],
          valueList: const [89.0, 28.4, 23.5, 8.2, 5.2],
        ));
      } else if (i == 3) {
        graphs.add(MyPieChart(
          labelList: const [
            "Interest",
            "Tablewear",
            "Marketting",
            "Maintenances",
            "Taxes"
          ],
          valueList: const [42.5, 67.8, 18.3, 93.7, 5.2],
        ));
      } else if (i == 4) {
        graphs.add(MyPieChart(
          labelList: const ["Emma", "Mia", "John", "Ethan", "Daniel"],
          valueList: const [42.5, 67.8, 18.3, 93.7, 5.2],
        ));
      } else if (i == 5) {
        graphs.add(MyPieChart(
          labelList: const ["Matthew", "Amelia", "Andrew", "David", "Wiliam"],
          valueList: const [42.5, 67.8, 18.3, 93.7, 5.2],
        ));
      }
    }
  }

  return graphs;
}
