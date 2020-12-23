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

class MyHomePage extends StatelessWidget implements SaveCounterObserver {
  CounterBloc _counterBloc = CounterBloc();

  var _context;

  @override
  void onError(String message) {
    showAlerDialog(message);
  }

  @override
  void onSuccess(String message) {
    showAlerDialog(message);
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    _counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Demo"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _counterBloc.add(LoadCounter());
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _counterBloc.add(SaveCounter(this));
            },
          )
        ],
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          if (state is LoadedCounterState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    state.count.toString(),
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
            );
          }

          if (state is InitialCounterState || state is SaveCounterState) {
            _counterBloc.add(LoadCounter());
            return SizedBox();
          }

          if (state is ErrorCounterState) {
            return Center(
              child: Text(state.error.toString()),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _counterBloc.add(IncrementCounter(1));
            },
          ),
          SizedBox(height: 12.0),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              _counterBloc.add(DecrementCounter(1));
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

  void showAlerDialog(String message) {
    showDialog(
      context: _context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          content: Text(message),
          actions: [
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.pop(dialogContext);
              },
            )
          ],
        );
      },
    );
  }
}
