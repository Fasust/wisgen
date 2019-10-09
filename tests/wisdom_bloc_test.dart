import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wisgen/blocs/wisdom_bloc.dart';
import 'package:wisgen/blocs/wisdom_event.dart';
import 'package:wisgen/blocs/wisdom_state.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/repository.dart';

class MockRepository extends Mock implements Repository<Wisdom> {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group('Wisdom Bloc', () {
    WisdomBloc wisdomBloc;
    MockRepository mockRepository;
    MockBuildContext mockBuildContext;

    setUp(() {
      wisdomBloc = WisdomBloc();
      mockRepository = MockRepository();
      mockBuildContext = MockBuildContext();

      wisdomBloc.repository = mockRepository;
    });

    tearDown(() {
      //Run after each test
      wisdomBloc.dispose();
    });

    test('Send Fetch Event and see if it emits correct wisdom', () {
      List<Wisdom> fetchedWisdom = [
        Wisdom(id: 1, text: "This is a Wisdom", type: "any"),
        Wisdom(id: 2, text: "This is a Wisdom", type: "any"),
        Wisdom(id: 3, text: "This is a Wisdom", type: "any"),
      ];

      List expectedStates = [
        IdleWisdomState(new List()),
        IdleWisdomState(fetchedWisdom)
      ];

      when(mockRepository.fetch(20, mockBuildContext))
          .thenAnswer((_) async => fetchedWisdom);

      expectLater(wisdomBloc.state, emitsInOrder(expectedStates));

      wisdomBloc.dispatch(FetchEvent(mockBuildContext));
    });

    test('Error on a null BuildContext', () {
      List<Wisdom> fetchedWisdom = [
        Wisdom(id: 1, text: "This is a Wisdom", type: "any"),
        Wisdom(id: 2, text: "This is a Wisdom", type: "any"),
        Wisdom(id: 3, text: "This is a Wisdom", type: "any"),
      ];

      Exception exception = NetworkImageLoadException(statusCode: 300, uri: Uri());

      List expectedStates = [
        IdleWisdomState(new List()),
        ErrorWisdomState(exception)
      ];

      when(mockRepository.fetch(20, null))
          .thenThrow(exception);

      expectLater(wisdomBloc.state, emitsInOrder(expectedStates));

      wisdomBloc.dispatch(FetchEvent(null));
    });
  });
}
