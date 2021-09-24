using System;
using System.Collections.Generic;
using System.ComponentModel.Design;
using MenuSystem;

namespace ConsoleApp
{
    class Program
    {
        private static double CalculatorCurrentValue = 0.0;
        
        static void Main(string[] args)
        {
            Console.Clear();


            var mainMenu = new Menu("Calculator Main", EMenuLevel.Root);
            mainMenu.AddMenuItems(new List<MenuItem>()
            {
                new MenuItem("A", "Binary operations", SubmenuBinary),
                new MenuItem("S", "Unary operations", SubmenuUnary),
                new MenuItem("Del", "Reset value", ResetCurrentValue),
            });
            
            mainMenu.Run();
        }

        public static string ResetCurrentValue()
        {
            CalculatorCurrentValue = 0.0;
            Console.Clear();
            Console.WriteLine("====> Value reset to 0.0 <====");
            return "";
        }

        //-----BINARY OPERATIONS-----
        public static string Add()
        {
            // CalculatorCurrentValue
            Console.Write("[Enter number] " + CalculatorCurrentValue + " + ");
            var n = Console.ReadLine()?.Trim();
            double.TryParse(n, out var converted);
            CalculatorCurrentValue = CalculatorCurrentValue + converted;
            Console.Clear();
            Console.WriteLine("====> Value " + CalculatorCurrentValue + " <====");
            return "";
        }

        public static string Sub()
        {
            Console.Write("[Enter number] " + CalculatorCurrentValue + " - ");
            var n = Console.ReadLine()?.Trim();
            double.TryParse(n, out var converted);
            CalculatorCurrentValue = CalculatorCurrentValue - converted;
            Console.Clear();
            Console.WriteLine("====> Value " + CalculatorCurrentValue + " <====");
            return "";
        }

        public static string Divide()
        {
            Console.Write("[Enter number] " + CalculatorCurrentValue + " / ");
            var n = Console.ReadLine()?.Trim();
            double.TryParse(n, out var converted);
            CalculatorCurrentValue = CalculatorCurrentValue / converted;
            Console.Clear();
            Console.WriteLine("====> Value " + CalculatorCurrentValue + " <====");
            return "";
        }

        public static string Multiply()
        {
            Console.Write("[Enter number] " + CalculatorCurrentValue + " * ");
            var n = Console.ReadLine()?.Trim();
            double.TryParse(n, out var converted);

            CalculatorCurrentValue = CalculatorCurrentValue * converted;
            Console.Clear();
            Console.WriteLine("====> Value " + CalculatorCurrentValue + " <====");
            return "";
        }

        public static string Power()
        {
            Console.Write("[Enter number] " + CalculatorCurrentValue + " ^ ");
            var n = Console.ReadLine()?.Trim();
            double.TryParse(n, out var converted);

            CalculatorCurrentValue = Math.Pow(CalculatorCurrentValue,converted);
            Console.Clear();
            Console.WriteLine("====> Value " + CalculatorCurrentValue + " <====");
            return "";
        }

        public static string Root()
        {
            Console.Write("[Enter number] " + CalculatorCurrentValue + " root Nth : ");
            var n = Console.ReadLine()?.Trim();
            double.TryParse(n, out var converted);

            CalculatorCurrentValue = Math.Pow(CalculatorCurrentValue,1/converted);
            Console.Clear();
            Console.WriteLine("====> Value " + CalculatorCurrentValue + " <====");
            return "";
        }

        public static string SubmenuBinary()
        {
            var menu = new Menu("Binary", EMenuLevel.First);
            menu.AddMenuItems(new List<MenuItem>()
            {
                new MenuItem("+", "+", Add),
                new MenuItem("-", "-", Sub),
                new MenuItem("/", "/", Divide),
                new MenuItem("*", "*", Multiply),
                new MenuItem("P", "Pow", Power),
                new MenuItem("V", "Root", Root),
                new MenuItem("Del", "Reset value", ResetCurrentValue),

            });
            var res = menu.Run();
            return res;
        }
        //----------UNARY OPERATION----------
        public static string Negate()
        {
            CalculatorCurrentValue = -CalculatorCurrentValue;
            Console.Clear();
            Console.WriteLine("====> Value " + CalculatorCurrentValue + " <====");
            return "";
        }

        public static string Squareroot()
        {
            CalculatorCurrentValue = Math.Sqrt(CalculatorCurrentValue);
            Console.Clear();
            Console.WriteLine("====> Value " + CalculatorCurrentValue + " <====");
            return "";
        }

        public static string Square()
        {
            CalculatorCurrentValue = Math.Pow(CalculatorCurrentValue,2);
            Console.Clear();
            Console.WriteLine("====> Value " + CalculatorCurrentValue + " <====");
            return "";
        }

        public static string Inc()
        {
            CalculatorCurrentValue++;
            Console.Clear();
            Console.WriteLine("====> Value " + CalculatorCurrentValue + " <====");
            return "";
        }

        public static string Dec()
        {
            CalculatorCurrentValue--;
            Console.Clear();
            Console.WriteLine("====> Value " + CalculatorCurrentValue + " <====");
            return "";
        }

        public static string SubmenuUnary()
        {
            var menu = new Menu("Unary", EMenuLevel.First);
            menu.AddMenuItems(new List<MenuItem>()
            {
                new MenuItem("N", "Negate", Negate),
                new MenuItem("Q", "Sqrt", Squareroot),
                new MenuItem("S", "Square", Square),
                new MenuItem("++", "Increment", Inc),
                new MenuItem("--", "Decrement", Dec),
                new MenuItem("Del", "Reset value", ResetCurrentValue),
            });
            var res = menu.Run();
            return res;
        }
    }
}