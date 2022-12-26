class UsersModel {
  String? name;
  String? phone;
  String? location;
  String? email;
  String? image;
  String? uid;

  UsersModel({
    this.name,
    this.phone,
    this.location,
    this.email,
    this.image,
    this.uid,
  });

  UsersModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    location = json['location'];
    email = json['email'];
    image = json['image'];
    uid = json['uid'];
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'location': location,
        'email': email,
       if(image != null) 'image': image,
       if(uid != null) 'uid': uid,
      };
}
