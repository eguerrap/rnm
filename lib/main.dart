import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rnm/features/characters/domain/usecases/get_character_detail.dart';
import 'package:rnm/features/characters/presentation/providers/character_detail_provider.dart';
import 'package:rnm/features/characters/presentation/providers/character_list_provider.dart';
import 'package:rnm/features/characters/presentation/providers/recent_characters_manager.dart';
import 'package:rnm/features/characters/presentation/screens/character_detail_screen.dart';
import 'package:rnm/features/characters/presentation/screens/character_list_screen.dart';
import 'package:rnm/features/characters/data/datasources/character_remote_data_source.dart';
import 'package:rnm/features/characters/data/repositories/character_repository_impl.dart';
import 'package:rnm/features/characters/presentation/widgets/home_widget.dart';
import 'package:rnm/shared/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClient = http.Client();
    final characterRemoteDataSource = CharacterRemoteDataSourceImpl(client: apiClient);
    final characterRepository = CharacterRepositoryImpl(remoteDataSource: characterRemoteDataSource);
    final getCharacterDetail = GetCharacterDetail(characterRepository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CharacterListProvider(repository: characterRepository),
        ),
        Provider<GetCharacterDetail>(
          create: (_) => getCharacterDetail,
        ),
        ChangeNotifierProvider(
          create: (context) => RecentCharactersManager(),
        ),
      ],
      child: Consumer<RecentCharactersManager>(
        builder: (context, recentCharactersManager, child) {
          return MaterialApp(
            title: 'Rick y Morty',
            theme: AppTheme.theme,
            debugShowCheckedModeBanner: false,
            home: recentCharactersManager.recentCharacters.isEmpty ? CharacterListScreen() : const HomeWidget(),
            routes: {
              '/characterList': (context) => CharacterListScreen(),
              '/home': (context) => const HomeWidget(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/characterDetail') {
                final args = settings.arguments as Map<String, dynamic>;
                final characterId = args['characterId'] as int;

                return MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => CharacterDetailProvider(
                      characterId: characterId,
                      getCharacterDetail: getCharacterDetail,
                      recentCharactersManager: recentCharactersManager,
                    )..fetchCharacterDetail(),
                    child: const CharacterDetailScreen(),
                  ),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
