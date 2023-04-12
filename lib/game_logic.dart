
import 'dart:math';


class Player{
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension  ContainAll on List {
  bool containAll(List<int> list){
    bool flag = true;
    for (var e in list) {if(!contains(e)) flag = false;}
    return flag;
  }
}

class Game{
  void playGame(int index, String activePlayer) {
    if(activePlayer == 'X')
      Player.playerX.add(index);
    else
      Player.playerO.add(index);
  }




  String checkWinner(){
    String winner = '';
    if(
      Player.playerX.containAll([0,1,2])
     || Player.playerX.containAll([3,4,5])
     || Player.playerX.containAll([6,7,8])
     || Player.playerX.containAll([0,3,6])
     || Player.playerX.containAll([1,4,7])
     || Player.playerX.containAll([2,5,8])
     || Player.playerX.containAll([0,4,8])
     || Player.playerX.containAll([2,4,6])
    )
      winner = 'X';
    else if(
      Player.playerO.containAll([0,1,2])
      || Player.playerO.containAll([3,4,5])
      || Player.playerO.containAll([6,7,8])
      || Player.playerO.containAll([0,3,6])
      || Player.playerO.containAll([1,4,7])
      || Player.playerO.containAll([2,5,8])
      || Player.playerO.containAll([0,4,8])
      || Player.playerO.containAll([2,4,6])
    )
      winner = 'O';
    return winner;
  }

  Future<void> autoPlay(String activePlayer) async{
    int index = 0;
    List<int> emptyCells = [];
    for(var i = 0; i < 9; i++){
      if(!Player.playerX.contains(i) && !Player.playerO.contains(i)){
        emptyCells.add(i);
      }
    }

    Random random = Random();
    print(emptyCells);
    if(emptyCells.length >=2){
      int randomIndex = random.nextInt(emptyCells.length);
      index = emptyCells[randomIndex];
    }else{
      if(emptyCells.isNotEmpty)
      index = emptyCells[0];
    }


    print('$index $activePlayer', );
    if(emptyCells.isNotEmpty)
    playGame(index, activePlayer);
  }

}
