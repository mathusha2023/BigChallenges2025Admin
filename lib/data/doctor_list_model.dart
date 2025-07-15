class DoctorListModel {
  final String id;
  final String name;
  final int age;
  final int gender; // 0 - мужской, 1 - женский
  final String hospital;
  final String address;
  final String phone;
  final String post;

  DoctorListModel(
    this.id,
    this.name,
    this.age,
    this.gender,
    this.hospital,
    this.address,
    this.phone,
    this.post,
  );
}
