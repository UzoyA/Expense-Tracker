import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

 

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses =[
    Expense(
      title: 'Flutter Course', 
      amount: 19.99, 
      date: DateTime.now(), 
      catagory: Category.Work,
    ),
    Expense(
      title: 'Cinema', 
      amount: 15.69, 
      date: DateTime.now(), 
      catagory: Category.Leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }


  void _removeExpense(Expense expense) {
    final  expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(
                expenseIndex, expense
              );
            });
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
              expenses: _registeredExpenses, 
              onRemoveExpense: _removeExpense
            );
    }

    return  Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 18,
          color: Color.fromARGB(255, 231, 234, 234)
        ),
        centerTitle: context.mounted,
        leading: IconButton(
          onPressed: () {}, 
          icon: Icon(Icons.menu),
          color: Colors.white,
          ),
        backgroundColor: 
        Color.fromARGB(255, 7, 35, 49),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay, 
            icon: const Icon(Icons.add),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
        
      ),
    );
  }
}