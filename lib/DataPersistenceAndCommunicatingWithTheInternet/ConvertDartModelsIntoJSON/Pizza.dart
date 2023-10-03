class Pizza {
  int id = 0;
  String pizzaName = "";
  String description = "";
  double price = 0;
  String imageUrl = "";

  Pizza();
  //deserialize
  Pizza.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    pizzaName = json["pizzaName"];
    description = json["description"];
    price = json["price"];
    imageUrl = json["imageUrl"];
  }

//serialize
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "pizzaName": pizzaName,
      "description": description,
      "price": price,
      "imageUrl": imageUrl
    };
  }
}
