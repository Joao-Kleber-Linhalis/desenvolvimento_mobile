import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses/components/controls/control_transactions.dart';
import 'package:expenses/models/usuario.dart';
import 'package:expenses/telas/controls/control_transaction_screen.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import '../components/chart.dart';
import '../components/transaction_form.dart';
import '../components/transaction_list.dart';
import '../models/transaction.dart';

class TransactionScreen extends StatefulWidget {
  Usuario user;

  TransactionScreen(this.user);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  late ControlTransactionScreen _control;
  late ControlTransaction _controlTransaction;
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Botão animado
    _control = ControlTransactionScreen(widget.user);
    _controlTransaction = ControlTransaction(widget.user);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  List<Transacation> get _recentTransaction {
    return _control.transactions!.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date, Usuario user) {
    final newTransaction = Transacation(
      title: title,
      date: date,
      value: value,
      id_usuario: user.id,
    );

    _controlTransaction.insert(newTransaction);
    Navigator.of(context).pop();
  }

  _removeTransaction(int id) {
    _control.deleteTransaction(id);  
  }

  _transactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction, widget.user);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: [
          IconButton(
              onPressed: () => _transactionFormModal(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
            icon: Icons.add,
            iconColor: Theme.of(context).copyWith().colorScheme.secondary,
            title: "Adicionar",
            titleStyle: Theme.of(context).textTheme.button!,
            bubbleColor: Theme.of(context).copyWith().colorScheme.primary,
            onPress: () => _transactionFormModal(context),
          ),
          Bubble(
            icon: Icons.exit_to_app,
            iconColor: Theme.of(context).copyWith().colorScheme.secondary,
            title: "Deslogar",
            titleStyle: Theme.of(context).textTheme.button!,
            bubbleColor: Theme.of(context).copyWith().colorScheme.primary,
            onPress: () => _control.exit(context),
          ),
        ],
        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),
        
        // Floating Action button Icon color
        iconColor:Theme.of(context).copyWith().colorScheme.secondary,

        // Flaoting Action button Icon 
        iconData: Icons.home, 
        backGroundColor: Theme.of(context).copyWith().colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  _body(){
    return _stream_builder();
  }

  Container _stream_builder(){
    return Container(
      padding: EdgeInsets.all(16),
      child: StreamBuilder<QuerySnapshot>(
          stream: _control.stream,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            _control.getTransactions(snapshot.data!);
            return _scrollView();
          }
      ),
    );
  }

  SingleChildScrollView _scrollView(){
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransaction),
            TransactionList(_control.transactions!, _removeTransaction)
          ],
        ),
      );
  }
}
