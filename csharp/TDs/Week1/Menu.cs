using System;
using System.Collections.Generic;

namespace MenuSystem
{
    public class Menu
    {
        private readonly EMenuLevel _menuLevel;        
        public List<MenuItem> MenuItems { get; set; } = new List<MenuItem>();
        private MenuItem MenuItemExit =  new MenuItem("E", "Exit");
        private MenuItem MenuItemMain= new MenuItem("M", "Main");
        private MenuItem MenuItemReturn= new MenuItem("R", "Return");

        public Menu(EMenuLevel menuLevel)
        {  
            _menuLevel = menuLevel;
        }

        public void AddMenuItem(MenuItem item, int position=-1)
        {
            if (position == -1)
            {
                _menuItems.Add(item);
            }
            else
            {
                _menuItems.Insert(position, item);
            }
        }

        public void DeleteMenuItem(int position = 0)
        {
            _menuItems.RemoveAt(position);
        }

        public void AddMenuItems(List<MenuItem> items)
        {
            foreach (var MenuItem in items)
            {
                //Aled
            }
        }
        public string Run()
        {
            OutputMenu();
            Console.WriteLine("Your choice :");
            return "";
        }

        private void OutputMenu()
        {
            foreach (var t in MenuItems)
            {
                Console.WriteLine(t);
            }

            Console.WriteLine("-------------------");
            switch(_menuLevel)
            {
                case EMenuLevel.Root :
                    Console.WriteLine(MenuItemExit);
                    break;
                case EMenuLevel.First :
                    Console.WriteLine(MenuItemExit);
                    Console.WriteLine(MenuItemReturn);
                    break;
                case EMenuLevel.SecondOrMore :
                    Console.WriteLine(MenuItemExit);
                    Console.WriteLine(MenuItemReturn);
                    Console.WriteLine(MenuItemMain);
                    break;
            }
        }
    }
}
