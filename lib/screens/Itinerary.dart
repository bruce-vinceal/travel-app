import 'package:flutter/material.dart';
import 'package:travel_app/screens/AddItinerary.dart';
import 'package:travel_app/screens/EditItinerary.dart';

class Itinerary extends StatefulWidget {
  static const String routeName = "itinerary";
  const Itinerary ({super.key});

  @override
  State<Itinerary> createState() => _ItineraryState();
}

class _ItineraryState extends State<Itinerary> {
  List<String> posts = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Itinerary"),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: posts.isEmpty
          ? const Center(
            child: Text(
              'No itineraries added. Your itineraries will be displayed here. Hit the "+" button to add an itinerary.',
              textAlign: TextAlign.center,
            ),
          )
          : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        title: Text(posts[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editItinerary(context, index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () => _addItinerary(context),
          child: const Icon(Icons.add),
        ),

      ),
    );
  }

  void _editItinerary(BuildContext context, int index) {
    List<String> itineraryDetails = posts[index].split('\n');
    String tripName = itineraryDetails[0].substring('Trip Name: '.length);;
    String country = itineraryDetails[1].substring('Country: '.length);
    String startDate = itineraryDetails[2].substring('Start Date: '.length);
    String endDate = itineraryDetails[3].substring('End Date: '.length);
    String purpose = itineraryDetails[4].substring('Purpose: '.length);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditItinerary(
          tripName: tripName,
          country: country,
          startDate: startDate,
          endDate: endDate,
          purpose: purpose,
          onDelete: () {
            setState(() {
              int index = posts.indexWhere(
                    (post) => post.contains(tripName),);
              if (index != -1) {
                posts.removeAt(index);
              }
            });
          },
        ),
      ),
    ).then((updatedDetails) {
      if (updatedDetails != null) {
        setState(() {
          posts[index] = updatedDetails;
        });
      }
    });
  }

  void _addItinerary(BuildContext context) {
    Navigator.pushNamed(context, AddItinerary.routeName).then((newItinerary) {
      if (newItinerary != null && newItinerary is String) {
        setState(() {
          posts.add(newItinerary);
        });
      }
    });
  }

}
