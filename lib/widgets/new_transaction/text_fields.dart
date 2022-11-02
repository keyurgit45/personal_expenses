import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/new_transaction_controller.dart';

class TextInputFields extends StatelessWidget {
  TextInputFields({super.key});
  final NewTransactionController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Column(
        children: [
          TextField(
            controller: c.titleController.value,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 33, 150, 243)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 33, 150, 243)),
              ),
              labelText: 'Title',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 33, 150, 243),
              ),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: c.amountController.value,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 33, 150, 243)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 33, 150, 243)),
              ),
              labelText: 'Amount',
              labelStyle: TextStyle(
                color: Color.fromARGB(255, 33, 150, 243),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
