package COSC.Random is
   function Get_Default_Seed return Integer;
   function Unif (seed1, seed2, seed3 : in Integer := Get_Default_Seed) return Float;
   function Positive_Integer (Ceiling : Integer) return Integer;
end COSC.Random;
