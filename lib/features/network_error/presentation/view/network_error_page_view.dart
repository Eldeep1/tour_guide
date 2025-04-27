import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tour_guide/features/Authentication/widgets/main_button_builder.dart';

class NetworkErrorPageView extends ConsumerStatefulWidget {
  const NetworkErrorPageView({super.key});

  @override
  _NetworkErrorPageViewState createState() => _NetworkErrorPageViewState();
}

class _NetworkErrorPageViewState extends ConsumerState<NetworkErrorPageView> {
  bool _isConnected = false;
  bool _isLoading = true; // Flag to track the loading state

  @override
  void initState() {
    super.initState();
    _checkNetworkStatus();
  }

  // Check network connectivity
  Future<void> _checkNetworkStatus() async {
    // Show loading indicator
    setState(() {
      _isLoading = true;
    });

    // Check network connectivity and extract first element if it's a list
    var result = await Connectivity().checkConnectivity();

    // If result is a List<ConnectivityResult>, extract the first element
    if (result is List<ConnectivityResult>) {
      setState(() {
        _isConnected = result.isNotEmpty && result.first != ConnectivityResult.none;
        _isLoading = false;
      });
    } else if (result is ConnectivityResult) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
        _isLoading = false;
      });
    }
  }

  // Refresh button action
  void _refresh() {
    // Trigger network check again
    _checkNetworkStatus();
  }

  // Prevent back button press
  Future<bool> _onWillPop() async {
    return false; // Prevent back navigation
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Disables back button navigation
      child: Scaffold(
        body: Center(
          child: _isLoading
              ? CircularProgressIndicator() // Show loading spinner while checking
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 30,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              Text(
                _isConnected
                    ? 'You are connected!'
                    : 'No network connection!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              mainButtonBuilder(
                "Refresh",
                context,
                _isConnected
                    ? () {
                  // When connected, navigate to the next screen and prevent back navigation
                  Navigator.pop(context);
                }
                    : _refresh, // Refresh if not connected
              ),
            ],
          ),
        ),
      ),
    );
  }
}
