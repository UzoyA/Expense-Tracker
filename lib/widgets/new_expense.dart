import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  
  

  @override
  State<NewExpense> createState()
  => _NewExpenseState();
  
  
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.Leisure;

  void _persentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final PickedDate = await showDatePicker(
      context: context,
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: now,
    );
    setState(() {
      _selectedDate = PickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text
    );
     // tryParse('Hello') => null, tryParse('1.12') => 1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || 
        amountIsInvalid || 
        _selectedDate == null) {
          showDialog(
            context: context, 
            builder: (ctx) => AlertDialog(
              title: Text('Invalid Input'),
              content: const Text(
                  'Please make sure a valid title, amount, date and category was entered.'),
              actions: [
                TextButton(
                  onPressed: () {
                     Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                ),
              ],
            )
          );
          return;
          // show error messages
        }

        widget.onAddExpense(
          Expense(
          title: _titleController.text, 
          amount: enteredAmount,
          date: _selectedDate!, 
          catagory: _selectedCategory),
        );
        Navigator.pop(context);
      
  }




  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(23, 35, 25, 25),
        child: Column(
          children: [
          TextField(
            controller: _titleController,
            maxLength: 100,
            decoration: const InputDecoration(
              iconColor: Color.fromARGB(255, 36, 37, 40),
              label: Text('Title'),
            )
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null ? 'No date selected'
                      : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed:_persentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16,),
           Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                    items: Category.values.map(
                      (Category)  => DropdownMenuItem(
                        value: Category,
                        child: Text(
                          Category.name.toUpperCase(),
                        ),
                      ),
                    ).toList(), 
                  onChanged: (value) {
                    if (value == null) {
                        return;
                      }
                      setState(() {
                      _selectedCategory = value;
                    });
                    print(value);
                  }),
                  const Spacer(),
                 TextButton(
                   onPressed: () {
                    Navigator.pop(context);
                   },
                   child: const Text('Cancel'),
                  ),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child:const Text('Save Expense'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}