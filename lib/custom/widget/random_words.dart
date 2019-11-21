import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*
 * Custom widget
 */
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State {
  final _suggestions = <WordPair>[];
  final _biggerFont  = const TextStyle(fontSize: 18);
  final _saved       = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _showListSaved,)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _toast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.grey,
        fontSize: 16.0
    );
  }

  void _showListSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          final tiles = _saved.map( (wordPair) {
            return ListTile(
              title: Text(
                wordPair.asPascalCase,
                style: _biggerFont,
              ),
            );
          });
          //
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles
          ).toList();
          //
          return Scaffold(
            appBar: AppBar(
              title: Text('Favorited'),
            ),
            body: ListView(children: divided,)
          );
        }
      )
    );
  }

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, i){
        if (i.isOdd) return Divider();
        //
        final index = i ~/ 2;
        if (index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        //
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair){
    final alreadySaved = _saved.contains(wordPair);
    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      leading: Icon(
        Icons.flash_on,
        color: Colors.blue,
      ),
      trailing: GestureDetector(
        onTap: (){
          setState(() {
            alreadySaved ? _saved.remove(wordPair) : _saved.add(wordPair);
          });
        },
        child: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
      ),
      onTap: () => _toast(wordPair.toString()),
    );
  }
}
