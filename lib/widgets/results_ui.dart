import 'package:flutter/material.dart';
import '../models/globals.dart' as globals;

class ResultsUI extends StatefulWidget {
  final Map args;

  const ResultsUI(this.args);

  @override
  _ResultsUIState createState() => _ResultsUIState();
}

class _ResultsUIState extends State<ResultsUI> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {

    final String _name = widget.args['name'];
    int _result = widget.args['results'];
    final bool _titleRow = (widget.args['titleRow'] != null) ? widget.args['titleRow'] : false;
    List<String> _extraTextList = [];


    if( widget.args['win'] != null && widget.args['win'] == true  ) _extraTextList.add('Winner');
    if( widget.args['seen'] != null && widget.args['seen'] == true  ){
      _extraTextList.add('Seen');
      if( widget.args['dubli'] != null && widget.args['dubli'] == true  ) _extraTextList.add('Dubli');  
      if( widget.args['maal'] != null ) _extraTextList.add('Maal : ' + widget.args['maal'].toString());
    } 
    else{
      if( !_titleRow  ) {
        _extraTextList.add('Maal Not Seen');
      }
      else{
        final List _settings = widget.args['settings'];
        _extraTextList.add('Seen: +' + _settings[0]['seen'].toString());
        _extraTextList.add('Not Seen: +' + _settings[0]['unseen'].toString());

        if( widget.args['dubli'] != null && widget.args['dubli'] == true && _settings[0]['enable_dubli'] == 1  ){
          _result += _settings[0]['dubli'];
        }
      }
    }


    String _extraText = _extraTextList.join(', ');

    return InkWell(
      splashColor: Colors.transparent,
      onTap: (){
        setState(() {
          _visible = !_visible;
        });
      },
      child: Container(
        margin: new EdgeInsets.only(bottom: 10.0),
        // over
        decoration: new BoxDecoration(
          color: (_titleRow) ? Color(globals.getColor('blue')) : Colors.white,
          borderRadius: new BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              blurRadius: 5.0, 
              spreadRadius: 0.0,
              offset: Offset(
                2.0, // horizontal
                3.0, // vertical
              ),
            )
          ],
        ),
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "$_name",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: (_titleRow) ? Colors.white : Colors.black,
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      '$_result',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        // color: Color(globals.getColor('blue')),
                        color: (_titleRow) ? Colors.white : Color(globals.getColor('blue')),
                      ),
                    ),
                  )
                ],
              ),
            ),
            AnimatedOpacity(
              // If the widget is visible, animate to 0.0 (invisible).
              // If the widget is hidden, animate to 1.0 (fully visible).
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              // The green box must be a child of the AnimatedOpacity widget.
              child: Container(
                height: _visible ? 34.0 : 0.0,
                alignment: Alignment.topLeft,
                // margin: EdgeInsets.only(top: 15),
                margin: EdgeInsets.only(top: 45, left: 15),
                child: Text(
                  "$_extraText",
                  style: TextStyle(
                    color: (_titleRow) ? Colors.white : Colors.black,
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
