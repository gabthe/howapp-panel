import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepo {}

final userRepoProvider = Provider<UserRepo>(
  (ref) {
    return UserRepo();
  },
);
