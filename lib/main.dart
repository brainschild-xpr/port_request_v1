import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: AppState(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    AppState appState = AppState();

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.network(
                  'https://image.opencart.com/cache/5a3a12fbb7d2c-resize-710x380.jpg',
                  fit: BoxFit.fitWidth,
                ),
              ),
              RaisedButton(
                child: Text('Access'),
                onPressed: () {
                  appState.getAccessToken();
                },
              ),
              RaisedButton(
                child: Text('Register'),
                onPressed: () {
                  appState.registerUrl();
                },
              ),
              RaisedButton(
                child: Text('Simulate'),
                onPressed: () {
                  appState.simulate();
                },
              ),
              RaisedButton(
                child: Text('Balance'),
                onPressed: () {
                  appState.balance();
                },
              ),
              RaisedButton(
                child: Text('STK_push'),
                onPressed: () {
                  appState.stkPush();
                },
              ),
              // Container(
              //   child: Image.network(
              //     url,
              //     fit: BoxFit.fitWidth,
              //   ),
              // ),
              // Container(
              //   child: Text(url),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
