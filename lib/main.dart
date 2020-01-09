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
    String code = '';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mpesa Daraja API'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: appState.photoUrl(),
          builder: (context, snapshot) => Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
              'https://cdn.wallpapersafari.com/17/98/nJ6FK4.jpg',
              scale: 0.5,
            )
                    // Image.network(
                    //   'https://image.opencart.com/cache/5a3a12fbb7d2c-resize-710x380.jpg',
                    //   fit: BoxFit.fitWidth,
                    // ),
                    )),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Image.network(
                    'https://image.opencart.com/cache/5a3a12fbb7d2c-resize-710x380.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
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
                        RaisedButton(
                            child: Text('json Photo'),
                            onPressed: () async {
                              dynamic text = await appState.photoUrl();
                              setState(() {
                                code = text;
                              });
                            }),
                        // Container(
                        //   width: 200,
                        //   child: Image.network(
                        //     appState.url,
                        //     fit: BoxFit.contain,
                        //   ),
                        // ),
                        // Container(
                        //   child: Text(appState.dispText),
                        // ),
                      ],
                    ),
                    SizedBox(width: 10,)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
