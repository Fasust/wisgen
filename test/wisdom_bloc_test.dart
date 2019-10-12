import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wisgen/blocs/wisdom_bloc.dart';
import 'package:wisgen/blocs/wisdom_event.dart';
import 'package:wisgen/blocs/wisdom_state.dart';
import 'package:wisgen/models/wisdom.dart';
import 'package:wisgen/repositories/supplier.dart';

class MockRepository extends Mock implements Supplier<List<Wisdom>> {}

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
      //Set Up
      List<Wisdom> fetchedWisdom = [
        Wisdom(id: 1, text: "Back up your Pictures", type: "tech"),
        Wisdom(id: 2, text: "Wash your ears", type: "Mum's Advice"),
        Wisdom(id: 3, text: "Travel while you're young", type: "Grandma's Advice")
      ];

			when(mockRepository.fetch(20, mockBuildContext))
				//Telling the Mock Repo how to behave
				.thenAnswer((_) async => fetchedWisdom);


      List expectedStates = [
        //BLoC Library BLoCs emit their initial State on creation
        WisdomStateIdle(List()),
        WisdomStateIdle(fetchedWisdom)
      ];
    
			//Test
			wisdomBloc.dispatch(WisdomEventFetch(mockBuildContext));

			//Result
      expect(wisdomBloc.state, emitsInOrder(expectedStates));
    });
  });
}
