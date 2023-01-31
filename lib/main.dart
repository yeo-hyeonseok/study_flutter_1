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
        appBar: AppBar(),
        // 스크롤바를 생성해주는 세로 정렬 박스를 만들고 싶다면 listview
        // => 스크롤 위치 감지 기능
        // => 메모리 절약 기능, 사용자에게 실제로 보이지 않는 ui는 메모리에서 삭제해줄 수 있음
        body: ListView(
          children: [
            Profile(),
            Profile(),
            Profile(),
            Container(
              color: Colors.red,
              height: 200,
            ),
            Container(
              color: Colors.orange,
              height: 200,
            ),
            Container(
              color: Colors.yellow,
              height: 200,
            ),
            Container(
              color: Colors.green,
              height: 200,
            ),
            Container(
              color: Colors.blue,
              height: 200,
            ),
            Container(
              color: Colors.indigo,
              height: 200,
            ),
            Container(
              color: Colors.purple,
              height: 200,
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(child: MyFooter(),),
      )
    );
  }
}

// 커스텀 위젯을 사용하는 방법
// 너무 많은 커스텀 위젯은 독이 될 수가 있다. 
// => 상태 관리의 어려움
// => 재사용이 많이 되는 ui들을 커스텀 위젯으로 만들자 (컴포넌트화)
// => 하나의 페이지도 good
class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        children: [
          Container(margin: EdgeInsets.fromLTRB(0, 0, 10, 0), child: Icon(Icons.person)),
          Text('문동은')
        ],
      ),
    );
  }
}

class MyFooter extends StatelessWidget {
  const MyFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.phone)),
          IconButton(onPressed: (){}, icon: Icon(Icons.message)),
          IconButton(onPressed: (){}, icon: Icon(Icons.assignment_ind)),
        ],
      ),
    );
  }
}



// -------------------------------------------------------------------------------
// 실은 변수나 함수로도 커스텀 위젯을 구현 가능하긴 함
// 불변하는 ui들은 변수나 함수로 축약해도 상관 없음 ex) 로고, 상단 바 등 
// 유동적인 데이터를 가진 ui를 변수나 함수에 저장해둘 경우에는 성능 이슈가 발생할 수 있음
var shopItem = SizedBox(
  child: Text('커스텀 위젯을 사용해보자 ㅋ'),
);

Widget getShopItem() {
  return SizedBox(
    child: Text('커스텀 위젯을 사용해보자 ㅋ'),
  );
}

