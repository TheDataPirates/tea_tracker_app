class Lot {
  final String lotId;
  final String user_Id; //foreign key from user table
  final String supplier_id;
  final String supplier_name;
  final String container_type;
  final int no_of_containers;
  final int gross_weight;
  final String leaf_grade;
  final int water;
  final int course_leaf;
  final int other;
  final int deductions; // calculated fields
  final int net_weight; //calculated fields
  final String date;
  final int isDeleted;
  final int container1;
  final int container2;
  final int container3;
  final int container4;
  final int container5;
  final int bulkId;
  final String method;

  Lot({
    this.lotId,
    this.user_Id,
    this.supplier_id,
    this.supplier_name,
    this.container_type,
    this.no_of_containers,
    this.gross_weight,
    this.leaf_grade,
    this.water,
    this.course_leaf,
    this.other,
    this.deductions,
    this.net_weight,
    this.date,
    this.isDeleted = 0,
    this.container1,
    this.container2,
    this.container3,
    this.container4,
    this.container5,
    this.bulkId,
    this.method,
  });
}
