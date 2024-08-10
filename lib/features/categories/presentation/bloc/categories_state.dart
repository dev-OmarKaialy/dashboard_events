part of 'categories_bloc.dart';

class CategoriesState {
  final CubitStatus productStatus;
  final CubitStatus status;
  final CubitStatus addStatus;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> categories;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> products;
  const CategoriesState({
    this.status = CubitStatus.initial,
    this.productStatus = CubitStatus.initial,
    this.addStatus = CubitStatus.initial,
    this.categories = const [],
    this.products = const [],
  });

  CategoriesState copyWith({
    CubitStatus? status,
    CubitStatus? productStatus,
    CubitStatus? addStatus,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? categories,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? products,
  }) {
    return CategoriesState(
      status: status ?? this.status,
      productStatus: productStatus ?? this.productStatus,
      addStatus: addStatus ?? this.addStatus,
      categories: categories ?? this.categories,
      products: products ?? this.products,
    );
  }
}
