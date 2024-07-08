class StudentModel {
  int? id;
  String name;
  String age;
  String phone;
  String gender;
  String images;

  StudentModel(
      {
        this.id,
        required this.name,
      required this.age,
      required this.gender,
      required this.images,
      required this.phone});
}
