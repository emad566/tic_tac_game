import 'package:flutter/material.dart';
import 'package:tic_tac_game/game_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  bool isSwitched = false;
  Game game = Game();

  @override
  Widget build(BuildContext context) {
    ThemeData myTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: myTheme.primaryColor,
      body: SafeArea(
        child:
        (MediaQuery.of(context).orientation == Orientation.landscape)?
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  buildHeader(),
                  buildFooter(myTheme),
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: GridView.count(
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
                crossAxisCount: 3,
                children: List.generate(
                  9,
                      (index) => InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: (){
                      _onTap(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: result != '' || Player.playerX.length + Player.playerO.length == 9? myTheme.splashColor : myTheme.shadowColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          Player.playerX.contains(index)? 'X'
                              : Player.playerO.contains(index)? 'O' : '',
                          style: TextStyle(
                            color: Player.playerX.contains(index)? Colors.blue : Colors.pink,
                            fontSize: 52,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),


          ],
        )
        :
        Column(
          children: [
            buildHeader(),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.all(16),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
                crossAxisCount: 3,
                children: List.generate(
                  9,
                  (index) => InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: (){
                      _onTap(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: result != '' || Player.playerX.length + Player.playerO.length == 9? myTheme.splashColor : myTheme.shadowColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          Player.playerX.contains(index)? 'X'
                          : Player.playerO.contains(index)? 'O' : '',
                          style: TextStyle(
                            color: Player.playerX.contains(index)? Colors.blue : Colors.pink,
                            fontSize: 52,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            buildFooter(myTheme),
          ],
        ),
      ),
    );
  }

  Column buildHeader() {
    return Column(
            children: [
              SwitchListTile.adaptive(
                title: const Text(
                  'Turn on/off two player',
                  style: TextStyle(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              Text(
                'It\'s $activePlayer turn',
                style: const TextStyle(fontSize: 58),
                textAlign: TextAlign.center,
              ),
            ],
          );
  }

  Column buildFooter(ThemeData myTheme) {
    return Column(
            children: [
              Text(
                result == '' && Player.playerX.length + Player.playerO.length == 9 ? 'Draw' : result,
                style: const TextStyle(fontSize: 58),
                textAlign: TextAlign.center,
              ),
              if(result != '' || Player.playerX.length + Player.playerO.length == 9)
                const Text('Game Over!', style: TextStyle(fontSize: 20),),

              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    activePlayer = 'X';
                    gameOver = false;
                    turn = 0;
                    result = '';
                    Player.playerX = [];
                    Player.playerO = [];
                  });
                },
                icon: const Icon(Icons.replay),
                label: const Text('Repeat the game'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    myTheme.splashColor,
                  ),
                ),
              ),
            ],
          );
  }

  void _onTap(index) async{
    if (Player.playerX.length + Player.playerO.length == 9 || result != '') {
      gameOver = true;
      return;
    }
    if(
      (Player.playerX.isEmpty || !Player.playerX.contains(index))
      && (Player.playerO.isEmpty || !Player.playerO.contains(index))
    ){
      game.playGame(index, activePlayer);
      activePlayer = (activePlayer == 'X')? 'O' : 'X';
      turn++;

      if(!isSwitched && !gameOver){
        await  game.autoPlay(activePlayer);
        activePlayer = (activePlayer == 'X')? 'O' : 'X';
        turn++;
      }

      result = game.checkWinner();
      updateState();
    }
  }

  void updateState() {
    setState(() {});
  }
}
