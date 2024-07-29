import 'package:covid_19_tracker_app/model/world_state_model.dart';
import 'package:covid_19_tracker_app/screen/countries_list.dart';
import 'package:covid_19_tracker_app/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin {

  late AnimationController _animationController;


  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this
    )..repeat();
  }

  final colorList = <Color> [
    Colors.blueAccent,
    const Color(0xff1aa260),
    // Colors.green.shade700,
    const Color(0xffde5246),
    // Colors.red,
  ];

  @override
  Widget build(BuildContext context) {

    StatesServices statesServices = StatesServices();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),

              FutureBuilder(
                future: statesServices.fetchWorldStatesRecord(),
                builder: (BuildContext context, AsyncSnapshot<WorldStateModel> snapshot) {

                  if(!snapshot.hasData) {
                    return Expanded(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _animationController,
                      ),
                    );
                  }

                  else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total': double.parse(snapshot.data!.cases!.toString()),
                            'Recovered': double.parse(snapshot.data!.recovered!.toString()),
                            'Deaths': double.parse(snapshot.data!.deaths!.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                          chartType: ChartType.ring,
                          colorList: colorList,
                          animationDuration: const Duration(milliseconds: 1200),
                          chartRadius: MediaQuery.of(context).size.width / 2.5,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            color: Colors.grey.shade800,
                            child:Column(
                              children: [
                                customList('Total', snapshot.data!.cases!.toString()),
                                customList('Deaths', snapshot.data!.deaths!.toString()),
                                customList('Recovered', snapshot.data!.recovered!.toString()),
                                customList('Active', snapshot.data!.active!.toString()),
                                customList('Critical', snapshot.data!.critical!.toString()),
                                customList('Today Deaths', snapshot.data!.todayDeaths!.toString()),
                                customList('Today Recovered', snapshot.data!.todayRecovered!.toString()),
                              ],
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CountriesList())
                            );
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: const Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        )
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  customList(String title, value) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      // padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),

          const Divider(),
        ],
      ),
    );
  }
}
