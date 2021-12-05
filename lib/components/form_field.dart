import 'package:flutter/material.dart';

Widget buildTextFormField(
    String label, String prefix, TextEditingController controller, Function f) {
  return TextField(
    onChanged: (value) => f(value),
    controller: controller,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(),
        prefixText: "$prefix "),
    style: const TextStyle(color: Colors.grey, fontSize: 25.0),
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
  );
}
