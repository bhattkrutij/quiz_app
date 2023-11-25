import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScorePage extends StatefulWidget {
  int? totalQuestions;
  int? totalCorrectAnswers;
  int? totalWrongAnswers;

  ScorePage(
      {required this.totalQuestions,
      required this.totalCorrectAnswers,
      required this.totalWrongAnswers});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  double totalPer = 0.0;
  String result = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalPer =
        (widget.totalCorrectAnswers! / widget.totalQuestions!) * 100 ?? 0;
    if (totalPer >= 70) {
      result = "pass";
    } else {
      result = "Fail";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        color: Colors.amber,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: [
                  Expanded(child: Center(child: Text("Total questions"))),
                  Expanded(
                      child:
                          Center(child: Text(widget.totalQuestions.toString())))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: [
                  Expanded(child: Center(child: Text("Correct answers"))),
                  Expanded(
                      child: Center(
                          child: Text(widget.totalCorrectAnswers.toString())))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white),
                color: Colors.white,
              ),
              child: Row(children: [
                Expanded(child: Center(child: Text("Wrong answers"))),
                Expanded(
                    child: Center(
                        child: Text(widget.totalWrongAnswers.toString()))),
              ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(child: Center(child: Text("Score"))),
                  Expanded(child: Center(child: Text(totalPer.toString())))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Expanded(child: Center(child: Text("Result"))),
                  Expanded(child: Center(child: Text(result)))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
