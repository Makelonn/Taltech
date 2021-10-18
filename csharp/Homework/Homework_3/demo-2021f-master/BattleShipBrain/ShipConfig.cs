namespace BattleShipBrain
{
    public class ShipConfig
    {
        public string? Name { get; set; } //should I let it nullable when its the name ???

        public int Quantity { get; set; }
        
        public int ShipSizeY { get; set; } 
        public int ShipSizeX { get; set; }
    }
    
}