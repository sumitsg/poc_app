import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:poc_app/screen/home_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userId = TextEditingController();
  TextEditingController password = TextEditingController();

  RegExp _numeric = RegExp(r'^-?[0-9]+$');

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width > 600
                  ? 500
                  : MediaQuery.of(context).size.width,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 100,
                      width: 280,
                      child: const Text(
                        'OTP has been sent to you\r  registered mobile number. Please  check and validate OTP  ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Color.fromARGB(255, 25, 52, 207),
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: const TextStyle(fontSize: 22),
                      textAlign: TextAlign.start,
                      controller: userId,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'OTP should be of 6 digit';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: 'Enter OTP',
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blue),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.red),
                          ),
                          counterText: ''),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              primary: Colors.blue),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //       content: Text('Processing Data')),
                              // );
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(title: widget.title)));
                            }
                          },
                          child: const Text(
                            'Validate OTP',
                            style: TextStyle(fontSize: 20),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        // constraints: const BoxConstraints(minWidth: 100, maxWidth: 250),
        width: MediaQuery.of(context).size.width,
        height: 40,
        color: Colors.red,
        child: const Text(
          'Copyright @ Union Bank of India, 2020',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
