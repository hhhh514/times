import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../schedule/schedule.dart';
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
 /*play()async{
  AudioPlayer player = AudioPlayer();
  player.setSourceAsset('test.mp3');
  //player.play();
}*/
class _PomodoroTimerState extends State<PomodoroTimer> {

  int workTime = 25;
  int breakTime = 5;
  int currentTime = 25 * 60; // Initial time in seconds
  bool isWorking = true;
  bool isRunning = false;
  bool istesting = true;
  late Timer timer;

  int counter = 0;

  void startTimer() {
    if (istesting) {
      player.play(AssetSource("1.mp3"));
      istesting=false;
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (currentTime > 0) {
            currentTime--;
          } else {
            if (isWorking) {
              player.stop();
              player.play(AssetSource("timeout.mp3"));
              currentTime = breakTime * 60;
            } else {
              currentTime = workTime * 60;
            }
            isWorking = !isWorking;
          }
        });
      });
    }
  }

  void pauseTimer() {
    if (!istesting) {
      player.stop();
      istesting=true;
      timer.cancel();
    }
  }
  void resetTimer() {
    istesting=true;
    timer.cancel();
    setState(() {
      currentTime = workTime * 60;
      isWorking = true;
      isRunning = false;
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
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              isWorking ? 'Work Time' : 'Break Time',
              style: TextStyle(fontSize: 20,backgroundColor:Color.fromARGB(255, 255, 255, 255)),
            ),
            SizedBox(height: 20),
            Text(
              formatTime(currentTime),
              style: TextStyle(fontSize: 40,backgroundColor:Color.fromARGB(255, 255, 255, 255)),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isRunning = true;
                      });
                      startTimer();
                    },
                    child: Text('Start'),
                  ),
                  SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isRunning = false;
                    });
                    pauseTimer();
                  },
                  child: Text('Pause'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    resetTimer();
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}