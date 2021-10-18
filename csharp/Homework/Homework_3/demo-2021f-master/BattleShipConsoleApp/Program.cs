using System;
using System.Text.Json;
using BattleShipBrain;
using BattleShipConsoleUI;

namespace BattleShipConsoleApp
{
    class Program
    {
        private static string? _basePath;

        static void Main(string[] args)
        {
            //Entering the program
            Console.WriteLine("Hello Battleship!");
            _basePath = args.Length == 1 ? args[0] : System.IO.Directory.GetCurrentDirectory();
            Console.WriteLine($"Base path: {_basePath}");

            var conf = new GameConfig();

            var jsonOptions = new JsonSerializerOptions()
            {
                WriteIndented = true
            };
            var fileNameStandardConfig = _basePath + System.IO.Path.DirectorySeparatorChar + "Configs" + System.IO.Path.DirectorySeparatorChar + "standard.json";

            var confJsonStr = JsonSerializer.Serialize(conf, jsonOptions);

            Console.WriteLine("Standard conf is in: " + fileNameStandardConfig);
            if (!System.IO.File.Exists(fileNameStandardConfig))
            {
                Console.WriteLine("Saving default config!");
                System.IO.File.WriteAllText(fileNameStandardConfig, confJsonStr);
            }

            if (System.IO.File.Exists(fileNameStandardConfig))
            {
                Console.WriteLine("Loading config...");
                var confText = System.IO.File.ReadAllText(fileNameStandardConfig);
                conf = JsonSerializer.Deserialize<GameConfig>(confText);
                Console.WriteLine("Loading completed !");
                //Console.WriteLine(conf);//Print loaded config
            }
            
            var brain = new BSBrain(conf!);
            //Save
            var fileNameSave = _basePath + System.IO.Path.DirectorySeparatorChar + "SaveGames" + System.IO.Path.DirectorySeparatorChar + "game.json";
            

            BSConsoleUI.DrawBothBoard(brain.GetBoard(0),brain.GetBoard(1));
            //Console.WriteLine(brain.GetBrainJson()); 

            /*
            var brain = new BSBrain(new GameConfig());
            
            BSConsoleUI.DrawBoard(brain.GetBoard(0));
            
            var b = brain.GetBoard(0);
            
            b[0, 0].IsBomb = true;
            b[0, 0].IsShip = false;
            
            
            Console.WriteLine("+---+---+--------------");
            Console.WriteLine("| x | * |");
            Console.WriteLine("+---+---+---------------");
            Console.WriteLine("----------------------");

            BSConsoleUI.DrawBoard(brain.GetBoard(0));
            */
        }
    }
}