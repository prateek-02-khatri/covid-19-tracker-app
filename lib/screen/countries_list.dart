import 'dart:developer';

import 'package:covid_19_tracker_app/screen/country_detail_screen.dart';
import 'package:covid_19_tracker_app/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),

      body: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                TextFormField(
                  autofocus: false,
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        searchController.clear();
                      });
                    },
                    icon: const Icon(Icons.clear)
                  ),
                )
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: statesServices.fetchCountryData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade100,
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(

                              leading: Container(
                                width: 50,
                                height: 50,
                                color: Colors.white,
                              ),

                              title: Container(
                                width: 85,
                                height: 10,
                                color: Colors.white,
                              ),

                              subtitle: Container(
                                width: 85,
                                height: 10,
                                color: Colors.white,
                              ),

                            ),
                          );
                        }
                    )
                  );
                }
                else {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {

                        String search = searchController.text.toString();
                        String countryName = snapshot.data![index]['country'];

                        if (search.isEmpty) {
                          return customList(
                            snapshot: snapshot,
                            index: index,
                          );
                        } else if (countryName.toLowerCase().contains(search.toLowerCase())) {
                          return customList(
                            snapshot: snapshot,
                            index: index,
                          );
                        } else {
                          return Container();
                        }

                      }
                    ),
                  );
                }
              }
            )
          ),
        ],
      )
    );
  }

  ListTile customList({
    required snapshot,
    required index
  }) {
    return ListTile(
      onTap: () {

        FocusScope.of(context).unfocus();
        searchController.clear();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CountryDetailScreen(
            name: snapshot.data![index]['country'],
            countryImage: snapshot.data![index]['countryInfo']['flag'],
            tag: snapshot.data![index]['countryInfo']['flag'],
            totalCases: snapshot.data![index]['cases'],
            totalDeaths: snapshot.data![index]['deaths'],
            totalRecovered: snapshot.data![index]['recovered'],
            active: snapshot.data![index]['active'],
            critical: snapshot.data![index]['critical'],
            test: snapshot.data![index]['tests'],
            todayRecovered: snapshot.data![index]['todayRecovered'],
            todayDeaths: snapshot.data![index]['todayDeaths'],
          ))
        );
      },

      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),

      leading: Hero(
        tag: snapshot.data![index]['countryInfo']['flag'],
        child: Image(
          width: 50,
          height: 50,
          image: NetworkImage(
            snapshot.data![index]['countryInfo']['flag'],
          ),
        ),
      ),

      title: Text(
        snapshot.data![index]['country'],
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
      ),

      subtitle: Text(
        snapshot.data![index]['cases'].toString(),
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500
        ),
      ),
    );
  }

}
