import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        centerTitle: false,
        title: const Text("Edit profile"),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Done"),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.sizeOf(context).width * (648 - 50) / 648,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.shade400,
            ),
          ),
          child: Column(
            children: [
              Column(
                children: [
                  Title(
                    color: Colors.black,
                    child: const Text("Name"),
                  ),
                ],
              ),
              const Column(
                children: [],
              ),
              const Column(
                children: [],
              ),
              const Column(
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
