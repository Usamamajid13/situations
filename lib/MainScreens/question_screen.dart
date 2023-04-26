// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:like_button/like_button.dart';

import '../Constants/constants.dart';
import '../Utils/app_utils.dart';
import 'categories_selection_screen.dart';

class QuestionScreen extends StatefulWidget {
  List<CategoryModel> category;
  QuestionScreen(this.category, {Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var utils = AppUtils();
  int _key = 0;
  final random = Random();
  bool isLiked = false;
  int index = 0;
  int selected = 0;
  @override
  void initState() {
    checkSelectedTypes();

    super.initState();
  }

  final StreamController<void> _streamController = StreamController<void>();
  @override
  void dispose() {
    _streamController.close();
    super.dispose();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.category[categoryIndex].questions![index].type ==
                            "Situations"
                        ? "assets/situationsIcon.png"
                        : "assets/DilemmasIcon.png",
                    scale: 4,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.category[categoryIndex].questions![index].type!
                        .toUpperCase(),
                    style: utils.largeHeadingTextStyle(
                      color: widget.category[categoryIndex].questions![index]
                                  .type
                                  .toString() ==
                              "Situations"
                          ? pinkColor
                          : blueColor,
                      fontFamily: "PassionOne",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.64,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      bottom: 0,
                      child: GlassmorphicContainer(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.65,
                        borderRadius: 10.0,
                        blur: 20,
                        alignment: Alignment.center,
                        border: 0.5,
                        linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.1),
                            const Color(0xFFFFFFFF).withOpacity(0.05),
                          ],
                          stops: const [
                            0.1,
                            1,
                          ],
                        ),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.5),
                            const Color((0xFFFFFFFF)).withOpacity(0.5),
                          ],
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/glass.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: widget
                              .category[categoryIndex].questions!.isNotEmpty
                          ? GlassmorphicContainer(
                              key: ValueKey<int>(_key),
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.61,
                              borderRadius: 10.0,
                              blur: 20,
                              alignment: Alignment.center,
                              border: 0.5,
                              linearGradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFFffffff).withOpacity(0.1),
                                  const Color(0xFFFFFFFF).withOpacity(0.05),
                                ],
                                stops: const [
                                  0.1,
                                  1,
                                ],
                              ),
                              borderGradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFFffffff).withOpacity(0.5),
                                  const Color((0xFFFFFFFF)).withOpacity(0.5),
                                ],
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/glass.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          widget
                                              .category[categoryIndex].category
                                              .toString(),
                                          style: utils.extraSmallTitleTextStyle(
                                            color: Colors.white,
                                            fontFamily: "Montserrat",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      widget.category[categoryIndex]
                                          .questions![index].question
                                          .toString(),
                                      style: const TextStyle(
                                        fontFamily: "MontserratBold",
                                        fontSize: 20,
                                        color: Colors.white,
                                        height: 1.5,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LikeButton(
                                          onTap: onLikeButtonTapped,
                                          isLiked: isLiked,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            isLiked = false;
                                            if (kDebugMode) {
                                              print("Change");
                                            }
                                            _streamController.add(null);
                                            _key++;
                                            index = random.nextInt(widget
                                                .category[categoryIndex]
                                                .questions!
                                                .length);
                                            setState(() {});
                                          },
                                          child: const Icon(
                                            CupertinoIcons.arrow_2_circlepath,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          : GlassmorphicContainer(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: MediaQuery.of(context).size.height * 0.61,
                              borderRadius: 10.0,
                              blur: 20,
                              alignment: Alignment.center,
                              border: 0.5,
                              linearGradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFFffffff).withOpacity(0.1),
                                  const Color(0xFFFFFFFF).withOpacity(0.05),
                                ],
                                stops: const [
                                  0.1,
                                  1,
                                ],
                              ),
                              borderGradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFFffffff).withOpacity(0.5),
                                  const Color((0xFFFFFFFF)).withOpacity(0.5),
                                ],
                              ),
                              child: Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.65,
                                  padding: const EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 2,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        "assets/glass.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        child: Center(
                                          child: Text(
                                            widget.category[categoryIndex]
                                                .category
                                                .toString(),
                                            style:
                                                utils.extraSmallTitleTextStyle(
                                              color: Colors.white,
                                              fontFamily: "MontserratBold",
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        "No Questions Available",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          height: 1.5,
                                          fontFamily: "MontserratBold",
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(
                                            Icons.favorite_border,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _streamController.add(null);
                                              _key++;

                                              setState(() {});
                                            },
                                            child: const Icon(
                                              CupertinoIcons.arrow_2_circlepath,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Back to Categories",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: "PassionOne",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLike) async {
    isLiked = !isLiked;
    if (kDebugMode) {
      print(isLiked);
    }
    if (isLiked == true) {
      widget.category[categoryIndex].questions![index].likes =
          widget.category[categoryIndex].questions![index].likes! + 1;
    } else {
      widget.category[categoryIndex].questions![index].likes =
          widget.category[categoryIndex].questions![index].likes! - 1;
    }
    if (kDebugMode) {
      print("Assigned like");
    }
    if (kDebugMode) {
      print(widget.category[categoryIndex].questions![index].likes);
    }
    if (kDebugMode) {
      print("Updating Like");
    }
    if (kDebugMode) {
      print(widget.category);
    }
    updateData(widget.category);
    setState(() {});
    return isLiked;
  }

  Future<void> updateData(List<CategoryModel> categories) async {
    final categoriesdata = categories.map((entry) {
      return jsonEncode({
        "category": entry.category,
        "questions": entry.questions,
      });
    }).toList();
    final data = {
      "categories": categoriesdata,
    };

    try {
      await FirebaseFirestore.instance.collection("data").doc("data").set(data);
      if (kDebugMode) {
        print("Document updated");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
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
    index = random.nextInt(widget.category[categoryIndex].questions!.length);
    while (selected == 2 &&
        widget.category[categoryIndex].questions![index].type != "Situations") {
      index = random.nextInt(widget.category[categoryIndex].questions!.length);
      print(index);
    }
    while (selected == 1 &&
        widget.category[categoryIndex].questions![index].type != "Dilemma") {
      index = random.nextInt(widget.category[categoryIndex].questions!.length);
      print(index);
    }
    if (kDebugMode) {
      print(categoryIndex);
    }
    setState(() {});
  }
}

class QuestionModel {
  final String id;
  final String text;

  QuestionModel({
    required this.id,
    required this.text,
  });

  factory QuestionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return QuestionModel(
      id: snapshot.id,
      text: data['text'] as String? ?? '',
    );
  }
}
