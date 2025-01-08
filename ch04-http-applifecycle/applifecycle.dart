import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

// Instantiating the main app
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'http example',
      home: AppLifeCycleExample(),
    );
  }
}

class AppLifeCycleExample extends StatefulWidget {
  const AppLifeCycleExample({super.key});

  @override
  State<AppLifeCycleExample> createState() => _AppLifeCycleExampleState();
}

class _AppLifeCycleExampleState extends State<AppLifeCycleExample> with WidgetsBindingObserver{
  
  /**
    There are 2 ways to track the application lifecycle:
      1- Check AppLifecycleState: can do this by using WidgetsBindingObserver mixin and didChangeDependencies function
      2- Check state transitions using AppLifecycleListener
   **/

  late AppLifecycleListener listener;

  @override
  void initState() {
    /***** Method 1: Tracking State *****/
    // We want to track the current widget/page cycles, so
    // make this class use the WidgetsBindingObserver mixin functions 
    //  add this widget to the WidgetsBinding observers 
    WidgetsBinding.instance.addObserver(this);

    /***** Method 2: Tracking Transitions *****/
    listener = AppLifecycleListener(
      // forward direction
      onInactive: () => print('onInactive'),
      onHide: () => print('onHide'),
      onPause: () => print('onPause'),
      onDetach: ()=>print('onDetach'),
      // backward direction
      onRestart: ()=>print('onRestart'),
      onShow: ()=>print('onShow'),
      onResume: ()=>print('onResume'),
    );
    
    super.initState();
  }

  @override
  void dispose() {
    /***** Method 1: Tracking State *****/
    WidgetsBinding.instance.removeObserver(this);
    
    /***** Method 2: Tracking Transitions *****/
    listener.dispose();
    super.dispose();
  }

  /***** Method 1: Tracking State *****/
  @override
  didChangeAppLifecycleState(AppLifecycleState state){
    print(state);
    if(state == AppLifecycleState.detached){
      print('you are dead');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: FlutterLogo(size: 150))
    );
  }
}


