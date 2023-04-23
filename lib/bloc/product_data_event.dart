part of 'product_data_bloc.dart';

abstract class ProductDataEvent extends Equatable {
  const ProductDataEvent();

  @override
  List<Object> get props => [];
}

class GetProductEvent extends ProductDataEvent {}
