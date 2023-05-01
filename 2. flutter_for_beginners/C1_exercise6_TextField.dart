import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        home: MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var total = 3;
  var a = 1;  // StatefulWidget 안의 변수는 자동으로 state가 됨
  var name = ['홍길동', '치킨집', '피자집'];

  addName(text){
    name.add(text);
  }

  addOne(){  // 함수 만들기
    setState(() {
      total++;
    });
  }


  @override
  Widget build(BuildContext context) {  // 부모위젯의 정보를 담고있는 변수

    return Scaffold(
        appBar: AppBar(title: Text(total.toString()),),
        body: ListView.builder(
          itemCount: name.length,
          itemBuilder: (context, i) { // i는 정수 (0, 1, 2)
            // print(i);  // 디버깅할 때 유용
            return ListTile(
              leading: Icon(Icons.account_circle, size: 50.0),
              title: Text(name[i]),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          child: BottomIcon(),
        ),
        floatingActionButton: Dialogexample( addOne : addOne, addName: addName,),  // 작명: 변수명
    );
  }
}


class BottomIcon extends StatelessWidget {
  const BottomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white)
      ),
      height: 40,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Icon(Icons.call),
          Icon(Icons.message),
          Icon(Icons.contact_page),
        ],
      ),
    );
  }
}

class Dialogexample extends StatelessWidget {
  Dialogexample({Key? key, this.addOne, this.addName}) : super(key: key);
  final addOne;
  final addName;
  var inputData = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        showDialog(context: context, builder: (context) {
          return Dialog(
              // backgroundColor: Colors.cyan,
              insetPadding: EdgeInsets.all(5),
              child:
                  Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2)
                      ),
                      padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Contact', style: TextStyle(fontSize: 24),),
                          TextField(
                            controller: inputData,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.all(30),
                                child:
                                TextButton(
                                  onPressed: () {
                                    if (inputData.text.isNotEmpty) {
                                      addOne();
                                      print(inputData.text);
                                      addName(inputData.text);
                                      Navigator.pop(context);
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('Ok', style: TextStyle(fontSize: 20),),
                                ),
                              ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Close', style: TextStyle(fontSize: 20),),
                                ),
                              ],
                          ),
                        ],
                      ),
                  ),
          );
        });
      },  // FAB
    );
  }
}
