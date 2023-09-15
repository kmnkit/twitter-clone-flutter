import 'package:flutter/material.dart';

class MutedScreen extends StatelessWidget {
  const MutedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Muted"),
      ),
      body: const Center(
        child: Text("You haven't muted anyone."),
      ),
    );
  }
}
