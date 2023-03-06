import 'dart:core';

import 'package:flutter/foundation.dart';

main() {
  // initialize a steam of integers 0 to 9
  Stream<int> stream = countStream(10);
  if (kDebugMode) {
    print(stream);
  }
}

Stream<int> countStream(int max) async* {
  for (int i = 0; i < max; i++) {
    yield i;
  }
}

//Consume the Stream
Future<int> sumStream(Stream<int> stream) async {
  int sum = 0;
  await for (int item in stream) {
    sum += item;
  }
  return sum;
}
