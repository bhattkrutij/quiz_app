import 'dart:convert';

import 'package:exam/model/review.dart';
import 'package:exam/screens/score_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/response_model.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int activePage = 0;
  int pagePosition = 0;
  ApiService? apiService;
  List<Response> items = [];
  int currentselectedAnsIndex = -1;
  int correctAnsIndex = -1;
  List<Review> reviewList = [];
  bool isRight = false, isNormal = false, isWrong = false, isCurrent = false;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: 0, keepPage: true, viewportFraction: 0.8);
    apiService = ApiService();
    getUsers();
  }

  void getUsers() async {
    items = (await apiCall())!;
    print(items.length);
    setState(() {});
  }

  Future<List<Response>?> apiCall() async {
    List<Response>? i = await apiService?.getQuizData();
    return i;
  }

  @override
  Widget build(BuildContext context) {
    reviewList.forEach((element) {
      print(
          "{${element.index}  ${element.flag.toString()}  ${element.isAnswered.toString()}");
    });
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
              backgroundColor: Colors.blue,
              appBar: AppBar(
                elevation: 0.0,
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.menu,
                      size: 30,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 20,
                        child: Text(
                            "Questions ${activePage + 1} /  ${items.length}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          isCurrent = index == activePage;
                          isRight = reviewList.any((review) =>
                              review.isAnswered &&
                              review.index == index &&
                              review.flag);
                          print(
                              "is RIGIHT${isRight} =========== is NORMAL${isNormal}");
                          isWrong = reviewList.any((review) =>
                              review.index == index &&
                              review.isAnswered &&
                              !review.flag);
                          isNormal = index != activePage && !isRight;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: EdgeInsets.all(2), // border width
                              child: Container(
                                width: 35,
                                height: 35,
                                // or ClipRRect if you need to clip the content
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Stack(
                                  children: [
                                    //correct answer
                                    if (isRight)
                                      // if (reviewList.any((review) =>
                                      //     review.index == items[pagePosition] &&
                                      //     review.flag &&
                                      //     review.isAnswered))
                                      Center(
                                          child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 1, color: Colors.white),
                                            color: Colors.blue),
                                        child: Center(
                                          child: Icon(
                                            size: 30,
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                    //normal
                                    // if (reviewList.any((review) =>
                                    //     review.index == items[pagePosition]))
                                    if (isNormal)
                                      Center(
                                          child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 1, color: Colors.white),
                                            color: Colors.blue),
                                        child: Center(
                                          child: Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )),
                                    //    current question
                                    if (isCurrent && !isRight)
                                      Center(
                                          child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 1, color: Colors.white),
                                            color: Colors.white),
                                        child: Center(
                                          child: Text(
                                            (index + 1).toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Colors.blueAccent),
                                          ),
                                        ),
                                      )),

                                    if (isWrong) // red cross icon
                                      // if (reviewList.any((review) =>
                                      //     review.index == items[pagePosition] &&
                                      //     !review.flag &&
                                      //     review.isAnswered))
                                      Center(
                                          child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 1, color: Colors.red),
                                            color: Colors.blue),
                                        child: Center(
                                          child: const Icon(
                                            Icons.clear,
                                            color: Colors.red,
                                            size: 30,
                                          ),
                                        ),
                                      )),
                                  ],
                                ), // inner content
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                          itemCount: items.length,
                          pageSnapping: true,
                          controller: _pageController,
                          onPageChanged: (page) {
                            setState(() {
                              activePage = page;
                              currentselectedAnsIndex = -1;
                            });
                          },
                          itemBuilder: (context, pagePosition) {
                            pagePosition = pagePosition;
                            return Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        items[pagePosition].question ??
                                            "no answer",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.blue),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                currentselectedAnsIndex = 0;
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          currentselectedAnsIndex ==
                                                                  0
                                                              ? Colors.blue
                                                              : Colors.white),
                                                  height: 50,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Center(
                                                    child: Text(
                                                        items[pagePosition]
                                                            .answers!
                                                            .answerA
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                currentselectedAnsIndex == 0
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .blue)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                currentselectedAnsIndex = 1;
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          currentselectedAnsIndex ==
                                                                  1
                                                              ? Colors.blue
                                                              : Colors.white),
                                                  height: 50,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Center(
                                                    child: Text(
                                                        items[pagePosition]
                                                            .answers!
                                                            .answerB
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                currentselectedAnsIndex == 1
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .blue)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                currentselectedAnsIndex = 2;
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          currentselectedAnsIndex ==
                                                                  2
                                                              ? Colors.blue
                                                              : Colors.white),
                                                  height: 50,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Center(
                                                    child: Text(
                                                        items[pagePosition]
                                                            .answers!
                                                            .answerC
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                currentselectedAnsIndex == 2
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .blue)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                currentselectedAnsIndex = 3;
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.blue,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          currentselectedAnsIndex ==
                                                                  3
                                                              ? Colors.blue
                                                              : Colors.white),
                                                  height: 50,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                          items[pagePosition]
                                                              .answers!
                                                              .answerD
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  currentselectedAnsIndex ==
                                                                          3
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .blue)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          }),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton(
                        onPressed: () {
                          if (items[activePage].correctAnswer == "answer_a") {
                            correctAnsIndex = 0;
                          } else if (items[activePage].correctAnswer ==
                              "answer_b") {
                            correctAnsIndex = 1;
                          } else if (items[activePage].correctAnswer ==
                              "answer_c") {
                            correctAnsIndex = 2;
                          } else if (items[activePage].correctAnswer ==
                              "answer_d") {
                            correctAnsIndex = 3;
                          }
                          print("que${items[activePage].question}");
                          print("correctAns Index${correctAnsIndex}");
                          print("current ans Index${currentselectedAnsIndex}");
                          print(
                              "current ans ${items[activePage].correctAnswer}");
                          if (correctAnsIndex == currentselectedAnsIndex) {
                            print("right answer");
                            if (!reviewList.any((review) =>
                                review.index == items[activePage])) {
                              setState(() {
                                print("setstaate callsed if");
                                reviewList.add(new Review(
                                  index: activePage,
                                  flag: true,
                                  isAnswered: true,
                                ));
                                reviewList.forEach((element) {
                                  print(element.index);
                                });
                              });
                            }
                            print(reviewList.any(
                                (review) => review.index == items[activePage]));
                          } else {
                            print("wrong  answer");
                            if (!reviewList.any((review) =>
                                review.index == items[activePage])) {
                              setState(() {
                                print("setstaate callsed else");
                                reviewList.add(new Review(
                                  index: activePage,
                                  flag: false,
                                  isAnswered: true,
                                ));
                              });
                            }
                          }
                          if (activePage == items.length - 1) {
                            int totalQuestions = items.length;
                            int totalCorrectAnswers = 0;
                            int totalWrongAnswers = 0;
                            for (var item in reviewList) {
                              if (item.flag == true) {
                                totalCorrectAnswers++;
                                print(totalCorrectAnswers);
                              } else {
                                totalWrongAnswers++;
                                print(totalWrongAnswers);
                              }
                            }
                            print("end of page");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScorePage(
                                  totalCorrectAnswers: totalCorrectAnswers,
                                  totalWrongAnswers: totalWrongAnswers,
                                  totalQuestions: totalQuestions,
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 15.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ))),
    );
  }
}
