import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter chat"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
    colors: [Colors.white, Colors.pink[100] ?? Colors.white],             begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Text("Loading"),
        ),
      ),
    );
  }
}