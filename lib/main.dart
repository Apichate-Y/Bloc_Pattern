import 'package:bloc_pattern/bloc/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc_observer.dart';

void main() {
  Bloc.observer = FlowBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => CounterBloc(),
        child: MyHomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  CounterBloc _counterBloc;

  @override
  Widget build(BuildContext context) {
    _counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Demo"),
      ),
      body: BlocBuilder<CounterBloc, int>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  state.toString(),
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _counterBloc.add(IncrementCounter(10));
            },
          ),
          SizedBox(height: 12.0),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              _counterBloc.add(DecrementCounter(10));
            },
          ),
          SizedBox(height: 12.0),
          FloatingActionButton(
            child: Icon(Icons.restore),
            onPressed: () {
              _counterBloc.add(ResetCounter());
            },
          ),
        ],
      ),
    );
  }
}
