import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


Future<Position> determinePosition(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Show dialog and wait for user response
  bool? userAccepted = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Location Service"),
        content: const Text(
          "The application needs your location to answer your questions based on your current location.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // User denied
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // User accepted
            },
            child: const Text("Grant Location"),
          ),
        ],
      );
    },
  );

  if (userAccepted != true) {
    return Future.error('User declined location access');
  }

  // Check location service
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are still disabled.');
    }
  }

  // Check permissions
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  // Finally get the position
  return await Geolocator.getCurrentPosition();
}
