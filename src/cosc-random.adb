with Ada.Calendar.Conversions;


package body COSC.Random is

   function Unif(seed1, seed2, seed3 : in Integer := Get_Default_Seed) return Float is
      tmp : Float := 0.0;
      x, y, z : Integer;
   begin
      x := seed1;
      y := seed2;
      z := seed3;

      x := 171 * (x mod 177) - 2 * (x / 177);
      if (x < 0) then
         x := x + 30269;
      end if;

      y := 172 * (y mod 176) - 35 * (y / 176);
      if (y < 0) then
         y := y + 30307;
      end if;

      z := 170 * (z mod 178) - 63 * (z / 178);
      if (z < 0) then
         z := z + 30323;
      end if;

      tmp := Float(x) / 30269.0 + Float(y) / 30307.0 + Float(z) / 30323.0;
      return tmp - Float'Truncation(tmp);

   end Unif;


   function Get_Default_Seed return Integer is
   begin
      return Integer(Ada.Calendar.Conversions.To_Unix_Time(Ada.Calendar.Clock));
   end Get_Default_Seed;


   function Positive_Integer (Ceiling : Integer) return Integer is
      Result : Integer := 0;
   begin
      while (Result = 0) loop
         Result := Get_Default_Seed mod Ceiling;
      end loop;
      return Result;
   end Positive_Integer;

end COSC.Random;
