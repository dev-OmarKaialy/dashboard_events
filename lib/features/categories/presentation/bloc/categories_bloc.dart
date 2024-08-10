import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:events_dashboard/core/utils/toaster.dart';
import 'package:events_dashboard/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:events_dashboard/features/categories/data/datasources/categories_data.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(const CategoriesState()) {
    on<GetCategories>((event, emit) async {
      emit(state.copyWith(status: CubitStatus.loading));

      try {
        final result = await CategoriesData().getCategories();
        emit(state.copyWith(status: CubitStatus.success, categories: result));
      } on Exception catch (e) {
        emit(state.copyWith(status: CubitStatus.failed));
      }
    });
    on<AddCategory>((event, emit) async {
      try {
        Toaster.showLoading();
        final r = await CategoriesData()
            .addCategory(event.name, event.description, event.image);
        Toaster.closeLoading();
        add(GetCategories());
      } on FirebaseException catch (e) {
        Toaster.closeLoading();
        Toaster.showToast(e.toString());
      }
    });
    on<AddProduct>((event, emit) async {
      try {
        Toaster.showLoading();
        final r = await CategoriesData().addProduct(
            name: event.name,
            capacity: event.capacity,
            category: event.catId,
            image: event.image,
            price: event.price);
        Toaster.closeLoading();
        add(GetProductsByCategory(catId: event.catId));
      } on FirebaseException catch (e) {
        Toaster.closeLoading();
        Toaster.showToast(e.toString());
      }
    });
    on<GetProductsByCategory>((event, emit) async {
      emit(state.copyWith(productStatus: CubitStatus.loading));

      try {
        final r = await CategoriesData().getProducts(event.catId);
        emit(state.copyWith(productStatus: CubitStatus.success, products: r));
      } on Exception catch (e) {
        emit(state.copyWith(productStatus: CubitStatus.failed));
      }
    });
  }
}
