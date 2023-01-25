import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  // 앱 구동 함수, 실제 구동할 메인페이지를 인수로 넣어주면 됨
  runApp(const MyApp());
}

// 프로젝트의 시작은 stless
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MaterialApp은 플러터에서 기본 제공하는 디자인 템플릿임
    return MaterialApp(
      // 레이아웃을 상중하로 나누어주는 Scafford 위젯
      home: Scaffold(
        appBar: AppBar(
          title: Text('앱임')),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100, height: 100, color: Colors.orange, margin: EdgeInsets.all(20), padding: EdgeInsets.all(20),
                child: Text('박스 1'),
              ),
              Container(
                width: 120, height: 120, color: Colors.orange, margin: EdgeInsets.fromLTRB(20, 20, 20, 20), padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Text('박스 2'),
              ),
              Container(
                width: 140, height: 140, margin: EdgeInsets.all(20), padding: EdgeInsets.all(5),
                child: Text('기타 자잘한 스타일 설정은 decoration에다가'),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  border: Border.all(color: Colors.indigo, width: 10),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text("Align 위젯으로도 정렬할 수 있음"),
              )
            ],
          ),
        ),

      ),
    );
  }
}


