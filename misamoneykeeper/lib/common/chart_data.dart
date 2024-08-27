import 'package:misamoneykeeper_flutter/utility/export.dart';

class ChartData {
            final String x;
            final double y;
            final Color color;
            ChartData(this.x, this.y, this.color);
    }
    final List<Expense> incomeData = [
    Expense(category: 'January', amount: 4000),
    Expense(category: 'February', amount: 2000),
    Expense(category: 'March', amount: 3000),
  ];

  final List<Expense> expenseData = [
    Expense(category: 'January', amount: 2000),
    Expense(category: 'February', amount: 2500),
    Expense(category: 'March', amount: 1500),
  ];



 double getTotalIncome() {
    double total = 0;
    incomeData.forEach((expense) {
      total += expense.amount;
    });
    return total;
  }

  double getTotalExpense() {
    double total = 0;
    expenseData.forEach((expense) {
      total += expense.amount;
    });
    return total;
  }


class Expense {
  final String category;
  final double amount;

  Expense({required this.category, required this.amount});
}