import 'package:flutter/material.dart';

class AmountText extends StatelessWidget {
  const AmountText({
    required this.amount,
  });

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Text(
      '€ ' + amount.toString(),
      style: TextStyle(color: amount < 0 ? Colors.red : Colors.green),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
