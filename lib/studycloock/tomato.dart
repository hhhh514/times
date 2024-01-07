import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../schedule/schedule.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
final player=AudioPlayer()..setReleaseMode(ReleaseMode.loop);

void main() {
  runApp(MyApp());
}

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
    resetTimer();
  }
  int GetTime(){
    return this.workTime;
  }
  void SetCounter(Counter_set){
    this.counter_set=Counter_set;
  }
  int GetCounter(){
    return this.counter_set;
  }
  int workTime=25;
  int breakTime = 5;
  int currentTime=25*60; // Initial time in seconds
  bool isWorking = true;
  bool isRunning = true;
  bool istesting = true;
  late Timer timer;
  int counter_set=4;
  int counter = 0;

  void startTimer(){
    isRunning&&istesting? player.play(AssetSource("1.mp3")):player.stop();
    if(isRunning){
      setState(() {
        isRunning = false;
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
              counter++;
              if(counter_set==counter){
                isWorking = !isWorking;
                counter=0;
                currentTime = 15* 60;
              }else{
                currentTime = GetTime() * 60;
              }
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
  //彈出
  void showAlertDialog(BuildContext context) {

    isRunning=false;
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
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

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
                      startTimer();

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
                    return SetCounter(value);
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
