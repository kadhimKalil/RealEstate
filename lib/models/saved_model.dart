class SavedModel {
  String? itemImage;
  String? title;
  String? price;
  String? location;

  SavedModel({
    required this.itemImage,
    required this.title,
    required this.price,
    required this.location,
  }) {}

 

  Map<String, dynamic> toMap() => {
        'itemImage': itemImage,
        'title': title,
        'location': location,
        'price': price,
      };
}
