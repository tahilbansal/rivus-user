// To parse this JSON data, do
//
//     final clientOrders = clientOrdersFromJson(jsonString);

import 'dart:convert';

List<ClientOrders> clientOrdersFromJson(String str) => List<ClientOrders>.from(
    json.decode(str).map((x) => ClientOrders.fromJson(x)));

String clientOrdersToJson(List<ClientOrders> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientOrders {
  final String id;
  final String userId;
  final List<OrderItem> orderItems;
  final double orderTotal;
  final double deliveryFee;
  final double grandTotal;
  final String deliveryAddress;
  final String supplierAddress;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final String supplierId;

  ClientOrders({
    required this.id,
    required this.userId,
    required this.orderItems,
    required this.orderTotal,
    required this.deliveryFee,
    required this.grandTotal,
    required this.deliveryAddress,
    required this.supplierAddress,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.supplierId,
  });

  factory ClientOrders.fromJson(Map<String, dynamic> json) => ClientOrders(
        id: json["_id"],
        userId: json["userId"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        orderTotal: (json["orderTotal"] ?? 0).toDouble(),
        deliveryFee: (json["deliveryFee"] ?? 0).toDouble(),
        grandTotal: (json["grandTotal"] ?? 0).toDouble(),
        deliveryAddress: json["deliveryAddress"],
        supplierAddress: json["supplierAddress"],
        paymentMethod: json["paymentMethod"],
        paymentStatus: json["paymentStatus"],
        orderStatus: json["orderStatus"],
        supplierId: json["supplierId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "orderTotal": orderTotal,
        "deliveryFee": deliveryFee,
        "grandTotal": grandTotal,
        "deliveryAddress": deliveryAddress,
        "supplierAddress": supplierAddress,
        "paymentMethod": paymentMethod,
        "paymentStatus": paymentStatus,
        "orderStatus": orderStatus,
        "supplierId": supplierId,
      };
}

class OrderItem {
  final ItemId itemId;
  final int quantity;
  final double price;
  //final List<String> additives;
  final String instructions;
  final String id;

  OrderItem({
    required this.itemId,
    required this.quantity,
    required this.price,
    //required this.additives,
    required this.instructions,
    required this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        itemId: ItemId.fromJson(json["itemId"]),
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        //additives: List<String>.from(json["additives"].map((x) => x)),
        instructions: json["instructions"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId.toJson(),
        "quantity": quantity,
        "price": price,
        //"additives": List<dynamic>.from(additives.map((x) => x)),
        "instructions": instructions,
        "_id": id,
      };
}

class ItemId {
  final String id;
  final String title;
  //final double rating;
  final List<String> imageUrl;
  //final String time;

  ItemId({
    required this.id,
    required this.title,
    //required this.rating,
    required this.imageUrl,
    //required this.time,
  });

  factory ItemId.fromJson(Map<String, dynamic> json) => ItemId(
        id: json["_id"],
        title: json["title"],
        //rating: json["rating"]?.toDouble(),
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        //time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        //"rating": rating,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        //"time": time,
      };
}
