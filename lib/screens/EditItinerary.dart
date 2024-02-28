import 'package:flutter/material.dart';
import 'package:travel_app/CustomTextFormField.dart';
import 'package:travel_app/PrimaryButton.dart';

class EditItinerary extends StatefulWidget {
  static const String routeName = "editItinerary";
  final String tripName;
  final String country;
  final String startDate;
  final String endDate;
  final String purpose;
  final void Function() onDelete; // Define onDelete callback


  const EditItinerary({
    super.key,
    required this.tripName,
    required this.country,
    required this.startDate,
    required this.endDate,
    required this.purpose,
    required this.onDelete,
  });

  @override
  State<EditItinerary> createState() => _EditItineraryState(onDelete: onDelete);
}

class _EditItineraryState extends State<EditItinerary> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController tripNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController purposeController = TextEditingController();

  final void Function() onDelete;
  _EditItineraryState({
    required this.onDelete,
  });

  @override
  void initState() {
    super.initState();
    // Set initial values based on the provided details
    tripNameController.text = widget.tripName;
    countryController.text = widget.country;
    startDateController.text = widget.startDate;
    endDateController.text = widget.endDate;
    purposeController.text = widget.purpose;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Itinerary"),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                child: Column(
                children: [
                PrimaryButton(
                  text: 'Save Changes',
                  iconData: Icons.save,
                  onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Form is valid, process the data
                    String updatedItineraryDetails =
                    'Trip Name: ${tripNameController.text}\n'
                    'Country: ${countryController.text}\n'
                    'Start Date: ${startDateController.text}\n'
                    'End Date: ${endDateController.text}\n'
                    'Purpose: ${purposeController.text}';

                    // Pass the updated details back to the Dashboard page
                    Navigator.pop(context, updatedItineraryDetails);
                    }
                  },
                ),
                  const SizedBox(height: 16.0),
                PrimaryButton(
                  text: 'Delete Itinerary',
                  iconData: Icons.delete,
                  onPressed: () => _showDeleteConfirmation(context),
                ),
                ],
                )
                )
              ),
          ],
        )
      ),
    );
  }

  // Function to show the delete confirmation dialog
  Future<void> _showDeleteConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button for close the dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Itinerary'),
          content: const Text('Are you sure you want to delete this itinerary?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Keep Itinerary'),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog and proceed to delete
                Navigator.of(dialogContext).pop();
                _deleteItinerary(context);
              },
              child: const Text('Yes, delete'),
            ),
          ],
        );
      },
    );
  }

// Function to delete the itinerary and navigate back to the Dashboard
  void _deleteItinerary(BuildContext context) {
    // Close the Edit Itinerary page
    Navigator.pop(context);
    // Inform the Dashboard page to handle deletion
    onDelete();
  }
}
