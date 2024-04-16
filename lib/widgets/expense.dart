import 'package:expense/widgets/chart/chart.dart';
import 'package:expense/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'expense_list/expenses_list.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  late List<Expense> _registeredExpenses;

  @override
  void initState() {
    super.initState();
    _registeredExpenses = [
      Expense(
        title: 'Sample Expense',
        amount: 12,
        date: DateTime.now(),
        category: Category.work,
      ),
    ];
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: const Text('Deleted'),
      action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  void _openAddExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('Start some expenses'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpense,
            icon: const Icon(Icons.add),
            padding: const EdgeInsets.all(20),
          ),
        ],
        backgroundColor: Colors.amber,
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}



/*import 'package:expense/widgets/expense_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense/models/expense.dart';

class Expense extends StatefulWidget {
  const Expense(
      {super.key,
      required String title,
      required int amount,
      required DateTime date,
      required Category category});
  @override
  State<Expense> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expense> {
  late List<Expense> _registeredExpenses;
  @override
  void initState() {
    super.initState();
    _registeredExpenses = [
      Expense(
        title: 'Sample Expense',
        amount: 12,
        date: DateTime.now(),
        category: Category.work,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('chart'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          )
        ],
      ),
    );
  }
}*/
