import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MutationConatiner extends StatefulWidget {
  const MutationConatiner({super.key});

  @override
  State<MutationConatiner> createState() => _MutationConatinerState();
}

class _MutationConatinerState extends State<MutationConatiner> {
  String mutationResult = "";
  String addStar = """
  mutation AddStar(\$starrableId: ID!) {
    addStar(input: {starrableId: \$starrableId}) {
      starrable {
        viewerHasStarred
      }
    }
  }
""";

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(addStar),
        // onCompleted: (data) {
        //   debugPrint(data as String?);
        // },
      ),
      builder: (runMutation, result) {
        return FloatingActionButton(
          onPressed: () {
            runMutation({'starrableId': 'MDEwOlJlcG9zaXRvcnk0NDY1MzMzNA=='});
          },
          tooltip: 'Star',
          child: const Icon(Icons.star),
        );
      },
    );
  }
}
