import 'package:ap_sci_app/backend_features/user/controller/user_controller.dart';
import 'package:ap_sci_app/models/ModelProvider.dart';
import 'package:ap_sci_app/screens/profile/create_profile.dart';
import 'package:ap_sci_app/utils/constants.dart';
import 'package:ap_sci_app/widgets/common/loading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  ProfileScreen({super.key});
  late User user;

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _userDataPopulated(User user) {
    if (user.height == null) {
      return true;
    } else if (user.weight == null) {
      return true;
    } else if (user.name == null) {
      return true;
    } else {
      return false;
    }
  }

  _getUser() async {
    late User user;
    user = await ref
        .read(userListControllerProvider)
        .getUserByID(id: 'user_id_on_backend'); //For test only
    return user;
  }

  Future<void> _setState() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool useMobileLayout =
        MediaQuery.of(context).size.shortestSide < TABLET_SIZE;

    return FutureBuilder<User>(
        future: _getUser(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return LoadingWidget();
          }
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            debugPrint('No User');
          }

          final user = snapshot.data as User;

          return Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        minRadius: useMobileLayout ? 40 : 120,
                        child: Icon(Icons.account_circle_outlined, size: 100)),
                    Text(user.name.toString(),
                        style: TextStyle(
                            fontSize: useMobileLayout ? 30 : 50,
                            fontWeight: FontWeight.bold,
                            color: Color(PURPLE_COLOR))),
                    const SizedBox(height: 30),
                    Text('Username',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 20 : 30,
                            fontWeight: FontWeight.bold,
                            color: Color(PURPLE_COLOR))),
                    Text(user.username.toString(),
                        style: TextStyle(
                            fontSize: useMobileLayout ? 15 : 20,
                            color: Colors.grey)),
                    const SizedBox(height: 30),
                    Text('Height',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 20 : 30,
                            fontWeight: FontWeight.bold,
                            color: Color(PURPLE_COLOR))),
                    Text([user.height, ' cm'].join(),
                        style: TextStyle(
                            fontSize: useMobileLayout ? 15 : 20,
                            color: Colors.grey)),
                    const SizedBox(height: 30),
                    Text('Weight',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 20 : 30,
                            fontWeight: FontWeight.bold,
                            color: Color(PURPLE_COLOR))),
                    Text([user.weight, ' kg'].join(),
                        style: TextStyle(
                            fontSize: useMobileLayout ? 15 : 20,
                            color: Colors.grey)),
                    const SizedBox(height: 30),
                    Text('Location',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 20 : 30,
                            fontWeight: FontWeight.bold,
                            color: Color(PURPLE_COLOR))),
                    Text('${user.city}, ${user.state}, ${user.country}',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 15 : 20,
                            color: Colors.grey)),
                    const SizedBox(height: 30),
                    Text('Primary Language',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 20 : 30,
                            fontWeight: FontWeight.bold,
                            color: Color(PURPLE_COLOR))),
                    Text('${user.primaryLanguage}',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 15 : 20,
                            color: Colors.grey)),
                    const SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateProfile(user)))
                              .then(((_) => setState(
                                    () {},
                                  )));
                          await _setState();
                        },
                        child: const Text('Edit Profile'))
                  ],
                ),
              ));
        });
  }
}
