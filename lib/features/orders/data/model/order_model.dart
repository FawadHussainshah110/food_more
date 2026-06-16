import 'package:food_app_task/features/cart/data/model/cart_item_model.dart';

enum OrderStatus {
  placed,
  preparing,
  outForDelivery,
  delivered
}

class OrderModel {
  final String id;
  final List<CartItemModel> items;
  final double totalAmount;
  final DateTime date;
  final OrderStatus status;
  final String address;
  final String notes;

  OrderModel({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.date,
    required this.status,
    required this.address,
    required this.notes,
  });

  OrderModel copyWith({
    String? id,
    List<CartItemModel>? items,
    double? totalAmount,
    DateTime? date,
    OrderStatus? status,
    String? address,
    String? notes,
  }) {
    return OrderModel(
      id: id ?? this.id,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      date: date ?? this.date,
      status: status ?? this.status,
      address: address ?? this.address,
      notes: notes ?? this.notes,
    );
  }
}
