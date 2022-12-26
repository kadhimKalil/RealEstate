class ItemModel {
  String? itemImage;
  String? title;
  String? price;
  String? badRoom;
  String? bathRoom;
  String? area;
  String? location;
  String? propertiesDetails;
  String? userIamge;
  String? userName;

  ItemModel({
    required this.itemImage,
    required this.title,
    required this.price,
    required this.badRoom,
    required this.bathRoom,
    required this.area,
    required this.location,
    required this.propertiesDetails,
    required this.userIamge,
    required this.userName,
  }) {}

  ItemModel.fromJson({required Map<String, dynamic> json}) {
    itemImage = json['itemImage'];
    title = json['title'];
    price = json['price'];
    badRoom = json['badRoom'];
    bathRoom = json['bathRoom'];
    area = json['area'];
    location = json['location'];
    propertiesDetails = json['propertiesDetails'];
    userIamge = json['userIamge'];
    userName = json['userName'];
  }
Map<String,dynamic> toMap() => {
'itemImage':itemImage,
'title':title,
'price':price,
'badRoom':badRoom,
'bathRoom':bathRoom,
'area':area,
'location':location,
'propertiesDetails':propertiesDetails,
'userIamge':userIamge,
'userName':userName,
};
}
