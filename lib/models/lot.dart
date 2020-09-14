class Lot {
  final String supplier_id;
  final String container_type;
  final int no_of_containers;
  final double gross_weight;
  final String leaf_grade;
  final double water;
  final double course_leaf;
  final double other;

  Lot(
      {this.supplier_id,
      this.container_type,
      this.no_of_containers,
      this.gross_weight,
      this.leaf_grade,
      this.water,
      this.course_leaf,
      this.other});
}
