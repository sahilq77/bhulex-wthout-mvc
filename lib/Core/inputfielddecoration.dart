import 'package:flutter/material.dart';

import 'ColorFile.dart';
import 'SizeConfigs.dart';

InputDecoration fieldDecoration(String label) {
  return InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide:
          BorderSide(color: AppColors.borderColor, width: getHorizontalSize(2)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: getHorizontalSize(1)),
    ),
  );
}
