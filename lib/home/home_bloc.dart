import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/image_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ImageRepository repository;

  HomeBloc(this.repository) : super(HomeState.initial()) {
    on<FetchImages>((event, emit) async {
      emit(HomeState(isLoading: true, images: []));
      try {
        final images = await repository.fetchImages();
        emit(HomeState(isLoading: false, images: images));
      } catch (e) {
        emit(HomeState(isLoading: false, images: [], error: e.toString()));
      }
    });
  }
}
