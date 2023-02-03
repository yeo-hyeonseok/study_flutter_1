/*
context가 무엇인고?
=> 부모 위젯의 정보를 담고 있는 변수라고 보면 됨 (족보)
=> showDialog(), Scaffold.of(), Navigator.pop(), Theme.of() 등은 context(MaterialApp) 사용을 강제하는 메서드들
   MaterialApp 위젯 안에서 해당 메서드들을 사용하면 오류 발생함.
   왜냐 context를 이용하는 메서드인데 MaterialApp의 부모가 존재하지 않기 때문

부모 위젯의 state를 자식 위젯에서 사용하는 법
=> 보내고 등록하고 쓰기
=> state는 부모에서 자식으로 밖에 전달 안됨, 리액트랑 똑같음
*/

import 'package:flutter/material.dart';

void main() {
  // 앱 구동 함수, 실제 구동할 메인페이지를 인수로 넣어주면 됨
  runApp(MaterialApp(
      home:MyApp()
  ));
}

// 프로젝트의 시작은 stless
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // stateful 위젯에서 변수 선언하면 그것이 바로 state임
  var names = ['문동은', '차무식', '강인구', '박연진', '오승훈', '전요환'];

  void addOne(String name) {
    setState(() {
      names.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp은 플러터에서 기본 제공하는 디자인 템플릿임
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            // 모달창을 만들고 싶다면 showDialog
            // 여기서의 context는 MaterialApp에 대한 정보 가지고 있음
            showDialog(context: context, builder: (context){
              // 자식 위젯에게 state를 보내고 싶다면 name 파라미터로 보내기
              // (자식 위젯 생성자에 보내고자 하는 state를 파라미터로 넘겨주는 것 뿐임)
              return MyDialog(addOne: addOne);
            });
          },
          child: Text('+', style: TextStyle(
            fontSize: 30
          ),),
        ),
        appBar: AppBar(
          title: Text('메신저'),
        ),
        // 스크롤바를 생성해주는 세로 정렬 박스를 만들고 싶다면 listview
        // 특정 항목을 반복해서 나타내고 싶다면 ListView.builder()
        body: ListView.builder(
            itemCount: names.length,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.person, color: Colors.black,),
              title: Text(names[index]),
            )),
        bottomNavigationBar: BottomAppBar(child: MyFooter(),),
      );
  }
}

class MyDialog extends StatefulWidget {
  // 부모로부터 전달받은 state 등록하기
  // 아래 생성자의 파라미터 부분의 중괄호는 optional을 의미
  MyDialog({Key? key, this.addOne}) : super(key: key);
  final addOne;

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  // 얘는 사용자로부터 입력받는 값을 기억할거예요~
  var textValue = TextEditingController();
  var isValue = false;

  void toggleIsValue() {
    setState(() {
      isValue = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('연락처 추가하기', style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold
            ),),
            // 사용자가 입력한 데이터를 관리하고 싶다면 controller
            TextField(
              controller: textValue,
              decoration: InputDecoration(
                hintText: '이름을 입력해주세요.'
            ),),
            if(isValue) Text('이름을 입력하지 않으셨어요!', style: TextStyle(
              color: Colors.red,
              fontSize: 14
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel')),
                TextButton(onPressed: (){
                  if(textValue.text != '') {
                    widget.addOne(textValue.text);
                    Navigator.pop(context);
                  } else {
                    toggleIsValue();
                  }
                }, child: Text('OK')),
              ],
            )
          ],
        ),
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

