part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetCategories extends CategoriesEvent {}

class AddCategory extends CategoriesEvent {
  final String name;
  final String description;
  final File image;
  const AddCategory({
    required this.name,
    required this.description,
    required this.image,
  });
}

class AddProduct extends CategoriesEvent {
  final String name;
  final String catId;
  final double price;
  final int capacity;
  final String description;
  final File image;
  const AddProduct({
    required this.name,
    required this.catId,
    required this.price,
    required this.capacity,
    required this.description,
    required this.image,
  });
}

class GetProductsByCategory extends CategoriesEvent {
  final String catId;

  const GetProductsByCategory({required this.catId});
}
