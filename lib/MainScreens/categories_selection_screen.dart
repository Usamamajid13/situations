import 'dart:convert';

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
  CategoryModel? categoryModel;
  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    checkSelectedTypes();
  }

  void getDataFromFirebase() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance.collection('data').doc('data').get();

    if (documentSnapshot.exists && documentSnapshot.data() != null) {
      List<dynamic> data = documentSnapshot.data()!['categories'];
      if (kDebugMode) {
        print(data);
      }

      for (var category in data) {
        categoryModel = CategoryModel.fromJson(jsonDecode(category));

        categories.add(categoryModel!);
        setState(() {});
      }
      for (int i = 0; i < categories.length; i++) {
        if (kDebugMode) {
          print(categories[i].category);
        }
        for (int j = 0; j < categories[i].questions!.length; j++) {
          if (kDebugMode) {
            print(categories[i].questions![j].question.toString());
          }
        }
        if (kDebugMode) {
          print("\n ");
        }
      }
    }
    setState(() {});
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
                style: utils.largeHeadingTextStyle(
                  color: pinkColor,
                  fontFamily: "PassionOne",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              for (int i = 0; i < categories.length; i++)
                selected == 0
                    ? GestureDetector(
                        onTap: () {
                          categoryIndex = i;
                          Navigator.pushNamed(
                            context,
                            questionScreenRoute,
                            arguments: categories,
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
                              categories[i].category.toString(),
                              style: utils.mediumTitleBoldTextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                        ),
                      )
                    : selected == 1 &&
                            categories[i]
                                .questions!
                                .any((element) => element.type == "Dilemma")
                        ? GestureDetector(
                            onTap: () {
                              categoryIndex = i;
                              Navigator.pushNamed(
                                context,
                                questionScreenRoute,
                                arguments: categories,
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
                                  categories[i].category.toString(),
                                  style: utils.mediumTitleBoldTextStyle(
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                              ),
                            ),
                          )
                        : selected == 2 &&
                                categories[i].questions!.any(
                                    (element) => element.type == "Situations")
                            ? GestureDetector(
                                onTap: () {
                                  categoryIndex = i;
                                  Navigator.pushNamed(
                                    context,
                                    questionScreenRoute,
                                    arguments: categories,
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
                                      categories[i].category.toString(),
                                      style: utils.mediumTitleBoldTextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
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
                  setState(() {});
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
                        fontFamily: "MontserratBold",
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
    categories = [];
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
    getDataFromFirebase();
  }
}

class CategoryModel {
  String? category;
  List<Questions>? questions;

  CategoryModel({this.category, this.questions});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? question;
  String? type;
  String? category;
  int? likes;

  Questions({this.question, this.type, this.category, this.likes});

  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    type = json['type'];
    category = json['category'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['type'] = type;
    data['category'] = category;
    data['likes'] = likes;
    return data;
  }
}
