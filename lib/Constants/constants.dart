// ignore_for_file: constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

const pinkColor = Color(0xffFD5E5E);
const blueColor = Color(0xff0137C2);

const splashScreenRoute = "/";
const settingsScreenRoute = "/settingsScreenRoute";
const questionScreenRoute = "/questionScreenRoute";
const landingScreenRoute = "/landingScreenRoute";
const categoriesSelectionScreenRoute = "/categoriesSelectionScreenRoute";

var categoryIndex;

enum CategoryType {
  Situations,
  both,
  Dilemmas,
}

Set<CategoryType> selectedTypes = {
  CategoryType.Dilemmas,
  CategoryType.Situations
};

void updateSelectedTypes(CategoryType type) {
  if (type == CategoryType.both) {
    selectedTypes = {CategoryType.Situations, CategoryType.Dilemmas};
  } else {
    selectedTypes = {type};
  }
}
