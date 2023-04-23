import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stylish2023/Data/product_list.dart';
import 'package:stylish2023/resources/api-repository.dart';

part 'product_data_event.dart';
part 'product_data_state.dart';

class ProductDataBloc extends Bloc<ProductDataEvent, ProductDataState> {
  final ApiRepository apiRepository;

  ProductDataBloc(this.apiRepository) : super(const ProductDataInitial()) {
    on<GetProductEvent>((event, emit) => _fetchProducts(event, emit));
  }
  Future<void> _fetchProducts(
      GetProductEvent event, Emitter<ProductDataState> emit) async {
    emit(const ProductDataLoading());
    try {
      final women = await apiRepository.fetchWomenProductList();
      final men = await apiRepository.fetchMenProductList();
      final accessories = await apiRepository.fetchAccessoriesProductList();
      final marketingHots = await apiRepository.fetchMarketingHots();
      emit(ProductDataLoaded(
        women: women,
        men: men,
        accessories: accessories,
        marketingHots: marketingHots,
      ));
    } catch (e) {
      emit(ProductDataError(e.toString()));
    }
  }
}
