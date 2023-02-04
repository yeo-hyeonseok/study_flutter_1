import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

void main() {
  runApp(MaterialApp(
      home:MyApp()
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void getPermission() async {
    // 유저의 연락처 접근 권한 상태를 가져오기
    var status = await Permission.contacts.status;

    if(status.isGranted) {
      print('허용됨');
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

  List<Contact> names = [];
  bool isEdit = false;

  void addOne(String name) {
    setState(() {
      var newPerson = Contact();
      newPerson.givenName = name;
      ContactsService.addContact(newPerson);
      names.add(newPerson);
      print(newPerson.givenName);
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
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            initIsEdit();
            showDialog(context: context, builder: (context){
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
                    title: Text(names[index].givenName ?? '알 수 없는 사용자'),
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

class MyDialog extends StatefulWidget {
  MyDialog({Key? key, this.addOne}) : super(key: key);
  final addOne;

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
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

