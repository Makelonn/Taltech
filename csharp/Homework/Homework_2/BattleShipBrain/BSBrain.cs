using System;

namespace BattleShipBrain
{
    public class BSBrain
    {

        private readonly BoardSquareState[,] _boardA; //Player A ocean
        private readonly BoardSquareState[,] _boardB; //Player B ocean
        
        private readonly Random _rnd = new Random();
        
        public BSBrain(int xSize, int ySize)
        {
            _boardA = new BoardSquareState[xSize,ySize];
            _boardB = new BoardSquareState[xSize,ySize];

            for (var x = 0; x < xSize; x++)
            {
                for (var y = 0; y < ySize; y++)
                {
                    _boardA[x, y] = new BoardSquareState
                    {
                        IsBomb = _rnd.Next(0, 2) != 0,
                        IsShip = _rnd.Next(0, 2) != 0
                    };
                }
            }
        }

        public BoardSquareState[,] GetBoard(int playerNo)
        {
            if (playerNo == 0) return CopyOfBoard(_boardA);
            return CopyOfBoard(_boardB);
        }

        private BoardSquareState[,] CopyOfBoard(BoardSquareState[,] board)
        {
            var res = new BoardSquareState[board.GetLength(0),board.GetLength(1)];
            
            for (var x = 0; x < board.GetLength(0); x++)
            {
                for (var y = 0; y < board.GetLength(1); y++)
                {
                    res[x, y] = board[x, y];
                }
            }

            return res;
        }

    }
}