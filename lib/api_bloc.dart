import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_event.dart';
import 'api_state.dart';
import '../api_service.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final ApiService apiService;

  ApiBloc({required this.apiService}) : super(ApiInitial()) {
    on<FetchDataEvent>((event, emit) async {
      emit(ApiLoading());
      try {
        final title = await apiService.fetchData();
        emit(ApiSuccess(title));
      } catch (e) {
        emit(ApiFailure("Failed to load data"));
      }
    });
  }
}
