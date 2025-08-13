import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled3/ui/screens/cancelled-task-screen.dart';
import 'package:untitled3/ui/screens/completed-task-screen.dart';
import 'package:untitled3/ui/screens/new-task-screen.dart';
import 'package:untitled3/ui/screens/progress-task-screen.dart';
import 'package:untitled3/ui/utils/app_Colors.dart';
import 'package:untitled3/ui/widgets/TM_Appbar.dart';

class mainBottomNavScreen extends StatefulWidget {
  const mainBottomNavScreen({super.key});

  @override
  State<mainBottomNavScreen> createState() => _mainBottomNavScreenState();
}

class _mainBottomNavScreenState extends State<mainBottomNavScreen> {

  //static const String name = '/home';

  int _currentIndex = 0;

  List<Widget> _screens = [
    newTaskScreen(),
    completedTaskScreen(),
    progressTaskScreen(),
    cancelledTaskScreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //backgroundColor: Color(0xFFFEFFF1),
      appBar: TM_AppBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -1),
              spreadRadius: 0,
              blurRadius: 2
            )
          ]
        ),
        child: NavigationBar(
            //backgroundColor: Colors.white,
            backgroundColor: Color(0xFFFEFFF1),
          indicatorColor: Color(0xFF003366),
          height: 70,
          selectedIndex: _currentIndex,
            onDestinationSelected: (int index){
              setState(() {
                _currentIndex = index;
              });
            },
            destinations: [

             NavigationDestination(
                 icon: Icon(Icons.task,color: Colors.blue,),
                 label: 'New task',

             ),

              NavigationDestination(
                 icon: Icon(Icons.check_circle,color: Colors.green,),
                 label: 'Completed'
             ),
              NavigationDestination(
                  icon: Icon(Icons.incomplete_circle,color: Colors.orange,),
                  label: 'In progress'
              ),
              NavigationDestination(
                 icon: Icon(Icons.cancel,color: Colors.red,),
                 label: 'Cancelled'
             ),

            ]
        ),
      ),
    );
  }
}

