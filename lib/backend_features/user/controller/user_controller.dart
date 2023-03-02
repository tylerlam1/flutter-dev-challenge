import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ap_sci_app/backend_features/user/controller/user_respository.dart';
import 'package:ap_sci_app/models/ModelProvider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userListControllerProvider = Provider<UserListController>((ref) {
  return UserListController(ref);
});

// UserListController is the interface for updating and adding users
class UserListController {
  final Ref ref;

  UserListController(this.ref);

  Future<void> add() async {
    const String userName = '';

    User user = User(
      username: userName,
    );

    final userRepository = ref.read(userRepositoryProvider);

    await userRepository.addUser(user);
  }

  Future<User> getUserByID({required String id}) async {
    late Future<User> user;
    final userRepository = ref.read(userRepositoryProvider);

    user = userRepository.getUser(id).first;

    return user;
  }

  Future<void> updateUserProfile({
    required String weight,
    required String height,
    required String username,
    required TemporalDate birthdate,
    required User user,
    required String name,
    required String country,
    required String state,
    required String primaryLanguage,
  }) async {
    User userToUpdate = User(
        weight: weight,
        height: height,
        username: username,
        birthdate: birthdate,
        name: name,
        country: country,
        state: state,
        primaryLanguage: primaryLanguage);

    final usersRepository = ref.read(userRepositoryProvider);
    await usersRepository.updateUser(userToUpdate);
  }
}
