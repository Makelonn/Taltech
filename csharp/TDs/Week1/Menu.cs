using System.Collections.Generic;

namespace MenuSystem
{
    public class Menu{
        public List<MenuItem> MenuItems {get; set;} = new List<MenuItem>();

        public string Run()
        {
            OutputMenu();
            return "";
        } 

        private void OutputMenu();
        {
            foreach(var menuItem in MenuItems)
            {
                Console.WriteLine(menuItem.ToString());
            }
        }
    }
}