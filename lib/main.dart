import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'bmi_score.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  bool isSelected = false;
  Color? bmiStatusColor;
  String bmiStatus = "";
  String bmiInterpretation = "";
  double height=0;
  double weight=0;

  double bmiScore = 0;
  final _formKey = GlobalKey<FormState>();

  void calculateBMI() {
    setState(() {
      height = double.parse(heightController.text) / 100;
      weight = double.parse(weightController.text);

      double heightSquare = height * height;
      double result = weight / heightSquare;
      bmiScore = result;

      if (bmiScore > 30) {
        
        bmiInterpretation = "Please work to reduce obesity";
        bmiStatus = "Obesity";
        bmiStatusColor = Colors.pink;
      } else if (bmiScore >= 25) {
        bmiStatus = "Overweight";
        bmiInterpretation = "Do regular exercise & reduce the weight";
        bmiStatusColor = Colors.orange;
      } else if (bmiScore >= 18.5) {
        bmiStatus = "You're healty!";
        bmiInterpretation =
            "This value is in the normal range of 20-25 for your age group. Keep up the good work!";
        bmiStatusColor = Colors.green;
      } else if (bmiScore < 18.5) {
        bmiStatus = "Underweight";
        bmiInterpretation = "Try to increase the weight";
        bmiStatusColor = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100, right: 60, left: 25),
                width: 400,
                height: 100,
                child: Text(
                  "Let`s calculate your current BMI",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Color.fromARGB(255, 83, 83, 83)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, right: 60, left: 25),
                width: 400,
                height: 50,
                child: Text(
                  "You can find out whether you are overweight, underweight or ideal weight.",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color.fromARGB(255, 116, 115, 115)),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 25, top: 35),
                      alignment: Alignment.center,
                      width: 92,
                      height: 45,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 197, 194, 194)),
                        borderRadius: BorderRadius.circular(30),
                        color: isSelected
                            ? Colors.white
                            : Color.fromARGB(255, 90, 90, 90),
                      ),
                      child: Text(
                        "Female",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 35),
                      alignment: Alignment.center,
                      width: 95,
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 197, 194, 194)),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Male",
                        style: TextStyle(
                            color: Color.fromARGB(255, 117, 116, 116),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 35),
                      alignment: Alignment.center,
                      width: 95,
                      height: 45,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 197, 194, 194)),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        "Other",
                        style: TextStyle(
                            color: Color.fromARGB(255, 117, 116, 116),
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 35),
                padding: EdgeInsets.all(0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if(ageController.text.isEmpty||ageController.text==null){
                        return "please enter age number";
                      }
                    },
                    controller: ageController,
                  
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    cursorColor: Color.fromARGB(255, 117, 116, 116),
                    decoration: InputDecoration(
                      label: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            WidgetSpan(
                              child: Text('Age',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 156, 155, 155),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            WidgetSpan(
                              child: Text(
                                '',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    style: TextStyle(color: Color.fromARGB(255, 136, 136, 136)),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.all(0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: TextFormField(
                    validator: (value) {
                     
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: heightController,
                    cursorColor: Color.fromARGB(255, 117, 116, 116),
                    decoration: InputDecoration(
                      label: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            WidgetSpan(
                              child: Text('Height',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 156, 155, 155),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            WidgetSpan(
                              child: Text(
                                '',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    style: TextStyle(color: Color.fromARGB(255, 136, 136, 136)),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 20),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(3),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: weightController,
                    cursorWidth: 1,
                    cursorColor: Color.fromARGB(255, 73, 165, 241),
                    decoration: InputDecoration(
                      label: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            WidgetSpan(
                              child: Text('Weight',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 156, 155, 155),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                            WidgetSpan(
                              child: Text(
                                '',
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Color.fromARGB(255, 136, 136, 136)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                 try {
                    if ((double.parse(heightController.text) < 50 ||
                      double.parse(heightController.text) > 250) && heightController.toString().isEmpty ){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Alert',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        content: const Text(
                          'The height value should be in the range of 50 - 250 cm!',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel',
                                style: TextStyle(
                                    color: Color(0xff468FF8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else if( (double.parse(weightController.text) < 10 ||
                      // ignore: unnecessary_null_comparison
                      double.parse(weightController.text) > 300) ||  weightController==null) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Alert',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        content: const Text(
                          'The weight value should be in the range of 10 - 300 kg!',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel',
                                style: TextStyle(
                                    color: Color(0xff468FF8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK',
                                style: TextStyle(
                                    color: Color(0xff468FF8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => bmiCalculator(
                        value: bmiScore,
                        text: bmiInterpretation,
                        status: bmiStatus,
                        statusColor: bmiStatusColor,
                      ),
                    ));
                  }
                  setState(() {
                    calculateBMI();
                  });
                 } catch (e) {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Alert',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        content: const Text(
                          'Please enter a value!',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel',
                                style: TextStyle(
                                    color: Color(0xff468FF8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK',
                                style: TextStyle(
                                    color: Color(0xff468FF8),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    );
                 }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 160),
                  width: 350,
                  height: 50,
                  child: Text(
                    "Calculate BMI",
                    style: TextStyle(
                        color: Color.fromARGB(255, 250, 245, 245),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff468FF8),
                      ),
                      color: Color(0xff468FF8),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
