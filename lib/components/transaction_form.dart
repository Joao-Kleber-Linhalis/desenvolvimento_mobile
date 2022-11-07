import 'package:flutter/material.dart';
import '/uteis/widgts/CampoTextFormField.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double,DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  //Controladores de texto gamers
  final _controlTitulo = TextEditingController();
  final _controlValor = TextEditingController();

   DateTime _selectedDate = DateTime.now();

  _submitform() {
    final title = _controlTitulo.text;
    //Se não for possivel converter o valor do campo valor, vai ser colocado como 0.0 por padrão
    final value = double.tryParse(_controlValor.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
    _controlTitulo.clear();
    _controlValor.clear();
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), //Data Inicial marcada = hoje
      firstDate: DateTime.now()
          .subtract(Duration(days: 365)), //Primeira Data possivel hoje - 1 ano
      lastDate: DateTime.now()
          .add(Duration(days: 365)), //Ultma Data possivel hoje + 1 ano
      locale: Locale('pt','BR'),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            //Formulário Titulo/nome
            CampoTextFormField("Título",
                texto_dica: "Escreva o nome da despesa.",
                controlador: _controlTitulo),
            SizedBox(
              height: 10,
            ),

            //Formulário Valor
            CampoTextFormField(
              "Valor(R\$)",
              texto_dica: "Escreva o valor da despesa.",
              teclado:
                  TextInputType.numberWithOptions(decimal: true, signed: false),
              controlador: _controlValor,
              funcao: widget.onSubmit,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null ? 'Nenhuma data selecionada!'
                      : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    style: TextButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).copyWith().colorScheme.primary,
                    ),
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                        color: Theme.of(context).copyWith().colorScheme.primary,
                      ),
                    ),
                  )
                ],
              ),
            ),
            //Row pra mudar a posição dele
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Botão para adicionar nova transação
                ElevatedButton(
                  onPressed: _submitform,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).copyWith().colorScheme.primary,
                    elevation: 5,
                    side: BorderSide(
                        color:
                            Theme.of(context).copyWith().colorScheme.primary),
                  ),
                  child: Text(
                    "Nova Despesa",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
