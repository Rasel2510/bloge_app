class DataModel {
  final int id;
  final String image;
  final String title;
  final String dics;
  DataModel({
    required this.id,
    required this.image,
    required this.title,
    required this.dics,
  });
  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'],
      image: map['image'],
      title: map['title'],
      dics: map['dics'],
    );
  }
  Map<String, dynamic> toMap() {
    return {'id': id, 'image': image, 'title': title, 'dics': dics};
  }
}
