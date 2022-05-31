import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:poc_app/model/CircularDetailsModel.dart';
import 'package:poc_app/screen/otp_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userId = TextEditingController();
  TextEditingController password = TextEditingController();

  List<CircularDetailModel> dummyData = CircularDetailModel.dummyData();

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 22),
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
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      style: const TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                      controller: userId,
                      maxLength: 5,
                      onChanged: (val) async {
                        // await filterDataWithCircularNum(val);
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 5) {
                          return 'User id should be of 5 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: 'User ID', counterText: ''),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: password,
                      style: const TextStyle(fontSize: 22),
                      textAlign: TextAlign.center,
                      // keyboardType: TextInputType.number,
                      maxLength: 6,
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return 'Password should be of 6 characters only';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        counterText: '',
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //       content: Text('Processing Data')),
                              // );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          OtpScreen(title: widget.title))));
                              //filterDataWithCircularNum(userId.text);

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           OtpScreen(title: widget.title)),
                              // );
                            }
                          },
                          child: const Text(
                            'SIGN IN',
                            style: TextStyle(fontSize: 18),
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

  Future filterDataWithCircularNum(String cNumber) async {
    print(cNumber);

    List<CircularDetailModel> result = [];
    dummyData.forEach(
      (e) {
        if (e.circularNo.contains(cNumber)) {
          result.add(e);
        }
      },
    );
    if (result.isNotEmpty) print("data is $cNumber ${result[0].circularNo}");

    result.forEach((e) {
      print(e.circularNo + " " + e.subject + " " + e.type);
    });

    // Iterable<CircularDetailModel> data =
    //     dummyData.where((element) => element.circularNo == cNumber);
    // if (data.isNotEmpty) {
    //   List<CircularDetailModel> filterFinalData = data.toList();

    //   // filterData.map((e) => print(e.circularNo + " " + e.subject + " " + e.type));
    //   if (filterFinalData != null) {}
    // }
  }
}
