// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const pinkColor = Color(0xffFD5E5E);
const blueColor = Color(0xff0137C2);

const splashScreenRoute = "/";
const settingsScreenRoute = "/settingsScreenRoute";
const questionScreenRoute = "/questionScreenRoute";
const landingScreenRoute = "/landingScreenRoute";
const categoriesSelectionScreenRoute = "/categoriesSelectionScreenRoute";

enum CategoryType {
  Situations,
  both,
  Dilemmas,
}

Set<CategoryType> selectedTypes = {
  CategoryType.Dilemmas,
  CategoryType.Situations
}; // Global variable to store selected types

void updateSelectedTypes(CategoryType type) {
  if (type == CategoryType.both) {
    selectedTypes = {CategoryType.Situations, CategoryType.Dilemmas};
  } else {
    selectedTypes = {type};
  }
}
