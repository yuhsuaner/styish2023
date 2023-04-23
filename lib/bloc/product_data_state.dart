part of 'product_data_bloc.dart';

abstract class ProductDataState extends Equatable {
  const ProductDataState();
}

class ProductDataInitial extends ProductDataState {
  const ProductDataInitial();

  @override
  List<Object> get props => [];
}

class ProductDataLoading extends ProductDataState {
  const ProductDataLoading();

  @override
  List<Object> get props => [];
}

class ProductDataLoaded extends ProductDataState {
  final List<Product> women;
  final List<Product> men;
  final List<Product> accessories;
  final List<HotsProductData> marketingHots;

  const ProductDataLoaded({
    required this.women,
    required this.men,
    required this.accessories,
    required this.marketingHots,
  });

  @override
  List<Object> get props => [women, men, accessories, marketingHots];
}

class ProductDataError extends ProductDataState {
  final String message;
  const ProductDataError(this.message);

  @override
  List<Object> get props => [message];
}
