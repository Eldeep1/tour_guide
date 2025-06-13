import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/providers/chat_messages_provider.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/providers/page_variables_provider.dart';

import 'messages.dart';
import 'send_message_form_field_builder.dart';

class NewChatPageBodyBuilder extends ConsumerStatefulWidget {
  const NewChatPageBodyBuilder({super.key});

  @override
  ConsumerState<NewChatPageBodyBuilder> createState() => _NewChatPageBodyBuilderState();
}

class _NewChatPageBodyBuilderState extends ConsumerState<NewChatPageBodyBuilder> with WidgetsBindingObserver {
  final ScrollController controller = ScrollController();
  bool _locationPermissionChecked = false;
  bool _waitingForLocationService = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Add short delay
      await Future.delayed(const Duration(milliseconds: 300));
      if (!_locationPermissionChecked) {
        _checkLocationPermission();
      }
    });
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // When app comes back to foreground after opening settings
    if (state == AppLifecycleState.resumed && _waitingForLocationService) {
      _waitingForLocationService = false;
      _continueLocationCheck();
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatList = ref.watch(chatDataProvider);

    ref.listen(chatDataProvider, (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.hasClients) {
          controller.jumpTo(controller.position.maxScrollExtent);
        }
      });
    });

    return Column(
      children: [
        Expanded(
          child: chatList.when(
            data: (messages) {
              if (messages.isEmpty) {
                return const Center(child: Text("Start a new chat..."));
              }

              return ListView.builder(
                controller: controller,
                padding: const EdgeInsets.all(8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];

                  if (message.response == null) {
                    return Column(
                      children: [
                        promptMessageBuilder(message.prompt!, byteImage: message.byteImage, linkImage: message.linkImage),
                        answerMessageBuilder(message: "Loading Response", isLoading: true),
                      ],
                    );
                  }

                  if (message.response!.startsWith("Error:")) {
                    return Column(
                      children: [
                        promptMessageBuilder(message.prompt ?? "", byteImage: message.byteImage, linkImage: message.linkImage),
                        errorMessageBuilder(message.response!),
                      ],
                    );
                  }

                  // Normal message
                  return Column(
                    children: [
                      promptMessageBuilder(message.prompt ?? "", byteImage: message.byteImage, linkImage: message.linkImage),
                      answerMessageBuilder(message: message.response ?? ""),
                    ],
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) {
              return SingleChildScrollView(child: Center(child: Text("Error: $error")));
            },
          ),
        ),
        SendMessageFormFieldBuilder(),
      ],
    );
  }

  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;


    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      // Permission already granted, skip dialog and continue
    } else {
      // Show dialog and wait for user response
      bool? userAccepted = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Location Service"),
            content: const Text(
              "The application needs your location to answer your questions based on your current location.",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel", style: TextStyle(color: Colors.black)),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Grant Location", style: TextStyle(color: Colors.black)),
              ),
            ],
          );
        },
      );

      if (userAccepted != true) {
        return Future.error('User declined location access');
      }
    }

    // Continue with service enabled check
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Show dialog to ask to enable location service
      bool? shouldOpenSettings = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Enable Location Services"),
            content: const Text("Location services are disabled. Please enable them in settings to continue."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Open Settings"),
              ),
            ],
          );
        },
      );

      if (shouldOpenSettings == true) {
        _waitingForLocationService = true;
        await Geolocator.openLocationSettings();
        return Future.error('Waiting for location service to be enabled');
      } else {
        return Future.error('Location services are disabled.');
      }
    }

    // Re-check permissions after possible dialog
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      bool? shouldOpenAppSettings = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Location Permission Required"),
            content: const Text("Location permissions are permanently denied. Please enable them in app settings."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Open App Settings"),
              ),
            ],
          );
        },
      );

      if (shouldOpenAppSettings == true) {
        await Geolocator.openAppSettings();
      }

      return Future.error('Location permissions are permanently denied');
    }

    // Finally get the position
    return await Geolocator.getCurrentPosition();
  }


  Future<void> _checkLocationPermission() async {
    try {
      final position = await determinePosition(context);
      if (mounted) {
        ref.read(messageRequestProvider).longitude = position.longitude;
        ref.read(messageRequestProvider).latitude = position.latitude;
        setState(() {
          _locationPermissionChecked = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _locationPermissionChecked = true;
        });
      }
    }
  }

  Future<void> _continueLocationCheck() async {
    try {
      // Continue with the location check after returning from settings
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {

        return;
      }

      // Now check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return;
      }

      // Get the position
      final position = await Geolocator.getCurrentPosition();
      if (mounted) {
        ref.read(messageRequestProvider).longitude = position.longitude;
        ref.read(messageRequestProvider).latitude = position.latitude;
        setState(() {
          _locationPermissionChecked = true;
        });
      }
    } catch (e) {
      if (mounted) {

      }
    }
  }

}