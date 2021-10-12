using System;
using BattleShipBrain;

namespace BattleShipConsoleUI
{
    public static class BSConsoleUI
    {
        public static void DrawBoard(BoardSquareState[,] board)
        {
            for (var y = 0; y < board.GetLength(1); y++)
            {
                for (var x = 0; x < board.GetLength(0); x++)
                {
                    Console.Write(board[x,y]);
                }
                Console.WriteLine();
            }
        }
    }
    
}