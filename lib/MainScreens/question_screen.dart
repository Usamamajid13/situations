import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../Constants/constants.dart';
import '../Utils/app_utils.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var utils = AppUtils();
  int _key = 0;

  final StreamController<void> _streamController = StreamController<void>();
  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final String name = arguments['name'];
    final String type = arguments['type'];
    final String id = arguments['id'];
    if (kDebugMode) {
      print(type);
    }
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
                    type == "Situations"
                        ? "assets/situationsIcon.png"
                        : "assets/DilemmasIcon.png",
                    scale: 4,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    type.toUpperCase(),
                    style: utils.largeHeadingTextStyle(
                      color: type == "Situations" ? pinkColor : blueColor,
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
                          stops: [
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
                      child: StreamBuilder<QuerySnapshot>(
                        key: ValueKey<int>(_key),
                        stream: FirebaseFirestore.instance
                            .collection('categories')
                            .doc(id)
                            .collection('questions')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Loading...');
                          }

                          final questions = snapshot.data!.docs;
                          if (kDebugMode) {
                            print(questions.length);
                          }

                          return questions.isNotEmpty
                              ? GlassmorphicContainer(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.61,
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
                                    stops: [
                                      0.1,
                                      1,
                                    ],
                                  ),
                                  borderGradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color(0xFFffffff).withOpacity(0.5),
                                      const Color((0xFFFFFFFF))
                                          .withOpacity(0.5),
                                    ],
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              name,
                                              style: utils
                                                  .extraSmallTitleTextStyle(
                                                color: Colors.white,
                                                fontFamily: "Montserrat",
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          questions[Random()
                                                  .nextInt(questions.length)]
                                              ['question'],
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
                                            const Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (kDebugMode) {
                                                  print("Change");
                                                }
                                                _streamController.add(null);
                                                _key++;

                                                setState(() {});
                                              },
                                              child: const Icon(
                                                CupertinoIcons
                                                    .arrow_2_circlepath,
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.61,
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
                                    stops: [
                                      0.1,
                                      1,
                                    ],
                                  ),
                                  borderGradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color(0xFFffffff).withOpacity(0.5),
                                      const Color((0xFFFFFFFF))
                                          .withOpacity(0.5),
                                    ],
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.65,
                                      padding: const EdgeInsets.all(20.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            child: Center(
                                              child: Text(
                                                name,
                                                style: utils
                                                    .extraSmallTitleTextStyle(
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
                                                  if (kDebugMode) {
                                                    print("Change");
                                                  }
                                                  _streamController.add(null);
                                                  _key++;

                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                  CupertinoIcons
                                                      .arrow_2_circlepath,
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
                                );
                        },
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
                  children: [
                    const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    const SizedBox(
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
