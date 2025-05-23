import 'package:flashcards/data/datasorces/dictionary_api_dev_remote_ds.dart';
import 'package:flashcards/data/dummy_data.dart';
import 'package:flashcards/data/repositories/dictionary_api_dev_repo.dart';
import 'package:flashcards/data/repositories/dummy_flashcard_repository.dart';
import 'package:flashcards/data/repositories/multi_source_dictionary_repo.dart';
import 'package:flashcards/domain/repositories/dictionary_repository.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_cubit.dart';
import 'package:flashcards/presentation/cubit/statistics/statistics_cubit.dart';
import 'package:flashcards/presentation/cubit/status_overview_cubit.dart';
import 'package:flashcards/presentation/cubit/unlock_category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class Di extends StatelessWidget {
  final Widget child;
  const Di({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    final apiDevDS = DictionaryApiDevRemoteDS(httpClient);

    final repoApiDev = DictionaryApiDevRepo(apiDevDS);

    final dictionaryRepo = MultiSourceDictionaryRepo([repoApiDev]);

    final FlashcardRepository cardRepository = DummyFlashcardRepository(
      dummyFlashcards,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DictionaryRepository>.value(value: dictionaryRepo),
        RepositoryProvider<FlashcardRepository>.value(value: cardRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => FlashcardCubit(cardRepository)..init()),
          BlocProvider(create: (_) => StatisticsCubit(cardRepository)..init()),
          BlocProvider(create: (_) => StatusOverviewCubit()),
          BlocProvider(create: (_) => CategoryUnlockCubit()),
          // TODO add Dictionary cubit
        ],
        child: child,
      ),
    );
  }
}
