import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String readRepositories = """
  query ReadRepositories(\$nRepositories: Int!) {
    viewer {
      repositories(last: \$nRepositories) {
        nodes {
          id
          name
          viewerHasStarred
        }
      }
    }
  }
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("GraphQL CRUD"),
          centerTitle: true,
          shadowColor: Colors.deepPurple,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey, // Border color
              height: 1.0, // Border height
            ),
          ),
        ),
        body: // ...
            Query(
          options: QueryOptions(
            document: gql(
                readRepositories), // this is the query string you just created
            variables: const {
              'nRepositories': 50,
            },
            pollInterval: const Duration(seconds: 10),
          ),
          // Just like in apollo refetch() could be used to manually trigger a refetch
          // while fetchMore() can be used for pagination purpose
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const Text('Loading');
            }

            List? repositories =
                result.data?['viewer']?['repositories']?['nodes'];

            if (repositories == null) {
              return const Text('No repositories');
            }

            return ListView.builder(
                itemCount: repositories.length,
                itemBuilder: (context, index) {
                  final repository = repositories[index];

                  return Column(
                    children: [
                      Text(repository['name'] ?? ''),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/add_star');
                          },
                          child: const Text("Add Star"))
                    ],
                  );
                });
          },
        ));
  }
}
