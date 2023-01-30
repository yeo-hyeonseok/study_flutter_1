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
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 150,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.asset('item.jpg', width: 150,),
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('애플 맥북 m1 에어 256기가 급처합니다. 네고 사절'),
                            Text('금호동 행당동'),
                            Text('155,000원'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.favorite),
                                Text('4')
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height:1.0,
                width:500.0,
                color:Colors.grey,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              ),
              Container(
                height: 100,
                child: Row(
                  children: [
                    //특정 박스의 너비를 꽉 채우고 싶다면 Expanded, flex:1을 가진 flexible과 동일함
                    Expanded(child: Container(
                      color: Colors.red,
                    )),
                    Container(
                      color: Colors.blue,
                      width: 100,
                    )
                  ],
                ),
              ),
              Container(
                height:1.0,
                width:500.0,
                color:Colors.grey,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              ),
              Container(
                height: 100,
                child: Row(
                  children: [
                    // 특정 박스의 너비를 비율로 나타내고 싶다면 Flexible
                    Flexible(
                      flex: 3,
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Container(
                        color: Colors.blue,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.yellow,
                      ),
                    )
                  ],
                ),
              ),
            ]
          ),
        )
      )
    );
  }
}


