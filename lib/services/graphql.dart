import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class GraphqlService {
  static final HttpLink myBoxLink = HttpLink(
    uri: "localhost:8080/graphql",
  );

  static final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: myBoxLink,
    ),
  );
}