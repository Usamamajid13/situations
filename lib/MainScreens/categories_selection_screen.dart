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
              for (int i = 0; i < 10; i++)
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, questionScreenRoute);
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
                        "Family & Friends",
                        style: utils.mediumTitleBoldTextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, settingsScreenRoute);
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
}
