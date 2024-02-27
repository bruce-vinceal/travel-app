import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:http/http.dart';
import 'package:travel_app/models/Post.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/screens/Details.dart';
import 'package:travel_app/screens/Settings.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = "dashboard";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Country> countries = [];

  @override
  void initState() {
    super.initState();
    loadCountryAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(onPressed: settings, icon: const Icon(Icons.settings),)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child:
        GroupedListView<dynamic, String>(
          elements: countries,
          groupBy: (element) => element.name['common'][0].toUpperCase(),
          groupComparator: (value1, value2) => value1.compareTo(value2),
          itemComparator: (item1, item2) => item1.name['common'].compareTo(item2.name['common']),
          order: GroupedListOrder.ASC,
          useStickyGroupSeparators: false,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          itemBuilder: (context, element) {
            return Card(
              elevation: 8.0,
              margin:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              ),
              child: SizedBox(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  leading: CircleAvatar(
                    radius: 50, // Replace with your desired radius
                    backgroundImage: NetworkImage(element.flags["png"]),
                  ),
                  title: Text(element.name['common']),
                  trailing: IconButton(
                    onPressed: () => details(element),
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            );
            // return CountryCard(country: element);
          },
        ),
      ),
    );
  }

  loadCountryAPI() async {
    Response response = await http.get(Uri.parse('https://restcountries.com/v3.1/independent?status=true'));

    List<dynamic> data = jsonDecode(response.body);
    List<Country> countryList = data.map((country) => Country.fromJson(country)).toList();

    setState(() {
      countries = countryList;
    });
  }

  void details(Country selectedCountry) {
    Navigator.pushNamed(
      context,
      Details.routeName,
      arguments: selectedCountry,
    );
  }

  void settings() {
    Navigator.pushNamed(context, Settings.routeName);
  }

}
