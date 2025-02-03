import 'package:amarjeet_ci_cd/api_bloc.dart';
import 'package:amarjeet_ci_cd/api_event.dart';
import 'package:amarjeet_ci_cd/api_service.dart';
import 'package:amarjeet_ci_cd/api_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ApiService])
import 'api_bloc_test.mocks.dart';

void main() {
  late ApiBloc apiBloc;
  late MockApiService apiService;

  setUp(() {
    apiService = MockApiService();
    apiBloc = ApiBloc(apiService: apiService);
  });

  tearDown(() {
    apiBloc.close();
  });

  test('Initial state is ApiInitial', () {
    expect(apiBloc.state, ApiInitial());
  });

  blocTest<ApiBloc, ApiState>(
    'emits [ApiLoading, ApiSuccess] when API call succeeds',
    build: () {
      when(apiService.fetchData())
          .thenAnswer((_) async => "delectus aut autem");
      return apiBloc;
    },
    act: (bloc) => bloc.add(FetchDataEvent()),
    expect: () => <ApiState>[
      ApiLoading(),
      ApiSuccess('delectus aut autem'),
    ],
  );

  blocTest<ApiBloc, ApiState>(
    'emits [ApiLoading, ApiFailure] when API call succeeds',
    build: () {
      when(apiService.fetchData()).thenThrow(Exception('Failed to load data'));
      return apiBloc;
    },
    act: (bloc) => bloc.add(FetchDataEvent()),
    expect: () => <ApiState>[
      ApiLoading(),
      ApiFailure('Failed to load data'),
    ],
  );

  blocTest<ApiBloc, ApiState>(
    'emits [ApiLoading, ApiSuccess("Something went wrong")] when status is 404',
    build: () {
      when(apiService.fetchData())
          .thenAnswer((_) async => "Something went wrong");
      return apiBloc;
    },
    act: (bloc) => bloc.add(FetchDataEvent()),
    expect: () => <ApiState>[
      ApiLoading(),
      ApiSuccess('Something went wrong'),
    ],
  );
}
