class MitraM {
  MitraM({
    this.createdAt,
    this.contact,
    this.id,
    this.lat,
    this.long,
    this.name,
    this.status,
    this.image,
    this.category,
  });

  String? createdAt;
  String? contact;
  String? id;
  double? lat;
  double? long;
  String? name;
  bool? status;
  String? image;
  int? category;

  factory MitraM.fromJson(Map<String, dynamic> json) => MitraM(
        createdAt: json["createdAt"],
        contact: json["contact"],
        id: json["id"],
        lat: json["lat"],
        long: json["long"],
        name: json["name"],
        status: json["status"],
        image: json["image"],
        category: json["category"],
      );
}
