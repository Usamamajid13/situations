import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Constants/constants.dart';
import '../Utils/app_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var utils = AppUtils();
  int selected = 0;

  @override
  void initState() {
    checkSelectedTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/backgroundImage.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              "Settings",
              style: utils.largeHeadingTextStyle(color: pinkColor),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      updateSelectedTypes(CategoryType.both);
                      setState(() {
                        selected = 1;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Center(
                            child: selected == 1
                                ? Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: pinkColor,
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Dilemmas and Situations",
                          style:
                              utils.mediumTitleTextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      updateSelectedTypes(CategoryType.Dilemmas);

                      setState(() {
                        selected = 2;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Center(
                            child: selected == 2
                                ? Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: pinkColor,
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Only Dilemmas",
                          style:
                              utils.mediumTitleTextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      updateSelectedTypes(CategoryType.Situations);

                      setState(() {
                        selected = 3;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Center(
                            child: selected == 3
                                ? Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: pinkColor,
                                      borderRadius: BorderRadius.circular(2.0),
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Only Situations",
                          style:
                              utils.mediumTitleTextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    "SAVE",
                    style: utils.largeHeadingTextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkSelectedTypes() {
    if (selectedTypes.contains(CategoryType.Situations) &&
        selectedTypes.contains(CategoryType.Dilemmas)) {
      if (kDebugMode) {
        print('1');
      }
      selected = 1;
      setState(() {});
    } else if (selectedTypes.contains(CategoryType.Dilemmas)) {
      if (kDebugMode) {
        print('2');
      }
      selected = 2;
      setState(() {});
    } else if (selectedTypes.contains(CategoryType.Situations)) {
      if (kDebugMode) {
        print('3');
      }
      selected = 3;
      setState(() {});
    }
  }
}
