class CalculateResults {
  final List _matchScores;
  final List _settings;
  final List _textEditingControllers;

  const CalculateResults(this._matchScores, this._settings, this._textEditingControllers);

  int _maalSeen(_maal) => _maal * _matchScores.length;
  int _maalNotSeen(_totalMaal) => (_totalMaal + _settings[0]['unseen']) * (-1);
  int _seenLessPoints(_maal, _totalMaal) => _maalSeen(_maal) - _totalMaal;

  bool isWinnerSelected(){

    for (int i = 0; i < _matchScores.length; i++) {
      // find winner
      if (_matchScores[i]['win'] == true) {
        return true;
      }
    }

    return false;
  }

  Map calcResults(bool _winnerIsSelected) {

    // this function should only be called after winner is selected

    if( _winnerIsSelected ){

      // bool _winnerSelected = false;
      int _winIndex;
      int _totalMaal = 0;
      // int _totalMaalFinal = 0;
      bool _dubliWin = false;
      int _totalWinningPoints = 0;

      String maal = '';
      int maalInt = 0;
      int _results = 0;

      // Map finalMatchScores = {};

      void _updateTotalWinningPoints(_result) =>
          _totalWinningPoints += (_result * (-1));

      for (int i = 0; i < _matchScores.length; i++) {
        maal = _textEditingControllers[i].text;
        maalInt = (maal.length > 0) ? int.parse(maal) : 0;
        _matchScores[i]['maal'] = maalInt;

        // total maal count
        if (_matchScores[i]['seen'] == true) {
          _totalMaal += maalInt;
          // _totalMaalFinal += maalInt;
        }

        // find winner
        if (_matchScores[i]['win'] == true) {
          _winIndex = i;

          // dubli
          if (_matchScores[i]['dubli']) {
            _dubliWin = true;
            // _totalMaalFinal =
                // _totalMaalFinal + _settings[0]['seen'] + _settings[0]['dubli'];
          } else {
            // _totalMaalFinal += _settings[0]['seen'];
          }
        }
      }

      // -----------------------------------------------------------------------------

      // calculate results

      for (int i = 0; i < _matchScores.length; i++) {
        int _maal = _matchScores[i]['maal'];
        bool _seen = _matchScores[i]['seen'];
        bool _dubli = _matchScores[i]['dubli'];
        bool _win = _matchScores[i]['win'];

        // winner will always be last

        if (!_win) {
          if (_dubliWin) {
            if (_settings[0]['enable_dubli'] == 1) {
              if (_seen) {
                if (_dubli) {
                  // won in dubli, seen, dubli, dubli enabled
                  // less points
                  _results = _maalSeen(_maal) - _totalMaal;
                  _matchScores[i]['results'] = _results;

                  // update total winning points
                  _updateTotalWinningPoints(_results);
                } else {
                  // won in dubli, seen, not dubli, dubli enabled
                  _results = _maalSeen(_maal) -(_totalMaal + _settings[0]['seen'] + _settings[0]['dubli']);
                  _matchScores[i]['results'] = _results;

                  // update total winning points
                  _updateTotalWinningPoints(_results);
                }
              } else {
                // won in dubli, not seen, dubli enabled
                _results = _maalNotSeen(_totalMaal + _settings[0]['dubli']);
                _matchScores[i]['results'] = _results;

                // update total winning points
                _updateTotalWinningPoints(_results);
              }
            } else {
              // dubli not enabled

              if (_seen) {
                // dubli not enabled
                // won in dubli, seen
                // same for dubli and no dubli
                _results = _maalSeen(_maal) - (_totalMaal + _settings[0]['seen']);
                _matchScores[i]['results'] = _results;

                // update total winning points
                _updateTotalWinningPoints(_results);
              } else {
                // won in dubli, not seen, dubli not enabled
                _results = _maalNotSeen(_totalMaal);
                _matchScores[i]['results'] = _results;

                // update total winning points
                _updateTotalWinningPoints(_results);
              }
            }

          } else {
            // game not won in dubli
            // regular points

            if (_settings[0]['enable_dubli'] == 1) {
              if (_seen) {
                if (_dubli) {
                  // seen, dubli, dubli enabled
                  // less points
                  _results = _seenLessPoints(_maal, _totalMaal);
                  _matchScores[i]['results'] = _results;

                  // update total winning points
                  _updateTotalWinningPoints(_results);
                } else {
                  // seen, not dubli, dubli enabled
                  _results = _maalSeen(_maal) - (_totalMaal + _settings[0]['seen']);
                  _matchScores[i]['results'] = _results;

                  // update total winning points
                  _updateTotalWinningPoints(_results);
                }
              } else {
                // not seen, dubli enabled
                _results = _maalNotSeen(_totalMaal);
                _matchScores[i]['results'] = _results;

                // update total winning points
                _updateTotalWinningPoints(_results);
              }

            } else {
              // dubli not enabled

              if (_seen) {
                // dubli not enabled
                // seen
                // same for dubli and no dubli
                _results = _maalSeen(_maal) - (_totalMaal + _settings[0]['seen']);
                _matchScores[i]['results'] = _results;

                // update total winning points
                _updateTotalWinningPoints(_results);
              } else {
                // not seen, dubli not enabled
                _results = _maalNotSeen(_totalMaal);
                _matchScores[i]['results'] = _results;

                // update total winning points
                _updateTotalWinningPoints(_results);
              }
            }
          }
        }
      }

      // update winner results
      _matchScores[_winIndex]['results'] = _totalWinningPoints;
      

      return { 'matchScores' : _matchScores, 'totalMaal' : _totalMaal, 'dubliWin' : _dubliWin, 'winnerData' : _matchScores[_winIndex] };

    }
    else{
      return {};
    }


  } // function end
  

} // class end
