using System;
using BattleShipBrain;
using BattleShipConsoleUI;

namespace BattleShipConsoleApp
{
    class Program
    {
        
        static void Main(string[] args)
        {
            Console.WriteLine("Hello Battleship!");
            var brain = new BSBrain(10,5);
            
            BSConsoleUI.DrawBoard(brain.GetBoard(0));
            
            var b = brain.GetBoard(0);
            
            b[0, 0].IsBomb = true;
            b[0, 0].IsShip = false;
            
            
            Console.WriteLine("+---+---+--------------");
            Console.WriteLine("| x | * |");
            Console.WriteLine("+---+---+---------------");
            Console.WriteLine("----------------------");

            BSConsoleUI.DrawBoard(brain.GetBoard(0));

        }
    }
}