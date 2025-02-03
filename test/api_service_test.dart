import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:amarjeet_ci_cd/api_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([http.Client])
import 'api_service_test.mocks.dart';

void main() {
  late ApiService apiService;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    apiService = ApiService(client: mockClient);
  });

  test('returns a title if the HTTP call completes successfully', () async {
    // Mocking the API response with an explicit Future
    when(mockClient.get(any)).thenAnswer(
      (_) async => http.Response("""
        {
          "userId": 1,
          "id": 1,
          "title": "delectus aut autem",
          "completed": false
        }
        """, 200),
    );

    final response = await apiService.fetchData();

    expect(response, "delectus aut autem");
  });

  test(
      'returns a "No title available" if the HTTP call return is 200 and title is null',
      () async {
    // Mocking the API response with an explicit Future
    when(mockClient.get(any)).thenAnswer(
      (_) async => http.Response(
        """
        {
           "userId": 1,
          "id": 1,
          "title": null,
          "completed": false
        }
        """,
        200,
      ),
    );

    final response = await apiService.fetchData();

    expect(response, "No title available");
  });

  test('returns a "Something went wrong" if the HTTP call return 404',
      () async {
    // Mocking the API response with an explicit Future
    when(mockClient.get(any)).thenAnswer(
      (_) async => http.Response("Something went wrong", 404),
    );

    final response = await apiService.fetchData();

    expect(response, 'Something went wrong');
  });

  test('returns a exception if the status is not 200 or 404', () async {
    // Mocking the API response with an explicit Future
    when(mockClient.get(any)).thenAnswer(
      (_) async => http.Response("Something went wrong", 500),
    );

    expect(apiService.fetchData(), throwsException);
  });
}
