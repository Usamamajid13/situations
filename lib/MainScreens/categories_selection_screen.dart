import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:situations/Constants/constants.dart';

import '../Utils/app_utils.dart';

class CategoriesSelectionScreen extends StatefulWidget {
  const CategoriesSelectionScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesSelectionScreen> createState() =>
      _CategoriesSelectionScreenState();
}

class _CategoriesSelectionScreenState extends State<CategoriesSelectionScreen> {
  var utils = AppUtils();
  int selected = 0;

  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    checkSelectedTypes();
  }

  void getCategories() async {
    // Get categories based on selected types

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    categories = snapshot.docs.map((category) {
      String type = category['type'];
      return CategoryModel(id: category.id, name: category['name'], type: type);
    }).toList();

    setState(() {}); // Update UI
    if (kDebugMode) {
      print(categories.toString());
    }
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                "Choose a category",
                style: utils.largeHeadingTextStyle(color: pinkColor),
              ),
              const SizedBox(
                height: 30,
              ),
              for (int i = 0; i < categories.length; i++)
                selected == 0
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            questionScreenRoute,
                            arguments: {
                              'name': categories[i].name,
                              'type': categories[i].type,
                              'id': categories[i].id,
                            },
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            image: const DecorationImage(
                              image: AssetImage(
                                "assets/glass2.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              categories[i].name.toString(),
                              style: utils.mediumTitleBoldTextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : selected == 1 &&
                            categories[i].type.toString() == "Dilemmas"
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                questionScreenRoute,
                                arguments: {
                                  'name': categories[i].name,
                                  'type': categories[i].type,
                                  'id': categories[i].id,
                                },
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 50,
                              margin: const EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 2,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                image: const DecorationImage(
                                  image: AssetImage(
                                    "assets/glass2.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  categories[i].name.toString(),
                                  style: utils.mediumTitleBoldTextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : selected == 2 &&
                                categories[i].type.toString() == "Situations"
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    questionScreenRoute,
                                    arguments: {
                                      'name': categories[i].name,
                                      'type': categories[i].type,
                                      'id': categories[i].id,
                                    },
                                  );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height: 50,
                                  margin: const EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 2,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        "assets/glass2.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      categories[i].name.toString(),
                                      style: utils.mediumTitleBoldTextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  await Navigator.pushNamed(context, settingsScreenRoute);
                  checkSelectedTypes();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Settings",
                      style: utils.mediumTitleBoldTextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
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
      selected = 0;
      setState(() {});
    } else if (selectedTypes.contains(CategoryType.Dilemmas)) {
      if (kDebugMode) {
        print('2');
      }
      selected = 1;
      setState(() {});
    } else if (selectedTypes.contains(CategoryType.Situations)) {
      if (kDebugMode) {
        print('3');
      }
      selected = 2;
      setState(() {});
    }
    getCategories();
  }
}

class CategoryModel {
  final String id;
  final String name;
  final String type;

  CategoryModel({required this.id, required this.name, required this.type});
}
