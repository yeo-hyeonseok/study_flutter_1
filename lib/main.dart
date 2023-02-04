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
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

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
  // dart 언어 특징 상 오래걸리는 작업은 제껴두고 다음 줄을 실행하려고 함
  // await 붙이면 해당 작업 끝날 때까지 다음 줄 실행 안하고 기다려줌
  // await은 Future를 반환하는 함수에다 사용할 수 있음, 자바스크립트로 따자면 Promise랑 비슷한 개념인듯
  void getPermission() async {
    // 유저의 연락처 접근 권한 상태를 가져오기
    var status = await Permission.contacts.status;

    if(status.isGranted) {
      print('허용됨');
      // 휴대폰에서 연락처 가져오는 방법
      var contacts = await ContactsService.getContacts();

      setState(() {
        names = contacts;
      });
    } else if(status.isDenied) {
      print('거부됨');
      // 연락처 접근 권한 요청 창 띄우기
      //Permission.contacts.request();
      openAppSettings();
    }
  }

  /*
  // initState 안에 작성하는 코드는 위젯이 로드될 때 한번 실행됨
  // useEffect에서 dependency로 []로 주는 것과 같음
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 요새는 정책상 두번 이상 거절하면 해당 팝업창이 절대 안뜸
    // getPermission();

    // 그니까 팝업창 바로 띄우지 말고 앱 설정 화면 띄워서 사용자가 알아서 세팅할 수 있게끔 하셈
    openAppSettings();
  }*/

  // stateful 위젯에서 변수 선언하면 그것이 바로 state임
  List<Contact> names = [];
  var isEdit = false;

  void addOne(String name) {
    setState(() {
      //names.add(name);
    });
  }
  
  void deleteOne(int index) {
    setState(() {
      names.removeAt(index);
    });
  }
  
  void toggleIsEdit(){
    setState(() {
      isEdit = !isEdit;
    });
  }

  void initIsEdit() {
    setState(() {
      isEdit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MaterialApp은 플러터에서 기본 제공하는 디자인 템플릿임
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            initIsEdit();
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
          actions: [
            IconButton(onPressed: (){
              initIsEdit();
              getPermission();
            }, icon: Icon(
              Icons.get_app,
            ),)
          ],
        ),
        // 스크롤바를 생성해주는 세로 정렬 박스를 만들고 싶다면 listview
        // 특정 항목을 반복해서 나타내고 싶다면 ListView.builder()
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade400, width: 1.0
                  )
                )
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('친구 수 (${names.length})', style: TextStyle(
                      fontWeight: FontWeight.w500
                    ),),
                    TextButton(onPressed: (){
                      toggleIsEdit();
                    }, child: Text('편집'))
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Icon(Icons.person, color: Colors.black,),
                    title: Text(names[index].displayName ?? '알 수 없는 사용자'),
                    trailing: isEdit ? TextButton(onPressed: (){
                      deleteOne(index);
                    }, child: Text('삭제', style: TextStyle(
                      color: Colors.white
                    ),), style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),) : null
                  )),
            ),
          ],
        ),
      ),
        bottomNavigationBar: BottomAppBar(child: MyFooter(),),
      );
  }
}

// 커스텀 위젯을 사용하는 방법
// 너무 많은 커스텀 위젯은 독이 될 수가 있다.
// => 상태 관리의 어려움
// => 재사용이 많이 되는 ui들을 커스텀 위젯으로 만들자 (컴포넌트화)
// => 하나의 페이지도 good
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
              fontSize: 20,
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

class MyFooter extends StatelessWidget {
  const MyFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
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

