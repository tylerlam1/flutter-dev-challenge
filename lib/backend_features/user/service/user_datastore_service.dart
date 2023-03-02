import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ap_sci_app/models/ModelProvider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userDataStoreProvider = Provider<UserDataStoreService>(
  (ref) {
    final service = UserDataStoreService();
    return service;
  },
);

// UserDateStoreService includes all backend API calls
class UserDataStoreService {
  UserDataStoreService();

  Future<void> addUser(User user) async {
    try {
      await Amplify.DataStore.save(user);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Stream<List<User>> getUsers() {
    return Amplify.DataStore.observeQuery(
      User.classType,
      sortBy: [User.ID.descending()],
    ).map((event) => event.items.toList()).handleError((e) {
      debugPrint('getUsers: A stream error occurred');
    });
  }

  Stream<User> getUserByID(String id) {
    final userStream =
        Amplify.DataStore.observeQuery(User.classType, where: User.ID.eq(id))
            .map((event) => event.items.toList().first);

    return userStream;
  }

  Future<void> deleteUser(User user) async {
    try {
      await Amplify.DataStore.delete(user);
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> updateUser(User userToUpdate) async {
    try {
      final oldUserList = await Amplify.DataStore.query(User.classType,
          where: User.ID.eq(userToUpdate.id));
      final oldUser = oldUserList.first;

      final updatedUser = oldUser.copyWith(
        weight: userToUpdate.weight,
        height: userToUpdate.height,
        username: userToUpdate.username,
        birthdate: userToUpdate.birthdate,
        name: userToUpdate.name,
        country: userToUpdate.country,
        state: userToUpdate.state,
        primaryLanguage: userToUpdate.primaryLanguage,
      );

      await Amplify.DataStore.save(updatedUser);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
