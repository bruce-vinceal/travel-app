import 'package:flutter/material.dart';
import 'package:travel_app/CustomTextFormField.dart';
import 'package:travel_app/PostTextField.dart';
import 'package:travel_app/PrimaryButton.dart';

class AddItinerary extends StatefulWidget {
  static const String routeName = "createItinerary";
  const AddItinerary({super.key});

  @override
  State<AddItinerary> createState() => _AddItineraryState();
}

class _AddItineraryState extends State<AddItinerary> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController tripNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Itinerary"),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          labelText: 'Trip Name',
                          hintText: 'Enter trip name',
                          iconData: null,
                          textInputType: TextInputType.text,
                          controller: tripNameController,
                          validator: (value) => value?.isEmpty ?? true ? 'Please enter the trip name' : null,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFormField(
                          labelText: 'Country to Visit',
                          hintText: 'Enter country',
                          iconData: null,
                          textInputType: TextInputType.text,
                          controller: countryController,
                          validator: (value) => value?.isEmpty ?? true ? 'Please enter the country to visit' : null,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFormField(
                          labelText: 'Trip Start Date',
                          hintText: 'Enter start date',
                          iconData: null,
                          textInputType: TextInputType.text,
                          controller: startDateController,
                          validator: (value) => value?.isEmpty ?? true ? 'Please enter the trip start date' : null,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFormField(
                          labelText: 'Trip End Date',
                          hintText: 'Enter End date',
                          iconData: null,
                          textInputType: TextInputType.text,
                          controller: endDateController,
                          validator: (value) => value?.isEmpty ?? true ? 'Please enter the trip end date' : null,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFormField(
                          labelText: 'Purpose for the Trip',
                          hintText: 'Enter purpose',
                          iconData: null,
                          textInputType: TextInputType.multiline,
                          controller: purposeController,
                          validator: (value) => value?.isEmpty ?? true ? 'Please enter the purpose of the trip' : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: PrimaryButton(
                  text: 'Create Itinerary',
                  iconData: Icons.post_add,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      String itineraryDetails =
                          'Trip Name: ${tripNameController.text}\n'
                          'Country: ${countryController.text}\n'
                          'Start Date: ${startDateController.text}\n'
                          'End Date: ${endDateController.text}\n'
                          'Purpose: ${purposeController.text}';
                      Navigator.pop(context, itineraryDetails);
                    }
                  },
                ),
              )
            ),
          ],
        ),
      ),
    );
  }}
