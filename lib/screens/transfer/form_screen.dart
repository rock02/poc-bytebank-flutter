import 'package:flutter/material.dart';
import 'package:poc_bytebank_flutter/components/editor.dart';
import 'package:poc_bytebank_flutter/models/transfer.dart';

const _titleAppBar = 'Criando Transferência';

const _labelFieldValue = 'Valor';
const _hintFieldValue = '0.00';

const _labelFieldAccountNumber = 'Número da conta';
const _tipFieldAccountNumber = '0000';

const _buttonTextConfirm = 'Confirmar';

class TransferForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransferFormState();
  }
}

class TransferFormState extends State<TransferForm> {
  final TextEditingController _controllerFieldAccountNumber =
      TextEditingController();
  final TextEditingController _controllerFieldValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_titleAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                controlador: _controllerFieldAccountNumber,
                dica: _tipFieldAccountNumber,
                rotulo: _labelFieldAccountNumber,
              ),
              Editor(
                dica: _hintFieldValue,
                controlador: _controllerFieldValue,
                rotulo: _labelFieldValue,
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                child: Text(_buttonTextConfirm),
                onPressed: () => _createTransfer(context),
              ),
            ],
          ),
        ));
  }

  void _createTransfer(BuildContext context) {
    final int? accountNumber = int.tryParse(_controllerFieldAccountNumber.text);
    final double? value = double.tryParse(_controllerFieldValue.text);
    if (accountNumber != null && value != null) {
      final createdTransfer = Transfer(value, accountNumber);
      Navigator.pop(context, createdTransfer);
    }
  }
}
