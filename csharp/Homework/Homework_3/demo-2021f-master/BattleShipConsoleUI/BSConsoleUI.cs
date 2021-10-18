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
                    Console.Write(board[x,y]); //Write the char corresponding
                    // Note : - missed
                    // 0 is a ship
                    // * is a bombed ship
                
                }
                Console.WriteLine();
            }
        }

        public static void DrawBothBoard(BoardSquareState[,] board1,BoardSquareState[,] board2)
        {
            DrawBoard(board1);
            for (var i = 0; i < board1.GetLength(1); i++)
            {
                Console.Write("~");
            }
            Console.WriteLine("");
            DrawBoard(board2);
        }
    }
    
}