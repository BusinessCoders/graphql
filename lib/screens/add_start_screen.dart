import 'package:flutter/material.dart';
import '../widgets/mutaion_container.dart';

class AddStarScreen extends StatefulWidget {
  const AddStarScreen({super.key});

  @override
  State<AddStarScreen> createState() => _AddStarScreenState();
}

class _AddStarScreenState extends State<AddStarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GraphQL Mutation"),
      ),
      body: const Center(
        child: MutationConatiner(),
      ),
    );
  }
}
