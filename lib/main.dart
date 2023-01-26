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
          leading: Icon(Icons.view_list),
          actions: [Icon(Icons.ac_unit), Icon(Icons.access_alarm), Icon(Icons.admin_panel_settings)],
          title: Text('앱임', style: TextStyle(
            fontWeight: FontWeight.w500, letterSpacing: 5
          ),),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('안녕하세요?',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                ),
              ),
              Icon(Icons.star, color: Colors.yellow, size: 40,),
              ElevatedButton(
                onPressed: (){},
                child: Text('입력'), 
                style: ButtonStyle(
                ),
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.star))
            ],
          ),
        )
      ),
    );
  }
}


