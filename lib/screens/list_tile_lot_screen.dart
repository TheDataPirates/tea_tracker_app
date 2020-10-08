import 'package:flutter/material.dart';

class ListTileLot extends StatelessWidget {
  final String supplier_id;
  final String container_type;
  final int no_of_containers;
  final double gross_weight;
  final String leaf_grade;
  final double water;
  final double course_leaf;
  final double other;

  ListTileLot(
      {this.supplier_id,
      this.container_type,
      this.no_of_containers,
      this.gross_weight,
      this.leaf_grade,
      this.water,
      this.course_leaf,
      this.other});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOT details"),
      ),
      body: Column(
        children: [
          Card(
            child: Text(supplier_id),
          ),
          Card(
            child: Text(container_type),
          ),
          Card(
            child: Text("${no_of_containers}"),
          ),
          Card(
            child: Text("${gross_weight}"),
          ),
          Card(
            child: Text(leaf_grade),
          ),
          Card(
            child: Text("${water}"),
          ),
          Card(
            child: Text("${course_leaf}"),
          ),
          Card(
            child: Text("${other}"),
          ),
        ],
      ),
    );
  }
}
