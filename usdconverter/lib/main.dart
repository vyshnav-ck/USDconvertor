import 'package:flutter/material.dart';
import 'package:paisa/paisa.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterScreenState createState() => _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  // text field
  TextEditingController inrController = TextEditingController();
  // converting to ->
  double usdAmount = 0;

  Future<void> convertToUSD() async {
    // checks if the input filed is empty or not
    if (inrController.text.isNotEmpty) {
      // converting string input to double
      double inrAmount = double.parse(inrController.text);
      // method for converting using Paisa package
      final convertedPaisa = await CurrencyConvertor.convert(
        from: Currency.USD,
        to: Currency.INR,
        amount: inrAmount,
      );
      // updating usd amount 
      usdAmount = convertedPaisa.convertedAmount;
    } else {
      usdAmount = 0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('INR to USD Converter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: inrController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter USD Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: convertToUSD,
              child: const Text('Convert to INR'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Equivalent INR Amount:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              usdAmount.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
