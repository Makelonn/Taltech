namespace BattleShipBrain
{
    public struct BoardSquareState
    {
        public bool IsShip { get; set; }
        public bool IsBomb { get; set; }

        public override string ToString()
        {
            switch (IsEmpty: IsShip, IsBomb)
            {
                case (false, false): //is empty
                    return " ";
                case (false, true): //is bombeb but "à l'eau"
                    return "-";
                case (true, false): //is a ship but not bombed
                    return "8";
                case (true, true): //bombed ship
                    return " *";
            }
        }
    }
    
    
}