import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class CurrencyCalc extends StatelessWidget {
  const CurrencyCalc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Currency Calculator'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(child: const CurrencyForm()),
          ]),
        ),
      ),
    );
  }
}

class CurrencyForm extends StatefulWidget {
  const CurrencyForm({Key? key}) : super(key: key);

  @override
  State<CurrencyForm> createState() => _CurrencyFormState();
}

class _CurrencyFormState extends State<CurrencyForm> {
  TextEditingController inputController = TextEditingController();
  TextEditingController outputController = TextEditingController();
  String selectNameFrom = "btc";
  String selectNameTo = "btc";
  double input = 0.0;
  var result;
  var value1, value2, rate, unit1, unit2, type1, type2;
  String desc = "No value to be converted.";

  List<String> fromList = [
    "btc",
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "link",
    "dot",
    "yfi",
    "usd",
    "aed",
    "ars",
    "aud",
    "bdt",
    "bhd",
    "bmd",
    "brl",
    "cad",
    "chf",
    "clp",
    "cny",
    "czk",
    "dkk",
    "eur",
    "gbp",
    "hkd",
    "huf",
    "idr",
    "ils",
    "inr",
    "jpy",
    "krw",
    "kwd",
    "lkr",
    "mmk",
    "mxn",
    "myr",
    "ngn",
    "nok",
    "nzd",
    "php",
    "pkr",
    "pln",
    "rub",
    "sar",
    "sek",
    "sgd",
    "thb",
    "try",
    "twd",
    "uah",
    "vef",
    "vnd",
    "zar",
    "xdr",
    "xag",
    "xau",
    "bits",
    "sats",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          const Text("Currency Calculator",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 24,
                  fontStyle: FontStyle.italic)),
          const SizedBox(height: 30),
          Row(children: [
            const Expanded(
                child: Text("From",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(width: 0.01),
            Expanded(
              child: TextFormField(
                controller: inputController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    hintText: "Insert Amount Value",
                    //errorText: "Please insert a value.",
                    //fillColor: Colors.red,
                    suffixIcon: IconButton(
                      onPressed: () => inputController.clear(),
                      icon: const Icon(Icons.clear),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0))),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
                child: DropdownButton(
              alignment: Alignment.centerRight,
              itemHeight: 70,
              value: selectNameFrom,
              onChanged: (newValue) {
                setState(() {
                  selectNameFrom = newValue.toString();
                });
              },
              items: fromList.map((selectNameFrom) {
                return DropdownMenuItem(
                  child: Text(
                    selectNameFrom,
                  ),
                  value: selectNameFrom,
                );
              }).toList(),
            ))
          ]),
          const SizedBox(height: 12.0),
          Row(children: [
            const Expanded(
                child: Text("To",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            Expanded(
              child: TextField(
                controller: outputController,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                    hintText: "Return Value",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0))),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
                child: DropdownButton(
              alignment: Alignment.centerRight,
              itemHeight: 70,
              value: selectNameTo,
              onChanged: (newValue) {
                setState(() {
                  selectNameTo = newValue.toString();
                });
              },
              items: fromList.map((selectNameTo) {
                return DropdownMenuItem(
                  child: Text(
                    selectNameTo,
                  ),
                  value: selectNameTo,
                );
              }).toList(),
            ))
          ]),
          const SizedBox(height: 12.0),
          ElevatedButton(child: const Text("Convert"), onPressed: _currenCalc),
          const SizedBox(height: 12.0),
          Text(desc,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.blueAccent)),
        ],
      ),
    );
  }

  Future<void> _currenCalc() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Load"), title: const Text("Converting...."));
    progressDialog.show();
    input = double.parse(inputController.text);

    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      value1 = parsedData['rates'][selectNameTo]['value'];
      unit1 = parsedData['rates'][selectNameTo]['unit'];
      type1 = parsedData['rates'][selectNameTo]['type'];
      value2 = parsedData['rates'][selectNameFrom]['value'];
      unit2 = parsedData['rates'][selectNameFrom]['unit'];
      type2 = parsedData['rates'][selectNameFrom]['type'];
      setState(() {
        input = double.parse(inputController.text);
        rate = value1 / value2;
        result = input * rate;

        outputController.text = result.toString();
        desc = "The currency rate from " +
            selectNameFrom.toString() +
            " to " +
            selectNameTo.toString() +
            " is " +
            rate.toString() +
            ".\n\nThe total amount of " +
            unit2.toString() +
            " " +
            input.toString() +
            " is equal to " +
            unit1.toString() +
            " " +
            result.toString() +
            " in type " +
            type1 +
            ".";
      });
    } else {
      setState(() {
        desc = "No result.";
      });
    }
    progressDialog.dismiss();
  }
}
