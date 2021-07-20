import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rtm_system/ultils/src/color_ultils.dart';

class SimpleAnimatedList extends StatefulWidget {
  const SimpleAnimatedList({Key key}) : super(key: key);

  @override
  _SimpleAnimatedListState createState() => _SimpleAnimatedListState();
}

class _SimpleAnimatedListState extends State<SimpleAnimatedList> {
  int _current;

  List<StepState> _listState;

  @override
  void initState() {
    _current = 0;
    _listState = [
      StepState.indexed,
      StepState.editing,
      StepState.complete,
    ];
    super.initState();
  }

  List<Step> _createSteps(BuildContext context) {
    List<Step> _steps = <Step>[
      new Step(
        state: _current == 0
            ? _listState[1]
            : _current > 0
                ? _listState[2]
                : _listState[0],
        title: new Text('Step 1'),
        content: new Text('Do Something'),
        isActive: true,
      ),
      new Step(
        state: _current == 1
            ? _listState[1]
            : _current > 1
                ? _listState[2]
                : _listState[0],
        title: new Text('Step 2'),
        content: new Text('Do Something'),
        isActive: true,
      ),
      new Step(
        state: _current == 2
            ? _listState[1]
            : _current > 2
                ? _listState[2]
                : _listState[0],
        title: new Text('Step 3'),
        content: new Text('Do Something'),
        isActive: true,
      ),
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    List<Step> _stepList = _createSteps(context);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Stepper Example'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Expanded(
                child: Stepper(
                  type: StepperType.vertical,
                  steps: _stepList,
                  currentStep: _current,
                  onStepContinue: () {
                    setState(() {
                      if (_current < _stepList.length - 1) {
                        _current++;
                      } else {
                        _current = _stepList.length - 1;
                      }
                      //_setStep(context);
                    });
                  },
                  onStepCancel: () {
                    setState(() {
                      if (_current > 0) {
                        _current--;
                      } else {
                        _current = 0;
                      }
                      //_setStep(context);
                    });
                  },
                  onStepTapped: (int i) {
                    setState(() {
                      _current = i;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
