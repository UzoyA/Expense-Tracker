import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const  uuid = Uuid();

enum Category {Food, Travel, Leisure, Work, Business, School, Market, Fun}

const CategoryIcons = {
  Category.Food: Icons.lunch_dining,
  Category.Travel: Icons.flight_takeoff,
  Category.Leisure: Icons.movie,
  Category.Work: Icons.work,
  Category.Business: Icons.business_center,
  Category.School: Icons.library_books,
  Category.Market: Icons.local_mall,
  Category.Fun: Icons.emoji_emotions,
};


class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.catagory,
  }): id = uuid.v4();


  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category catagory;

  String get formattedDate{
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) 
  : expenses =allExpenses
       .where((expense) => expense.catagory == category)
       .toList();  

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += sum + expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}