import 'package:flutter/material.dart';
import 'package:poc_app/model/CircularDetailsModel.dart';
import 'package:poc_app/screen/circular_docList_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _circularNo = TextEditingController();
  TextEditingController _circularKeyWord = TextEditingController();

  List<CircularDetailModel> dummyData = CircularDetailModel.dummyData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.red,
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 200,
                  child: Column(
                    children: const [
                      Text(
                        'WELCOME TO',
                        style: TextStyle(color: Colors.white),
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      Text(
                        'e-Circular Mobile App',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width > 600
                    ? 500
                    : MediaQuery.of(context).size.width,
              ),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  // color: Colors.green,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => CircularDocListPage(
                                      isLatest: true,
                                      title: widget.title,
                                      circularNumber: '',
                                      isCircularNum: false,
                                    )),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: const Text('Latest Circular',
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'Search Circular based on number or any key word.',
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _circularNo,
                                style: const TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Circular no.',
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.blue),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.blue),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 3, color: Colors.red),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 3, color: Colors.red),
                                  ),
                                  //  counterText: ''
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty &&
                                          _circularKeyWord.text.isEmpty) {
                                    return "Please enter Circular number.";
                                  } else if (_circularNo.text.isNotEmpty &&
                                      _circularKeyWord.text.isNotEmpty) {
                                    return "fill any ONE field only";
                                  }
                                  return null;
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'OR',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              TextFormField(
                                controller: _circularKeyWord,
                                style: const TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Circular Text or Key word',
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.blue),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.blue),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 3, color: Colors.red),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 3, color: Colors.red),
                                  ),
                                  //  counterText: ''
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty &&
                                          _circularNo.text.isEmpty) {
                                    return "Please enter Keyword number.";
                                  } else if (_circularKeyWord.text.isNotEmpty &&
                                      _circularNo.text.isNotEmpty) {
                                    return "fill any ONE field only";
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: SizedBox(
                                  height: 60,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(
                                          //   const SnackBar(
                                          //       content: Text('Searching...')),
                                          // );
                                          if (_circularNo.text.isNotEmpty) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: ((context) =>
                                                    CircularDocListPage(
                                                      isLatest: false,
                                                      title: widget.title,
                                                      circularNumber:
                                                          _circularNo.text,
                                                      isCircularNum: true,
                                                    )),
                                              ),
                                            );
                                          } else {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: ((context) =>
                                                    CircularDocListPage(
                                                      isLatest: false,
                                                      title: widget.title,
                                                      circularNumber:
                                                          _circularKeyWord.text,
                                                      isCircularNum: false,
                                                    )),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child:
                                          const Text('Click Search Circular')),
                                ),
                              ),
                            ],
                          ))
                    ],
                  )),
            )
          ],
        ),
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
    // dummyData.forEach(
    //   (e) {
    //     if (e.circularNo.contains(cNumber)) {
    //       result.add(e);
    //     }
    //   },
    // );
    result = dummyData
        .where((element) => element.circularNo.contains(cNumber))
        .toList();
    if (result.isNotEmpty) {
      // print("data is $cNumber ${result[0].circularNo}");
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: ((context) => CircularDocListPage(
      //               title: widget.title,
      //               circularNumber: result,
      //             ))));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('NO DATA FOUND...')),
      );
    }

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
