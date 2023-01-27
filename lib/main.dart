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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            leadingWidth: 160,

            leading: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: TextButton(
                  child:Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    height: double.infinity,
                    child: Row(
                        children: [
                          Text('금호동3가', style:TextStyle(
                              color: Colors.black,
                              fontSize: 22, fontWeight: FontWeight.bold
                          ),),
                          Icon(Icons.keyboard_arrow_down, size: 25, color: Colors.black),
                        ]
                    ),
                  ), onPressed: (){}),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: IconButton(onPressed: (){},
                        icon: Icon(Icons.search, color: Colors.black, size: 32,)
                        ,)
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: IconButton(onPressed: (){},
                        icon: Icon(Icons.reorder, color: Colors.black, size: 32,)
                        ,)
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: IconButton(onPressed: (){},
                        icon: Icon(Icons.notifications_none, color: Colors.black, size: 32,)
                        ,)
                  ),
                ],
              ),
            ],
            backgroundColor: Colors.white,
          ),
        ),
        body: Column(
          children: [
            Container(
              child: Row(

              ),
            )
          ],
        ),
      )
    );
  }
}


