import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMethod;
  final _formKey = GlobalKey<FormState>();
  TextEditingController upiController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedPaymentMethod = value;
    });
  }

  void _handleAddPayment() {
    if (_selectedPaymentMethod != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          if (_selectedPaymentMethod == 'UPI') {
            return AlertDialog(
              title: const Text('Enter UPI Details'),
              content: Form(
                key: _formKey,
                child: TextFormField(
                  controller: upiController,
                  decoration: InputDecoration(labelText: 'Enter UPI ID'),
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? 'This field is required'
                        : null;
                  },
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          } else if (_selectedPaymentMethod == 'Card') {
            return AlertDialog(
              title: const Text('Enter Card Details'),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: cardNumberController,
                      decoration: InputDecoration(labelText: 'Card Number'),
                      validator: (value) {
                        return value == null || value.isEmpty
                            ? 'This field is required'
                            : null;
                      },
                    ),
                    TextFormField(
                      controller: expiryDateController,
                      decoration: InputDecoration(labelText: 'Expiry Date'),
                      validator: (value) {
                        return value == null || value.isEmpty
                            ? 'This field is required'
                            : null;
                      },
                    ),
                    TextFormField(
                      controller: cvvController,
                      decoration: InputDecoration(labelText: 'CVV'),
                      validator: (value) {
                        return value == null || value.isEmpty
                            ? 'This field is required'
                            : null;
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          } else {
            return AlertDialog(
              title: Text('Payment Method: $_selectedPaymentMethod'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          }
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Select Payment Method:'),
            RadioListTile<String>(
              title: const Text('UPI'),
              value: 'UPI',
              groupValue: _selectedPaymentMethod,
              onChanged: _handleRadioValueChange,
            ),
            RadioListTile<String>(
              title: const Text('Cash on Delivery'),
              value: 'Cash on Delivery',
              groupValue: _selectedPaymentMethod,
              onChanged: _handleRadioValueChange,
            ),
            RadioListTile<String>(
              title: const Text('Card'),
              value: 'Card',
              groupValue: _selectedPaymentMethod,
              onChanged: _handleRadioValueChange,
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                onPressed: _handleAddPayment,
                text: 'Add',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
