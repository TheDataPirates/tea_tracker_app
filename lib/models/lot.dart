class Lot {
  final String supplier_id;
  final String container_type;
  final int no_of_containers;
  final double gross_weight;
  final String leaf_grade;
  final double water;
  final double course_leaf;
  final double other;
  bool fromCache = false;

  Lot(
      {this.supplier_id,
      this.container_type,
      this.no_of_containers,
      this.gross_weight,
      this.leaf_grade,
      this.water,
      this.course_leaf,
      this.other,
      this.fromCache});

//  factory Lot.fromJson(Map<String, dynamic> json) {
//    return Lot(
//        supplier_id: json['supplier_id'],
//        container_type: json['container_type'],
//        no_of_containers: json['no_of_containers']);
//  }
}
