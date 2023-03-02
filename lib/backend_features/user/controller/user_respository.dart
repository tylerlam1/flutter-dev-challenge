import 'package:ap_sci_app/backend_features/user/service/user_datastore_service.dart';
import 'package:ap_sci_app/models/ModelProvider.dart';
import 'package:ap_sci_app/models/User.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  UserDataStoreService userDataStoreService = ref.read(userDataStoreProvider);
  return UserRepository(userDataStoreService);
});

final userListStreamProvider = StreamProvider.autoDispose<List<User?>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.getUsers();
});

final userProvider =
    StreamProvider.autoDispose.family<User?, String>((ref, id) {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.getUser(id);
});

// UserRepository is a wrapper for the backend API calls
class UserRepository {
  final UserDataStoreService userDataStoreService;
  UserRepository(this.userDataStoreService);

  // Get all users in stream
  Stream<List<User>> getUsers() {
    return userDataStoreService.getUsers();
  }

  // Get specific user
  Stream<User> getUser(String id) {
    return userDataStoreService.getUserByID(id);
  }

  // Add user
  Future<void> addUser(User user) async {
    await userDataStoreService.addUser(user);
  }

  // Add user and return ID
  Future<String> addUserGiveId(User user) async {
    await userDataStoreService.addUser(user);
    return user.id;
  }

  // Delete user
  Future<void> deleteUser(User user) async {
    await userDataStoreService.deleteUser(user);
  }

  // Update user
  Future<void> updateUser(User userToUpdate) async {
    await userDataStoreService.updateUser(userToUpdate);
  }
}
