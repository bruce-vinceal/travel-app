import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/models/Post.dart';
import 'package:travel_app/screens/Details.dart';
import 'package:travel_app/SearchField.dart';

class Search extends StatefulWidget {
  static const String routeName = "search";
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  List<Country> searchResults = [];
  List<Country> countries = []; // Store all countries

  @override
  void initState() {
    super.initState();
    loadCountryAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child:
        Column(
          children: [
            SearchField(
              controller: _searchController,
              onClear: () {
                _searchController.clear();
                onSearchTextChanged('');
              },
              onChanged: onSearchTextChanged,
            ),
            Expanded(
              child: searchResults.isEmpty
                  ? Center(
                child: Text(_searchController.text.isEmpty
                    ? "Type to search a country"
                    : "No search results"),
              )
                  :ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
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
                          backgroundImage: NetworkImage(searchResults[index].flags["png"]),
                        ),
                        title: Text(searchResults[index].name['common']),
                        trailing: IconButton(
                          onPressed: () => details(searchResults[index]),
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        // If the search text is empty, display an empty list
        searchResults = [];
      } else {
        // If there is search text, filter countries based on the search text
        searchResults = countries
            .where((country) =>
            country.name['common']
                .toLowerCase()
                .contains(searchText.toLowerCase()))
            .toList();
      }
    });
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

}
