// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

void main() {
  runApp(const MyCurrencyPage());
}

class MyCurrencyPage extends StatefulWidget {
  const MyCurrencyPage({Key? key}) : super(key: key);

  @override
  State<MyCurrencyPage> createState() => _MyCurrencyPageState();
}

class _MyCurrencyPageState extends State<MyCurrencyPage> {
  String selectFiat = "Malaysia", desc = "Select a currency";

  var unit, value, type;
  List<String> typeList = ["Crypto", "Fiat"];
  List<String> cryptoList = [
    "Bitcoin",
    "Ether",
    "Litecoin",
    "Bitcoin Cash",
    "Bitcoin Coin",
    "EOS",
    "XRP",
    "Lumens",
    "Chainlink",
    "Polkadot",
    "Yearn Finance",
    "Bits",
    "Satoshi"
  ];
  List<String> fiatList = [
    "US Dollar",
    "United Arab Emirates Dirham",
    "Argentine Peso",
    "Australian Dollar",
    "Bangladeshi Taka",
    "Bahraini Dinar",
    "Bermudian Dollar",
    "Brazil Real",
    "Canadian Dollar",
    "Swiss Franc",
    "Chilean Peso",
    "Chinese Yuan",
    "Czech Koruna",
    "Danish Krone",
    "Euro",
    "British Pound Sterling",
    "Hong Kong Dollar",
    "Hungarian Forint",
    "Indonesian Rupiah",
    "Israeli New Shekel",
    "Indian Rupee",
    "Japanese Yen",
    "South Korean Won",
    "Kuwaiti Dinar",
    "Sri Lankan Rupee",
    "Burmese Kyat",
    "Mexican Peso",
    "Malaysian Ringgit",
    "Nigerian Naira",
    "Norwegian Krone",
    "New Zealand Dollar",
    "Philippine Peso",
    "Pakistani Rupee",
    "Polish Zloty",
    "Russian Ruble",
    "Saudi Riyal",
    "Swedish Krona",
    "Singapore Dollar",
    "Thai Baht",
    "Turkish Lira",
    "New Taiwan Dollar",
    "Ukrainian hryvnia",
    "Venezuelan bolívar fuerte",
    "Vietnamese đồng",
    "South African Rand",
    "IMF Special Drawing Rights"
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    TextEditingController inputDecoration = TextEditingController();
    // ignore: unused_local_variable
    TextEditingController outputDecoration = TextEditingController();

    return MaterialApp(
      title: 'Bitcoin Currency Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(title: const Text("Bitcoin Currency")),
          body: Center(
              child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/bitcoin.jpg"),
                    fit: BoxFit.cover,
                  )),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const Text("Bitcoin Currency Calculator",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                backgroundColor: Colors.white,
                                color: Colors.black)),
                        const SizedBox(height: 30),
                        //have a list of the available fiat using a scrolldown box

                        //textfield that enable user to key in values
                        TextField(
                          //controller: inputEditingController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Amount',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),

                        const SizedBox(height: 50),

                        const Text("Bitcoin Currency Return",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),

                        const SizedBox(height: 10),

                        //return value of bitcoin currency
                        TextField(
                          //controller: locEditingController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Return',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ],
                    ),
                  )))),
    );
  }
}
