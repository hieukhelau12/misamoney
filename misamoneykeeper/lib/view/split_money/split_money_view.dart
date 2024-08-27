import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class SplitMoneyView extends StatefulWidget {
  const SplitMoneyView({super.key});

  @override
  State<SplitMoneyView> createState() => _SplitMoneyViewState();
}

class _SplitMoneyViewState extends State<SplitMoneyView> {
  final _moneyController = TextEditingController(text: '0');
  final TextEditingController _quantity = TextEditingController(text: '0');
  final _formKey = GlobalKey<FormState>();
  double? result = 0;
  String? formatResult = '0';

  void calculateDivision() {
    int? quantity = int.parse(_quantity.text);
    String moneyRP = _moneyController.text.replaceAll(".", "");
    double? money = double.tryParse(moneyRP);
    if (money != null && money != 0 && quantity != 0) {
      setState(() {
        result = money / quantity;
        int integerPart = result!.toInt();
        final format = NumberFormat('###,###,###', 'vi-VI');
        formatResult = format.format(integerPart);
      });
    } else {
      setState(() {
        formatResult = '0';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Chia tiền',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        actions: [
          //Hiện thị nút reset
          IconButton(
            onPressed: () {
              _moneyController.text = '0';
              _quantity.text = '0';
              result = 0;
              setState(() {});
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 28,
              color: Colors.white,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Số tiền',
                          style: TextStyle(color: Colors.black54)),
                      //Hiện thị ô nhập thông tin số tiền
                      TextFormField(
                        controller: _moneyController,
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        onTap: () => _moneyController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: _moneyController.value.text.length),
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(16),
                          FilteringTextInputFormatter.digitsOnly,
                          //Format tiền
                          CurrencyInputFormatter(
                              thousandSeparator: ThousandSeparator.Period,
                              useSymbolPadding: true,
                              mantissaLength: 0)
                        ], // Only numbers can be entered
                        style: const TextStyle(fontSize: 28),
                        decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                      ),
                      const Divider(
                        height: 0.8,
                        thickness: 0.8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  height: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Số thành viên',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      //Hiện thị ô nhập thông tin số lượng người
                      TextFormField(
                        controller: _quantity,
                        validator: (value) {
                          String numberWithOutDot =
                              _moneyController.value.text.replaceAll('.', '');
                          if (int.parse(value!) > int.parse(numberWithOutDot)) {
                            return "Số người không được vượt quá số tiền";
                          }
                          return null;
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onTap: () => _quantity.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: _quantity.value.text.length),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}')),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Số người',
                          prefixIcon: Icon(Icons.group),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Hiện thị nút reset
                      ElevatedButton(
                          onPressed: () {
                            _moneyController.text = '0';
                            _quantity.text = '0';
                            formatResult = '0';
                            setState(() {});
                          },
                          child: const Text('Reset')),
                      const SizedBox(
                        width: 15,
                      ),
                      //Hiện thị nút kết quả
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              calculateDivision();
                            }
                          },
                          child: const Text('Kết quả')),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //Hiện thị số tiền sau khi chia
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Số tiền khi chia:',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text('$formatResult'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
