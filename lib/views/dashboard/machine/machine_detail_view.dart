import 'package:flutter/material.dart';
import 'package:veloce_task_frontend/data/models/machine_model.dart';

class MachineDetailView extends StatelessWidget {
  final MachineModel machine;

  const MachineDetailView({super.key, required this.machine});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Machine Details")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${machine.machineName}"),
            Text("Model: ${machine.model}"),
            Text("Serial: ${machine.serialNumber}"),
            Text("Year: ${machine.year}"),
          ],
        ),
      ),
    );
  }
}