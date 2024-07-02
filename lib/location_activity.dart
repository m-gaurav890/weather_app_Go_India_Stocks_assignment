import 'package:flutter/material.dart';

class LocationActivity extends StatefulWidget {
  const LocationActivity({super.key});

  @override
  State<LocationActivity> createState() => _LocationActivityState();
}

class _LocationActivityState extends State<LocationActivity> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text("Location Activity")),
    );
  }
}
