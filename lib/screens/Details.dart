import 'package:flutter/material.dart';
import 'package:travel_app/models/Post.dart';

class Details extends StatelessWidget {
  static const String routeName = "details";
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final Country selectedCountry = ModalRoute.of(context)!.settings.arguments as Country;
    const TextStyle Header = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    const TextStyle SubHeader = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.black12,
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    selectedCountry.flags["png"],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(selectedCountry.name["common"], style: Header,),
            const SizedBox(
              height: 10.0,
            ),
            const Divider(),
            const SizedBox(
              height: 10.0,
            ),
            Text('Population: ${selectedCountry.population}', style: SubHeader),
            Text('Region: ${selectedCountry.region}', style: SubHeader),
            Text('Capital: ${selectedCountry.capital.join(', ')}', style: SubHeader),
            Text('Continent: ${selectedCountry.continents.join(', ')}', style: SubHeader),
          ],
        ),
      ),
    );
  }
}
