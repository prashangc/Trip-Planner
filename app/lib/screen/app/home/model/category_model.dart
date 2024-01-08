class CategoryModel {
  String? sId;
  String? category;
  String? image;
  String? imagePath;

  CategoryModel({this.sId, this.category, this.image, this.imagePath});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    category = json['category'];
    image = json['image'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['category'] = category;
    data['image'] = image;
    data['imagePath'] = imagePath;
    return data;
  }
}
