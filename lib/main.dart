import 'package:expenses/telas/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TransactionScreen(),

      //Definição esquema de cores
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          //Itens normais
          primary: Colors.purple,
          //Itens de destaque
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headline5: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            button: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt','BR'),
      ],
    );
  }
}
