import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  increment() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      if(_counter == 100){
       _counter = 0;
      }else{
        _counter++;
      }
      sp.setInt("counter",_counter);
    });
  }
  decrement() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      if(_counter == 0){
       _counter = 0;
      }else{
        _counter--;
      }
      sp.setInt("counter",_counter);
    });
  }

  action() async {
    setState(() {});
    SharedPreferences sp = await SharedPreferences.getInstance();
   _counter = sp.getInt("counter") ?? 0;
  }


@override
  void initState() {
    action();
    Future.delayed(Duration(seconds: 1)).then((value){
      setState(() {
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        centerTitle: true,
        title: const Text("Counter App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: CircularPercentIndicator(
                    backgroundColor: Colors.deepPurple.shade100,
                    progressColor: Colors.deepPurple,
                    circularStrokeCap: CircularStrokeCap.round,
                    radius: 100,
                    lineWidth: 16,
                    percent: (_counter/100),
                    center: Text("$_counter",style: TextStyle(fontSize: 40,color: Colors.deepPurple,fontWeight: FontWeight.w700),),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8,),
            Expanded(
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          decrement();
                        },
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Colors.deepPurple.shade200,Colors.deepPurple]),
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))
                          ),
                          child: Icon(FontAwesomeIcons.minus,size: 50,color: Colors.white,),
                        ),
                      ),
                    ),
                    SizedBox(width: 2,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          increment();
                        },
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [Colors.deepPurple,Colors.deepPurple.shade200]),
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Icon(FontAwesomeIcons.plus,size: 50,color: Colors.white,),
                          ),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
