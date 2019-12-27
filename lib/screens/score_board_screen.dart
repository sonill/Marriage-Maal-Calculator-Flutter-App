import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/players_data.dart';
import '../widgets/buttons.dart';
import '../models/globals.dart' as globals;


class ScoreBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Board'),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // _select(choices[0]);
              Navigator.pushNamed(context, '/settings');
            },
          ),
          // action button
          
        ],
      ),
      body: new GestureDetector(
        // hide keyboard when clicked outside textfield
        onTap: () { FocusScope.of(context).requestFocus(new FocusNode());},
        child: ScoreBoardScreenBody(),
      )
    );
  }
}

// ------------------------------------------------------------

class _PlayerName extends StatelessWidget {
  final _name;
  const _PlayerName(this._name);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        '$_name',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      )
    );
  }
}

// ------------------------------------------------------------

class _ScoreBoardHeading extends StatelessWidget {
  final String label;

  const _ScoreBoardHeading(this.label);
  
  @override
  Widget build(BuildContext context,) {
    return Container(
      width: 40,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          '$label',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,                    
          ),
        ),
      )
    );
  }
}

// ------------------------------------------------------------

class ScoreBoardScreenBody extends StatefulWidget {
  @override
  _ScoreBoardScreenBodyState createState() => _ScoreBoardScreenBodyState();
}


bool firstBoot = true;

class _ScoreBoardScreenBodyState extends State<ScoreBoardScreenBody> {

  List textEditingControllers = [];
  List _matchScores = []; // it will be updated from futurebuilder. scroll to bottom
  int radioGroup;
  List _settings = [];

  Widget checkbox(int index, String referenceVarName ) {

    return Container(
      width: 40,
      child: Checkbox(
        value: _matchScores[index][referenceVarName], 
        onChanged: (bool value) {
          setState(() {
            
            _matchScores[index][referenceVarName] = value;

            if( referenceVarName == 'dubli' && value == true){
              _matchScores[index]['seen'] = true;
            }

            if( referenceVarName == 'seen' && radioGroup == index && value == false){
              _matchScores[index][referenceVarName] = true;
            }

            

          });
        },
      )
    );

  }

  Widget _singleRow(context, index){

    return Row(
      children: <Widget>[
        _PlayerName(_matchScores[index]['name']),
        Container(
          width: 50,
          margin: EdgeInsets.only(right: 6),
          height: 36,
          padding: EdgeInsets.all(0),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: Color(0xffE4EDF5),
            border: Border.all(
              color: Color(0xffB3C3DB), 
            ),
          ),
          child: TextField(
            textAlignVertical: TextAlignVertical.top,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.numberWithOptions(signed: true),
            controller: textEditingControllers[index],
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom:13),
              hintText: '0',
            ),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        checkbox( index, 'seen' ),
        checkbox( index, 'dubli' ),
        Container(
          width: 40, 
          child: Radio(
            value: index, //win, 
            onChanged: (T) {
              setState(() {
                resetWiner();
                _matchScores[index]['win'] = true;
                _matchScores[index]['seen'] = true;
                radioGroup = T;
              });
            }, 
            groupValue: radioGroup,
          )
        ),
      ],
    );
  }

  void resetWiner(){
    for( int i = 0; i < _matchScores.length; i++ ){
      _matchScores[i]['win'] = false;
    }
  }

  Widget scoreBoard(context) {

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(child: Text('',)),
              Container(
                width: 50,
                margin: EdgeInsets.only(right: 6),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Maal',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,                    
                    ),
                  ),
                )
              ),
              _ScoreBoardHeading('Seen'),
              _ScoreBoardHeading('Dubli'),
              _ScoreBoardHeading('Win'),
            ],
          ),
        ),

        for( var i = 0; i < _matchScores.length; i++) _singleRow(context, i),

      ],
    );

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    for( int i = 0; i < _matchScores.length; i++ ){
      textEditingControllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final PlayersDataModel playersDataModel = Provider.of<PlayersDataModel>(context);
    final routesData =  ModalRoute.of(context).settings.arguments as Map;


    if( routesData['reset'] != null && routesData['reset'] == true) {
      firstBoot = true;
      routesData['reset'] = false;
    }

    if( firstBoot == true ){
      playersDataModel.updateMatchScore([]);
      firstBoot = false;
    }


    
    return FutureBuilder(
      future: playersDataModel.generateNewMatchScores(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          
          // generate _matchScores data
          _matchScores = playersDataModel.getMatchScores();

          _settings = playersDataModel.getSettings();

          for(int i = 0; i < _matchScores.length; i++){
            textEditingControllers.add(TextEditingController());
          }
          
          if (_matchScores.length > 0) {

            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(globals.mainContainerPadding),
                  child: Column(
                    children: <Widget>[
                      scoreBoard(context),
                      SizedBox(height: 30),
                      MyButtons('View Results', () => _verifyScores(), 'solid', 'green', 8),
                      MyButtons('Manage Players', () {
                        Navigator.pushReplacementNamed(context, '/players');
                      }, 'bordered', 'blue', 8),
                    ],
                  ),
                ),
              ),
            );
          }
          else{
            return SafeArea(
              child: Container(
                padding: EdgeInsets.all(globals.mainContainerPadding),
                child: Center(
                  child: MyButtons('Return Back', () {
                    Navigator.pushReplacementNamed(context, '/');
                  }, 'solid', 'blue', 8),
                ),
              ),
            );
          }
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }


  // --------------------------------------------------------------

  int maalSeen(_maal ){
    return (_maal * _matchScores.length);
  }

  int maalNotSeen(_totalMaal){
    int _number =  _totalMaal + _settings[0]['unseen'];
    // return negative value
    return _number*(-1);
  }

  int seenLessPoints(_maal, _totalMaal){
    return maalSeen( _maal ) -  _totalMaal;
  }

  void _verifyScores(){

    bool _winnerSelected = false;
    int _winIndex;
    int _totalMaal = 0;
    bool _dubliWin = false;
    int _totalWinningPoints = 0;

    for(int i = 0; i < _matchScores.length; i++ ){
      String maal = textEditingControllers[i].text;
      int maalInt = (maal.length > 0) ? int.parse(maal) : 0;
      _matchScores[i]['maal'] = maalInt;

      // total maal count
      if( _matchScores[i]['seen'] == true ){
        _totalMaal +=  maalInt;
      }


      // find winner
      if( _matchScores[i]['win'] == true ){
        _winnerSelected = true;
        _winIndex = i;

        // dubli
        if( _matchScores[i]['dubli'] ){
          _dubliWin = true;
        }

      }

    }

    void updateTotalWinningPoints(_result){
      // change positive to negative and vice versa
      _totalWinningPoints = _totalWinningPoints + (_result * (-1));
    }
    

    if( _winnerSelected ){

      // calculate results

      for(int i = 0; i < _matchScores.length; i++ ){
        int _maal = _matchScores[i]['maal'];
        bool _seen = _matchScores[i]['seen'];
        bool _dubli = _matchScores[i]['dubli'];
        bool _win = _matchScores[i]['win'];

        // winner will always be last

        if( !_win ){

          if( _dubliWin ){

            if( _settings[0]['enable_dubli'] == 1 ){

              if( _seen ){

                if(_dubli){
                  
                    // won in dubli, seen, dubli, dubli enabled
                    // less points
                    int _results = maalSeen( _maal ) -  _totalMaal;
                    _matchScores[i]['results'] = _results;
                    
                    // update total winning points
                    updateTotalWinningPoints(_results);

                }
                else{
                  // won in dubli, seen, not dubli, dubli enabled
                  int _results =  maalSeen( _maal ) - (_totalMaal + _settings[0]['dubli']);
                  _matchScores[i]['results'] = _results;
                  
                  // update total winning points
                  updateTotalWinningPoints(_results);

                }

              }
              else{
                // won in dubli, not seen, dubli enabled
                int _results = maalNotSeen(_totalMaal); 
                _matchScores[i]['results'] = _results;
                  
                // update total winning points
                updateTotalWinningPoints(_results);
              }

            }
            else{

              // dubli not enabled
              
              if( _seen ){
                // dubli not enabled
                // won in dubli, seen
                // same for dubli and no dubli
                int _results = maalSeen( _maal ) -  (_totalMaal + _settings[0]['seen']);
                _matchScores[i]['results'] = _results;

                // update total winning points
                updateTotalWinningPoints(_results);

              }
              else{
                // won in dubli, not seen, dubli not enabled
                int _results = maalNotSeen(_totalMaal); 
                _matchScores[i]['results'] = _results;

                // update total winning points
                updateTotalWinningPoints(_results);
              }

            }

          }
          else{

            // game not won in dubli
            // regular points

            if( _settings[0]['enable_dubli'] == 1 ){

              if( _seen ){

                if(_dubli){
                  
                    // seen, dubli, dubli enabled
                    // less points
                    int _results = seenLessPoints(_maal, _totalMaal);
                    _matchScores[i]['results'] = _results;

                    // update total winning points
                    updateTotalWinningPoints(_results);

                }
                else{
                  // seen, not dubli, dubli enabled
                  int _results =  maalSeen( _maal ) - (_totalMaal + _settings[0]['seen']);
                  _matchScores[i]['results'] = _results;

                  // update total winning points
                  updateTotalWinningPoints(_results);
                }

              }
              else{
                // not seen, dubli enabled
                int _results = maalNotSeen(_totalMaal); 
                _matchScores[i]['results'] = _results;

                // update total winning points
                updateTotalWinningPoints(_results);
              }

            }
            else{

              // dubli not enabled
              
              if( _seen ){
                // dubli not enabled
                // seen
                // same for dubli and no dubli
                int _results = maalSeen( _maal ) -  (_totalMaal + _settings[0]['seen']);
                _matchScores[i]['results'] = _results;

                // update total winning points
                updateTotalWinningPoints(_results);

              }
              else{
                // not seen, dubli not enabled
                int _results = maalNotSeen(_totalMaal); 
                _matchScores[i]['results'] = _results;

                // update total winning points
                updateTotalWinningPoints(_results);
              }

            }

          }
          
        }
        
      }

      // update winner results
      _matchScores[_winIndex]['results'] = _totalWinningPoints;

    } 
    else{
      // winner not selected

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Please select a winner'),
            // content: Text(
            //   'You need a player'
            // ),
            actions: <Widget>[
              MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('OK'),
                elevation: 0,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      );
      
    }

    Navigator.of(context).pushReplacementNamed('/results', arguments: {'data': _matchScores, 'totalMaal' : _totalMaal, 'winner' : _matchScores[_winIndex]});

  } // function end


} // main class
