import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ap_sci_app/backend_features/user/controller/user_controller.dart';
import 'package:ap_sci_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ap_sci_app/models/ModelProvider.dart';
import 'package:ap_sci_app/data/create_profile_options.dart';

class CreateProfile extends ConsumerStatefulWidget {
  final User user;
  late String? name;
  late String? username;
  late String? height;
  late String? weight;
  late String? country;
  late String? state;
  late String? city;
  late String? language;

  CreateProfile(this.user, {super.key});

  @override
  ConsumerState<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends ConsumerState<CreateProfile> {
  final TextEditingController _nameTextEdittingController =
      TextEditingController();
  final TextEditingController _usernameTextEdittingController =
      TextEditingController();
  final TextEditingController _countryTextEdittingController =
      TextEditingController();
  final TextEditingController _stateTextEdittingController =
      TextEditingController();
  final TextEditingController _heightTextEdittingController =
      TextEditingController.fromValue(TextEditingValue(
          text: '', selection: TextSelection.collapsed(offset: 0)));
  final TextEditingController _weightTextEdittingController =
      TextEditingController.fromValue(TextEditingValue(
          text: '', selection: TextSelection.collapsed(offset: 0)));

  String _initialText(String? field) {
    if (field == null) {
      return "";
    } else {
      return field;
    }
  }

  void _updateUser(User user) async {
    await ref.read(userListControllerProvider).updateUserProfile(
          weight: widget.weight as String,
          height: widget.height as String,
          username: widget.username as String,
          name: widget.name as String,
          user: user,
          state: widget.state as String,
          country: widget.country as String,
          primaryLanguage: widget.language as String,
        );
  }

  @override
  void initState() {
    widget.name = widget.user.name ?? "";
    widget.username = widget.user.username ?? "";
    widget.height = widget.user.height ?? "";
    widget.weight = widget.user.weight ?? "";
    widget.country = widget.user.country ?? "";
    widget.state = widget.user.state ?? "";
    widget.language = widget.user.primaryLanguage ?? languageList.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool useMobileLayout = MediaQuery.of(context).size.shortestSide < 600;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            margin: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    minRadius: useMobileLayout ? 40 : 120,
                    child: const Icon(
                      Icons.account_circle_outlined,
                      size: 100,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Name:',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 20 : 40,
                            fontWeight: FontWeight.bold,
                            color: const Color(PURPLE_COLOR)),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: useMobileLayout ? 150 : 300,
                        child: TextField(
                          controller: _nameTextEdittingController
                            ..text = _initialText(widget.name),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                          onChanged: (text) {
                            widget.name = text;
                          },
                          onSubmitted: (text) {
                            widget.name = text;
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey[400]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Username:',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 20 : 40,
                            fontWeight: FontWeight.bold,
                            color: const Color(PURPLE_COLOR)),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: useMobileLayout ? 150 : 300,
                        child: TextField(
                          controller: _usernameTextEdittingController
                            ..text = _initialText(widget.username),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                          onChanged: (text) {
                            widget.username = text;
                            debugPrint(widget.username);
                          },
                          onSubmitted: (text) => widget.username = text,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey[400]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Height (cm):',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 20 : 40,
                            fontWeight: FontWeight.bold,
                            color: const Color(PURPLE_COLOR)),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: useMobileLayout ? 150 : 300,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _heightTextEdittingController
                            ..text = _initialText(widget.height),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                          onChanged: (text) {
                            widget.height = text;
                            debugPrint(widget.height);
                          },
                          onSubmitted: (text) => widget.height = text,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey[400]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Weight (kg):',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 20 : 40,
                            fontWeight: FontWeight.bold,
                            color: const Color(PURPLE_COLOR)),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: useMobileLayout ? 150 : 300,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _weightTextEdittingController
                            ..text = _initialText(widget.weight),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                          onChanged: (text) {
                            widget.weight = text;
                            debugPrint(widget.weight);
                          },
                          onSubmitted: (text) => widget.weight = text,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey[400]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Country:',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 20 : 40,
                            fontWeight: FontWeight.bold,
                            color: const Color(PURPLE_COLOR)),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: useMobileLayout ? 150 : 300,
                        child: TextField(
                          controller: _countryTextEdittingController
                            ..text = _initialText(widget.country),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                          onChanged: (text) {
                            widget.country = text;
                          },
                          onSubmitted: (text) {
                            widget.country = text;
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey[400]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'State/Province:',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 20 : 40,
                            fontWeight: FontWeight.bold,
                            color: const Color(PURPLE_COLOR)),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: useMobileLayout ? 150 : 300,
                        child: TextField(
                          controller: _stateTextEdittingController
                            ..text = _initialText(widget.state),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                          onChanged: (text) {
                            widget.state = text;
                          },
                          onSubmitted: (text) {
                            widget.state = text;
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey[400]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Primary Language:',
                        style: TextStyle(
                            fontSize: useMobileLayout ? 20 : 40,
                            fontWeight: FontWeight.bold,
                            color: const Color(PURPLE_COLOR)),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: useMobileLayout ? 150 : 300,
                        child: DropdownButton(
                          isExpanded: true,
                          value: widget.language,
                          elevation: 16,
                          onChanged: (String? value) {
                            setState(() {
                              widget.language = value as String;
                            });
                          },
                          items: languageList.map((String value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        _updateUser(widget.user);
                        Navigator.pop(context);
                      },
                      child: const Text("Submit",
                          style: TextStyle(color: Color(PURPLE_COLOR)))),
                ],
              ),
            )));
  }
}
