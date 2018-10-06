import 'dart:async';
import 'package:flutter/material.dart';

import 'package:env_vars/env_vars.dart';

void main() {
  EnvVars.set('someCustomKey', 42);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Env vars Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Env vars demo'),
      ),
      body: FutureBuilder(
          future: Future.wait([
            EnvVars.appName,
            EnvVars.buildNumber,
            EnvVars.packageName,
            EnvVars.version
          ]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              final isDev = EnvVars.isDev;
              final appName = snapshot.data[0];
              final buildNumber = snapshot.data[1];
              final packageName = snapshot.data[2];
              final version = snapshot.data[3];
              final someCustomKey = EnvVars.get('someCustomKey');

              final textStyle = Theme.of(context).textTheme.title;

              return Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Dev: $isDev', style: textStyle),
                    Text('App name: $appName', style: textStyle),
                    Text('Package name: $packageName', style: textStyle),
                    Text('Build number: $buildNumber', style: textStyle),
                    Text('Version: $version', style: textStyle),
                    Text('Some custom key: $someCustomKey', style: textStyle),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
