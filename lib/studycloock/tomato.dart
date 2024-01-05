<<<<<<< HEAD
  import 'dart:async';
  import 'package:audioplayers/audioplayers.dart';
  import 'package:flutter/material.dart';
  import '../schedule/schedule.dart';
  import 'package:dropdown_button2/custom_dropdown_button2.dart';
  final player=AudioPlayer()..setReleaseMode(ReleaseMode.loop);
=======
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../schedule/schedule.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
final player=AudioPlayer()..setReleaseMode(ReleaseMode.loop);
>>>>>>> 9575b38f8892d73e99a1b9871bc8560db6acdd01

  void main() {
    runApp(MyApp());
  }
<<<<<<< HEAD

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: PomodoroTimer(),
      );
    }
  }
  class PomodoroTimer extends StatefulWidget {
    @override
    _PomodoroTimerState createState() => _PomodoroTimerState();
  }

  class _PomodoroTimerState extends State<PomodoroTimer> {
    void SetTime(worktime){
      this.workTime=worktime;
      startTimer();
      resetTimer();
    }
    int GetTime(){
      return this.workTime;
    }
=======
}
class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  void SetTime(worktime){
    this.workTime=worktime;
    setState(() {

    });
    resetTimer();
  }
  int GetTime(){
    return this.workTime;
  }

  int workTime=25;
  int breakTime = 5;
  int currentTime=25*60; // Initial time in seconds
  bool isWorking = true;
  bool isRunning = true;
  bool istesting = true;
  late Timer timer;
>>>>>>> 9575b38f8892d73e99a1b9871bc8560db6acdd01

    int workTime=25;
    int breakTime = 5;
    int currentTime=25*60; // Initial time in seconds初始時間
    bool ischange=true;
    bool isWorking = true;
    bool isRunning = true;
    bool istesting = false;
    late Timer timer;

<<<<<<< HEAD
    int counter = 0;

    void startTimer(){

      isRunning&&istesting? player.play(AssetSource("1.mp3")):player.stop();
      if(isRunning){
        setState(() {
          isRunning = false;
=======
  void startTimer(){

    if(isRunning){
      setState(() {
        isRunning = false;
      });
    if (istesting) {

      istesting=false;

      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          player.play(AssetSource("1.mp3"));
          if (currentTime > 0) {
            currentTime--;
          } else {
            if (isWorking) {
              player.stop();
              player.play(AssetSource("timeout.mp3"));
              currentTime = breakTime * 60;
            } else {
              currentTime = GetTime() * 60;
            }
            isWorking = !isWorking;
          }
>>>>>>> 9575b38f8892d73e99a1b9871bc8560db6acdd01
        });

        timer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
            if (currentTime > 0) {
              currentTime--;
            } else {
              player.stop();
              this.showAlertDialog(context);
              timer.cancel();
              if (isWorking) {

                  currentTime = breakTime * 60;
              } else {

                  currentTime = GetTime() * 60;
              }
              isWorking = !isWorking;
            }
          });
        });

    }else{
        setState(() {
          isRunning = true;
        });
        player.stop();
        timer.cancel();
      }
    }


    void resetTimer() {
      timer.cancel();
      player.stop();
      setState(() {
        currentTime = workTime * 60;
        isWorking = true;
        isRunning = false;
        startTimer();
      });
    }
<<<<<<< HEAD

    String formatTime(int time) {
      int minutes = time ~/ 60;
      int seconds = time % 60;
      return '$minutes:${seconds < 10 ? '0' : ''}$seconds';
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Schedule()));},
=======
  }else{
      setState(() {
        isRunning = true;
      });
      player.stop();
      istesting=true;
      timer.cancel();
    }
  }


  void resetTimer() {
    istesting=true;
    timer.cancel();
    player.stop();
    setState(() {
      currentTime = workTime * 60;
      isWorking = true;
      isRunning = false;
      startTimer();
    });
  }

  String formatTime(int time) {
    int minutes = time ~/ 60;
    int seconds = time % 60;
    return '$minutes:${seconds < 10 ? '0' : ''}$seconds';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Schedule()));},
        ),
        title: const Text('Pomodoro Timer'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.png"),
            fit: BoxFit.cover,
>>>>>>> 9575b38f8892d73e99a1b9871bc8560db6acdd01
          ),
          title: const Text('Pomodoro Timer'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

<<<<<<< HEAD
              Text(
                  isWorking ? 'Work Time' : 'Break Time',
                style: TextStyle(fontSize: 35,color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                formatTime(currentTime),
                style: TextStyle(fontSize: 95,color:Colors.white),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    ElevatedButton(
                      onPressed: () {
                        istesting=true;
                        startTimer();
                      },
                        child:Icon(
                          isRunning ? Icons.play_circle_outline_outlined : Icons.stop_circle_rounded ,
                          size: 55,)

                    ),
                    SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      resetTimer();
                    },
                    child: Icon(
                        Icons.refresh,
                      size: 55,
                    ),
                  ),

                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    DropdownButton(icon: Icon(Icons.playlist_play_sharp), iconSize: 40, iconEnabledColor: Colors.white,
                      hint: Text('學習時長',style:TextStyle(fontSize:25,color: Colors.white)),

                      items: [
                        DropdownMenuItem(child: Text('15'), value: 15), DropdownMenuItem(child: Text('20'), value: 20),
                        DropdownMenuItem(child: Text('25'), value: 25)
                      ], onChanged: (value) {
                      setState(() {
                        istesting=false;
                      });
                        return SetTime(value);
                      },
                    ),
                    DropdownButton(icon: Icon(Icons.playlist_play_sharp), iconSize: 40, iconEnabledColor: Colors.white,
                      hint: Text('番茄鐘數量',style:TextStyle(fontSize:25,color: Colors.white)),

                      items: [
                        DropdownMenuItem(child: Text('2'), value: 2), DropdownMenuItem(child: Text('3'), value: 3),
                        DropdownMenuItem(child: Text('4'), value: 4)
                      ], onChanged: (value) {
                        setState(() {
                          istesting=false;
                        });
                        return SetTime(value);
                      },
                    ),
                  ],
                ),

            ],
          ),

        ),

      );
    }
    void showAlertDialog(BuildContext context) {
      // Int
      //isRunning=false;

      player.stop();
      player.play(AssetSource("timeout.mp3"));
      AlertDialog dialog = AlertDialog(
        title: Text(
          isWorking ? '可以休息了喔' : '要繼續學習了喔',
          style: TextStyle(fontSize: 35,color: Colors.black),

        ),

        actions: [

          ElevatedButton(
              child: Text("OK"),
              onPressed: () {
                setState(() {
                  player.stop();
                  isRunning=true;
                });
                Navigator.pop(context);
              }
          ),
        ],
      );

      // Show the dialog
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return dialog;
          }
      );
    }
  }
=======
            Text(
              isWorking ? 'Work Time' : 'Break Time',
              style: TextStyle(fontSize: 35,color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              formatTime(currentTime),
              style: TextStyle(fontSize: 95,color:Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  ElevatedButton(
                    onPressed: () {
                      startTimer();
                    },
                      child:Icon(
                        isRunning ? Icons.play_circle_outline_outlined : Icons.stop_circle_rounded ,
                        size: 55,)

                  ),
                  SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    resetTimer();
                  },
                  child: Icon(
                      Icons.refresh,
                    size: 55,
                  ),
                ),

              ],
            ),
            Column(
                children:[

                  DropdownButton(icon: Icon(Icons.playlist_play_sharp), iconSize: 40, iconEnabledColor: Colors.white,
                    hint: Text('學習時長',style:TextStyle(fontSize:25,color: Colors.white)),

                    items: [
                      DropdownMenuItem(child: Text('15'), value: 15), DropdownMenuItem(child: Text('20'), value: 20),
                      DropdownMenuItem(child: Text('25'), value: 25)
                    ], onChanged: (value) {
                    setState(() {
                      startTimer();
                    });
                      return SetTime(value);
                    },
                  ),
                ],
              ),
          ],
        ),

      ),

    );
  }
}
>>>>>>> 9575b38f8892d73e99a1b9871bc8560db6acdd01
