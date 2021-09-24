using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using MenuSystem;

namespace ConsoleApp
{
    class Program
    {
        private static double CalculatorCurrentDisplay = 0.0;
        
        static void Main(string[] args)
        {
            Console.Clear();


            var mainMenu = new Menu("Calculator Main", EMenuLevel.Root);
            mainMenu.AddMenuItems(new List<MenuItem>()
            {
                new MenuItem("A", "Binary operations", SubmenuBinary),
                new MenuItem("S", "Unary operations", SubmenuUnary),
            });
            
            mainMenu.Run();
        }

        public static string MethodA()
        {
            Console.WriteLine("Method A!!!!!");
            return "";
        }

        public static string SubmenuBinary()
        {
            var menu = new Menu("Binary", EMenuLevel.First);
            menu.AddMenuItems(new List<MenuItem>()
            {
                new MenuItem("+", "+", Add),
                new MenuItem("-", "-", MethodA),
                new MenuItem("/", "/", MethodA),
                new MenuItem("*", "*", MethodA),

            });
            var res = menu.Run();
            return res;
        }

        public static string Add()
        {
            // CalculatorCurrentDisplay
            Console.WriteLine("Current value: " + CalculatorCurrentDisplay);
            Console.WriteLine("plus");
            Console.Write("number: ");
            var n = Console.ReadLine()?.Trim();
            double.TryParse(n, out var converted);

            CalculatorCurrentDisplay = CalculatorCurrentDisplay + converted;
            
            return "";
        }

        public static string SubmenuUnary()
        {
            var menu = new Menu("Unary", EMenuLevel.First);
            menu.AddMenuItems(new List<MenuItem>()
            {
                new MenuItem("Negate", "Negate", MethodA),
                new MenuItem("Sqrt", "Sqrt", MethodA),
                new MenuItem("Root", "Root", MethodA),
            });
            var res = menu.Run();
            return res;
        }
    }
}