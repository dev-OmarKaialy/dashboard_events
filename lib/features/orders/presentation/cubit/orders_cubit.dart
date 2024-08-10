import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_dashboard/core/utils/toaster.dart';
import 'package:events_dashboard/features/orders/data/datasources/orders_datasource.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersState());
  getOrders() async {
    emit(state.copyWith(status: CubitStatus.loading));
    try {
      final result = await OrdersData().getOrders();
      emit(state.copyWith(status: CubitStatus.success, orders: result));
    } catch (e) {
      emit(state.copyWith(status: CubitStatus.failed));
    }
  }

  toggleOrder(String id, bool accepted) async {
    Toaster.showLoading();
    try {
      await OrdersData().toggleOrder(id, accepted);
      Toaster.closeLoading();
      getOrders();
    } catch (e) {
      Toaster.closeLoading();
      Toaster.showToast(e.toString());
    }
  }
}
