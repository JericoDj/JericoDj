import 'package:flutter/material.dart';

class AssistantsPage extends StatelessWidget {
  const AssistantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistants'),
      ),
      body: const Center(
        child: Text('Assistants Page'),
      ),
    );
  }
}
