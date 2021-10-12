using System;
using System.Collections.Generic;
using System.Text.Json;

namespace BattleShipBrain
{
    public class BSBrain
    {
        private int _currentPlayerNo = 0;
        private GameBoard[] GameBoards = new GameBoard[2];

        private readonly Random _rnd = new Random();

        public BSBrain(GameConfig config)
        {
            GameBoards[0] = new GameBoard();
            GameBoards[1] = new GameBoard();
            
            GameBoards[0].Board = new BoardSquareState[config.BoardSizeX, config.BoardSizeY];
            GameBoards[1].Board = new BoardSquareState[config.BoardSizeX, config.BoardSizeY];

            for (var x = 0; x < config.BoardSizeX; x++)
            {
                for (var y = 0; y < config.BoardSizeY; y++)
                {
                    GameBoards[0].Board[x, y] = new BoardSquareState
                    {
                        IsBomb = _rnd.Next(0, 2) != 0,
                        IsShip = _rnd.Next(0, 2) != 0
                    };
                }
            }
        }

        public BoardSquareState[,] GetBoard(int playerNo)
        {
            return CopyOfBoard(GameBoards[playerNo].Board);
        }

        private BoardSquareState[,] CopyOfBoard(BoardSquareState[,] board)
        {
            var res = new BoardSquareState[board.GetLength(0), board.GetLength(1)];

            for (var x = 0; x < board.GetLength(0); x++)
            {
                for (var y = 0; y < board.GetLength(1); y++)
                {
                    res[x, y] = board[x, y];
                }
            }

            return res;
        }

        public string GetBrainJson()
        {
            var jsonOptions = new JsonSerializerOptions()
            {
                WriteIndented = true
            };

            var dto = new SaveGameDTO();
            var jsonStr = JsonSerializer.Serialize(dto, jsonOptions);
            return jsonStr;
        }


        public void RestoreBrainFromJson(string json)
        {
        }
    }
}