using System;

namespace MenuSystem
{
    public class MenuItem 
    {
        public MenuItem(string shortCut, string title)
        {
            if (string.IsNullOrEmpty(shortCut))
            {
                throw new ArgumentException("shortCut cannot be empty!");
            }
            if (string.IsNullOrEmpty(title))
            {
                throw new ArgumentException("title cannot be empty!");
            }
            
            ShortCut = shortCut.Trim();
            Title = title.Trim();
        }
        public string Title { get; private set; }
        public string ShortCut { get; private set; }

        public override string ToString()
        {
            return ShortCut + ") " + Title;
        }
    }
}
