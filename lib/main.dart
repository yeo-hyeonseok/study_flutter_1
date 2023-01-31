import 'package:flutter/material.dart';

void main() {
  // 앱 구동 함수, 실제 구동할 메인페이지를 인수로 넣어주면 됨
  runApp(MyApp());
}

// 프로젝트의 시작은 stless
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // stateful 위젯에서 변수 선언하면 그것이 바로 state임
  var count = 0;
  var names = ['문동은', '차무식', '강인구', '박연진', '오승훈', '전요환'];

  @override
  Widget build(BuildContext context) {
    // MaterialApp은 플러터에서 기본 제공하는 디자인 템플릿임
    return MaterialApp(
      // 레이아웃을 상중하로 나누어주는 Scafford 위젯
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            print(count);
            // 특정 state를 변경하고 싶다면 setState 함수의 콜백함수에 관련 코드를 작성해주면 됨
            setState(() {
              count += 1;
            });
          },
          child: Text('+', style: TextStyle(
            fontSize: 30
          ),),
        ),
        appBar: AppBar(
          title: Text('카운트: $count'),
        ),
        // 스크롤바를 생성해주는 세로 정렬 박스를 만들고 싶다면 listview
        // 특정 항목을 반복해서 나타내고 싶다면 ListView.builder()
        body: ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.person),
              title: Text(names[index]),
            )),
        bottomNavigationBar: BottomAppBar(child: MyFooter(),),
      )
    );
  }
}

// state를 가지고 있는 위젯을 만들고 싶다면 stful(statefulwidget)
// state가 변경되면 해당 state를 가지고 있는 위젯이 재렌더링 됨
// 자주 바뀌는 데이터 또는 바뀔 때마다 바로바로 보여져야 하는 데이터들은 state로 만들자
class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
      padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
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
// 실은 변수나 함수로도 커스텀 위젯 같이 구현이 가능하긴 함
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

