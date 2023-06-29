import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'screens/add_start_screen.dart';
import 'screens/home_screen.dart';
import './config/constants.dart';

final HttpLink httpLink = HttpLink(
  'https://api.github.com/graphql',
);

final AuthLink authLink = AuthLink(
  getToken: () async => 'Bearer $GITHUB_API_KEY',
  // OR
  // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
);

final Link link = authLink.concat(httpLink);

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: link,
    // The default store is the InMemoryStore, which does NOT persist to disk
    cache: GraphQLCache(store: HiveStore()),
  ),
);

void main() async {
  // We're using HiveStore for persistence,
  // so we need to initialize Hive.
  await initHiveForFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPrint(GITHUB_API_KEY);
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (_) => const HomeScreen());
              case '/add_star':
                return MaterialPageRoute(builder: (_) => const AddStarScreen());
              default:
                return null;
            }
          }),
    );
  }
}
