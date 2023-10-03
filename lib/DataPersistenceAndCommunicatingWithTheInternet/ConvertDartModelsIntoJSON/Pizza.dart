class Pizza {
  int id = 0;
  String pizzaName = "";
  String description = "";
  double price = 0;
  String imageUrl = "";

  Pizza();
  //deserialize
  Pizza.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.pizzaName = json["pizzaName"];
    this.description = json["description"];
    this.price = json["price"];
    this.imageUrl = json["imageUrl"];
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
