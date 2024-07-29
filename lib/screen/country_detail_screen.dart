import 'package:flutter/material.dart';

class CountryDetailScreen extends StatefulWidget {

  final String name, countryImage, tag;
  final int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test, todayDeaths;

  const CountryDetailScreen({
    super.key,

    required this.name,
    required this.countryImage,
    required this.tag,

    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.test,
    required this.todayRecovered,
    required this.todayDeaths,
  });

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          widget.name,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500
          ),
        ),
      ),

      body: Stack(
        children: [

          Positioned(
            width: MediaQuery.of(context).size.width - 30,
            left: 15.0,
            top: MediaQuery.of(context).size.height * 0.15,
            child: Card(
              color: Colors.grey.shade800,
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customRow('Total Cases', widget.totalCases),
                  customRow('Total Recovered', widget.totalRecovered),
                  customRow('Total Deaths', widget.totalDeaths),
                  customRow('Active', widget.active),
                  customRow('Critical', widget.critical),
                  customRow('Tests', widget.test),
                  customRow('Today Recovered', widget.todayRecovered),
                  customRow('Today Deaths', widget.totalDeaths),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [

                const SizedBox(height: 35),

                Hero(
                  tag: widget.tag,
                  child: Container(
                    width: 150,
                    height: 75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.countryImage)
                      )
                    ),
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }

  customRow(String title, value) {
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
                value.toString(),
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
