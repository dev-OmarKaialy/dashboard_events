part of 'orders_cubit.dart';

class OrdersState {
  final CubitStatus status;
  final List<QueryDocumentSnapshot> orders;
  OrdersState({
    this.status = CubitStatus.initial,
    this.orders = const [],
  });

  OrdersState copyWith({
    CubitStatus? status,
    List<QueryDocumentSnapshot>? orders,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
    );
  }
}
