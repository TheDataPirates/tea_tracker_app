class Lot {
  final String lotId;
  final String supplier_id;
  final String container_type;
  final int no_of_containers;
  final int gross_weight;
  final String leaf_grade;
  final int water;
  final int course_leaf;
  final int other;

  Lot({
    this.lotId,
    this.supplier_id,
    this.container_type,
    this.no_of_containers,
    this.gross_weight,
    this.leaf_grade,
    this.water,
    this.course_leaf,
    this.other,
  });

//  factory Lot.fromJson(Map<String, dynamic> json) {
//    return Lot(
//        supplier_id: json['supplier_id'],
//        container_type: json['container_type'],
//        no_of_containers: json['no_of_containers']);
//  }
}
