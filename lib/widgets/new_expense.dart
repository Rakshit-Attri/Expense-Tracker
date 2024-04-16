import 'package:flutter/material.dart';
import 'package:expense/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.lesiure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please enter a valid data'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Close')),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  /*var _enteredTitle = '';
  void _saveTitleInput(String inputValue) {
    _enteredTitle = inputValue;
  }*/

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, Constraints) {
      final Width = Constraints.maxWidth;
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, keyboardSpace + 20),
            child: Column(
              children: [
                if (Width >= 600)
                  Row(
                    children: [
                      TextField(
                        controller: _titleController,

                        //onChanged: _saveTitleInput,
                        maxLength: 50,
                        decoration: const InputDecoration(label: Text('Title')),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const TextField(
                        decoration: InputDecoration(
                            prefixText: '\$ ', label: Text('Amount')),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,

                    //onChanged: _saveTitleInput,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text('Title')),
                  ),
                if (Width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((Category) => DropdownMenuItem(
                                  value: Category,
                                  child: Text(Category.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_selectedDate == null
                              ? 'No Date Selected'
                              : formatter.format(_selectedDate!)),
                          IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ),
                    ],
                  )
                else
                  const TextField(
                    decoration: InputDecoration(
                        prefixText: '\$ ', label: Text('Amount')),
                    keyboardType: TextInputType.number,
                  ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (Width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((Category) => DropdownMenuItem(
                                  value: Category,
                                  child: Text(Category.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save'),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
