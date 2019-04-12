import 'package:flutter/material.dart';
import './random_word.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

enum ListType{
  favorite,
  random
}

class _ListPageState extends State<ListPage> {

  final List wordList = RandomWords().fillList();
  final List _favList = List<String>();
  ListType _listType = ListType.random;

/////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:  titleChecker(),
          actions: buttonBuilder(),
        ),
        body: bodyBuilder()
      )
    );
  }
/////////////////////////////////////////

/////////////////////////////////////////
//Called from Scaffold: body property to generate ListView's based on the ListType state.
  Widget bodyBuilder(){
    if(_listType == ListType.random){
      return randomWordPopulator();
    }
    else{
      return  favoriteListPopulator();
    }
  }
/////////////////////////////////////////

/////////////////////////////////////////
//Called from Scaffold: appbar property to generate title text based on the ListType state.
  Widget titleChecker(){
    if(_listType == ListType.random){
      return Text('RandomWord Generator');
    }
    else{
      return Text('Favorite List');
    }
  }
/////////////////////////////////////////

/////////////////////////////////////////
//Called from Scaffold: appbar property to generate action buttons based on the ListType state.
  List<Widget> buttonBuilder(){
    if(_listType == ListType.random){
      return [IconButton(
        icon: Icon(Icons.filter_1), 
        onPressed: (){
          setState(() {
           _listType = ListType.favorite; 
          });
        },)
      ];
    }
    else{
      return [IconButton(
        icon: Icon(Icons.filter_2), 
        onPressed: (){
          setState(() {
           _listType = ListType.random; 
          });
        },)
      ];
    }
  }
/////////////////////////////////////////

/////////////////////////////////////////
//Called from listGenerator methods to generate ListTiles based on the current ListType state.
  Widget listTypeChecker(int i){
    final bool isSaved = _favList.contains(wordList[i]);

    if(_listType == ListType.random){
      return ListTile(
        title: Text('${wordList[i]}'),
        trailing: Icon(
          isSaved ? Icons.favorite : Icons.favorite_border,
          color: isSaved ? Colors.red : null,
        ),
        onTap: (){
          setState(() {
            _favList.contains(wordList[i]) ? _favList.remove(wordList[i]) : _favList.add(wordList[i]);
          });
          print(_favList);
        }
      );
    }
    else{
      return ListTile(
        title: Text('${_favList[i]}'),
        trailing: Icon(
          Icons.favorite,
          color: Colors.red
        ),
        onTap: (){
          setState(() {
            _favList.remove(_favList[i]);
          });
          print(_favList);
        }
      );
    }
  }
/////////////////////////////////////////

/////////////////////////////////////////
//Called from Scaffold, body property to check listType state.
  Widget randomWordPopulator(){
    return ListView.builder(
      itemBuilder: (BuildContext context, int i){
        if(i.isOdd){
          return Divider();
        }

        return listTypeChecker(i);
      },
    );
  }
/////////////////////////////////////////

/////////////////////////////////////////
//Called from Scaffold, body property to check listType state.
  Widget favoriteListPopulator(){
    return ListView.builder(
      itemBuilder: (BuildContext context, int i){

        return listTypeChecker(i);
      },
      itemCount: _favList.length,
    );
  }
/////////////////////////////////////////
}
