import 'package:flutter/material.dart';

class AmountText extends StatelessWidget {
  const AmountText({
    super.key,
    required this.amount,
  });

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Text(
      '€ $amount',
      style: TextStyle(color: amount < 0 ? Colors.red : Colors.green),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
