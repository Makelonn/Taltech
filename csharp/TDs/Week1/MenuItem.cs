using System;

namespace MenuSystem
{
    public class MenuItem
    {
        public MenuItem(string ShortCut, string Title){
            if(ShortCut == null || ShortCut.Length==0)
            {
                throw new ArgumentException(message:"Shortcut can not be empty");
            }
            if(Title == null || Title.Length==0)
            {
                throw new ArgumentException(message:"Title can not be empty");
            }
            ShortCut = ShortCut.Trim();
            Title = Title.Trim();
        }

        public string Title{ get; private set;}
        public string ShortCut {get; private set;}

        public override string ToString()
        {
            return ShortCut + ") " + Title;
        }

        
    }
}
