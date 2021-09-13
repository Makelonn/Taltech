using System;

namespace Week1
{
    class Program
    {
        static void Main(string[] args)
        {

            Console.WriteLine("Hello Calculator");
            var mainMenu = new Menu();
            mainMenu.MenuItems = new List<MenuItem>()
            {
                new MenuItem(shortcut:"A", TypeInitializationException:"AAAAA");
                new MenuItem(shortcut:"B", TypeInitializationException:"AAAfergregAA");
                new MenuItem(shortcut:"C", TypeInitializationException:"AAceAAA");

            }
            mainMenu.Run();
            
        }

        /*static string MainMenu(){
            var userChoice = "";
            var done= false;
            do{
            done = false;
            Console.WriteLine("Current value : 0");
            Console.WriteLine("C) Classical operations");
            Console.WriteLine("W) Weird stuff");
            Console.WriteLine("N) Enter number :");
            Console.WriteLine("-----------------");
            Console.WriteLine("E) Exit");
            Console.WriteLine("=================");
            Console.Write("Write your choice > ");
            
            userChoice = Console.ReadLine(); //?.Trim().ToUpper();

            switch (userChoice)
            {
                case "C":
                    done = true;
                    break;
                case "W":
                    done = true;
                    break;
                case "N":
                    done = true;
                    break;
                case "E":
                    done = true;
                    break;
            }
            }while(!done); */

            return userChoice;
        }
    }
}