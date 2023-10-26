#!/bin/bash
echo "ATTENTION! THE GAME WILL CLEAR THE TERMINAL IN 5 SECONDS"
sleep 5
echo $(clear)
GameRules() {
 echo
 echo "Inputs"
 echo -e "1 - Attack\n2 - Defend\n3 - Critical"
 echo
}

LoadingHash() {
  echo -n "Loading : "
  # Simple loading bar
  echo -n "["
  for i in {1..10};
    do
    echo -n "#"
    sleep 0.3
  done
  echo "] Done!"
  echo $(clear)
  GameRules
}


Start() {
 echo -e "Welcome to Attack, Defend and Critical game!\n"
 echo "Enter player 1 name:"; read player1
 echo "Enter player 2 name:"; read player2
 echo
 echo "Prepare yourself!"
 sleep 1
 echo "The game will commence shortly!"
 sleep 1
 echo "GOOD LUCK :)"
 sleep 1
 echo
 LoadingHash
 echo

 turn=1

 player1Hp=100
 player2Hp=100

 player1DefMoves=3
 player2DefMoves=3

 player1CriticMoves=2
 player2CriticMoves=2

 #echo "$player1 $player2"
 echo
}
Start

Attack() {
 #currentPlayerHP (minus hp) - $1"
 #current player - $2
 #opponent player - $3
 echo "$2 chose to attack!"

 attack=$(( $(($RANDOM%6)) +5 ))
 minusHp=$(( $1-attack ))
 echo "$3 left with $minusHp HP"

 case $4 in
 1)
  player2Hp=$minusHp
 ;;
 2)
  player1Hp=$minusHp
 ;;
 esac
}

Defend() {
 #$5 number of moves for defense
  echo "$2 chose to defend"
  if [[ $5 -ne 0 ]]; then

  #currentPlayerHP (rose hp) = $1
  #current player - $2
  #opponent player - $3

  roseHp=$1
  if [[ $roseHp -ne 100 ]]; then
    defend=$(( $(($RANDOM%11)) + 5))
    roseHp=$(($1+$defend))
    if [[ $roseHp -gt 100 ]]; then
      roseHp=100
      echo "$2 with full $roseHp HP"
    else
      echo "gained $defend HP now has $roseHp HP"
    fi
  else
    echo "Already full HP!"
  fi

  case $4 in
  1)
   player1Hp=$roseHp
   player1DefMoves=$(($5-1))
   echo "$2 HAS $player1DefMoves MOVE(S) REMAINING FOR DEFENSE"
  ;;

  2)
   player2Hp=$roseHp
   player2DefMoves=$(($5-1))
   echo "$2 HAS $player2DefMoves MOVE(S) REMAINING FOR DEFENSE"
  ;;
  esac
 else
  echo "NO MOVE LEFT!"
 fi
}

Critical() {
 #6 number of moves for critical
 #$1 - current playerHP $2 - opponent playerHP
 #$3 - current Player $4 - opponent Player
  echo "$3 chose critical"

 if [[ $6 -ne 0 ]]; then
   criticalArray=("$@")

   criticalHpCost=$(( $(($RANDOM%11))+10 ))
   criticalDmgDealt=$(( $(($RANDOM%16))+15 ))
   if [[ $1 -gt $criticalHpCost ]]; then
     Hpcost=$(( $1-$criticalHpCost ))
     Hpremain=$(( $2-$criticalDmgDealt ))

     case $5 in
     1)
       player1Hp=$Hpcost
       player2Hp=$Hpremain
       player1CriticMoves=$(($6-1))
       echo "$3 HAS $player1CriticMoves MOVE(S) REMAINING FOR CRITICAL"
     ;;
     2)
       player1Hp=$Hpremain
       player2Hp=$Hpcost
       player2CriticMoves=$(($6-1))
       echo "$3 HAS $player2CriticMoves MOVE(S) REMAINING FOR CRITICAL"
     ;;
     esac

     echo "$3 dealt $criticalDmgDealt with HP cost $criticalHpCost"
     echo
     echo "$3 now has $Hpcost"
     echo "$4 left with $Hpremain"
   else
     echo "Low HP!"
     echo "Estimate HP cost $criticalHpCost, but HP is $1"
   fi

 else
   echo "NO MOVE LEFT"
 fi
}

Result() {
 #Hilarious Statements
 RandomNumber=$(( $(($RANDOM%19)) ))
 HStateArray=(
  "You're so bad at this game; it's like you're playing with oven mitts on!"
  "I've seen one-legged cats play better than you!"
  "Is your strategy to bore me into quitting? Because it's not working!"
  "I didn't know they gave participation trophies for last place. Congratulations!"
  "You should rename your name as 'Resigned to Defeat' in the game."
  "You're a real-life embodiment of the 'losing is winning' philosophy."
  "I hope you enjoyed the view from the loser's podium!"
  "Your gaming skills are like a unicorn - rarely seen and probably mythical."
  "I just unlocked an achievement: 'Beating You Easily."
  "I'll send you a virtual postcard from the Winner's Circle!"
  "You played like a champ – a 'participating' champ!"
  "You're the reason why 'try' is in 'triumph'."
  "I'm not saying I'm a gaming legend, but I am undefeated in this room!"
  "Congratulations, you've achieved the 'Most Creative Ways to Lose' award."
  "If this were a marathon, you'd be the one lacing up your shoes!"
  "You're like a fine wine; you get better with each game... just not at winning."
  "I'd say 'good game,' but I'm not sure it qualifies as a game on your end."
  "I was going to let you win, but I got distracted by my awesomeness."
  "You were so close to winning, I almost felt bad... almost!"
 )
 HilariousStatement="${HStateArray[$RandomNumber]}"
}


Turns() {
   case $turn in
    1)
     turn=2
     ;;
    2)
     turn=1
     ;;
   esac
}


while :
do
 if [[ $player1Hp -gt 0 && $player2Hp -gt 0 ]]; then

  case $turn in
  1)
    currentPlayer="$player1"
    currentPlayerHP=$player1Hp
    opponentPlayer="$player2"
    minusHp=$player2Hp
    defHp=$player1Hp
    critical=("$player1Hp" "$player2Hp")
    DefMoves=$player1DefMoves
    CriticMoves=$player1CriticMoves
  ;;
  2)
   currentPlayer="$player2"
   currentPlayerHP=$player2Hp
   opponentPlayer="$player1"
   minusHp=$player1Hp
   defHp=$player2Hp
   critical=("$player2Hp" "$player1Hp")
   DefMoves=$player2DefMoves
   CriticMoves=$player2CriticMoves
  ;;
  esac
  echo -e "\nPLAYER $currentPlayer's TURN"
  echo -e "Number of MOVES:"
  echo -e "∞ - Attack\n$DefMoves - Defense\n$CriticMoves - Critical"
  echo -e "HP - $currentPlayerHP\n"
  echo "Select an Option.. (1, 2, 3)"
  read input

  case $input in
   1)

     Attack $minusHp "$currentPlayer" "$opponentPlayer" $turn
     Turns
     echo
     continue
   ;;

   2)

     Defend $defHp "$currentPlayer" "$opponentPlayer" $turn $DefMoves
     Turns
     echo
     continue
   ;;

   3)

     Critical "${critical[@]}" "$currentPlayer" "$opponentPlayer" $turn $CriticMoves
     Turns
     echo
     continue
   ;;

   *)
     echo -e "pls select valid option\n"
     continue
   ;;
  esac

 else
  if [[ player2Hp -le 0 ]]; then
   echo "$player1 WINS!"
   echo "$player1 got something to say:"
   sleep 2
   Result
   echo "$player1 : $HilariousStatement"
  else
   echo "$player2 WINS!"
   echo "$player2 got something to say:"
   sleep 2
   Result
   echo "$player2 : $HilariousStatement"
  fi
  break

 fi
done
