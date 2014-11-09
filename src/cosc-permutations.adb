

package body COSC.Permutations is

   function Is_Odd(I : Integer) return Boolean is
   begin
      return ((I Mod 2) > 0);
   end Is_Odd;


   function Swap (A : in out Int_Nums; Source, Destination : Integer) return Int_Nums is
      Temp : Integer := -1;
   begin
      Temp := A(Destination);
      A(Destination) := A(Source);
      A(Source) := Temp;
      return A;
   end Swap;

   procedure Add_to_list (Item : in Int_Nums; List : in out Nums_List.Vector) is
   begin
      declare
         Result : String(Item'First..Item'Last);
         To_String : String (1..2);
      begin
         for I in Item'First..Item'Last loop
            To_String := Integer'Image(Item(I));
            Result(I) := To_String(2);
         end loop;
         List.Append(Integer'Value(Result));
      end;
   end Add_to_list;


   procedure Build (Index : Integer; Current_Permutation : in out Int_Nums; List_of_permutations : in out Nums_List.Vector) is
      X : Integer := -1;
   begin
      if (Index = 1) then
         Add_to_list(Current_Permutation, List_of_permutations);
      else
         for I in Integer range 1..Index loop
            Build(Index-1, Current_Permutation, List_of_permutations);
            if (Is_Odd(Index)) then
               X := 1;
            else
               X := I;
            end if;
            Current_Permutation := Swap(Current_Permutation, X, Index);
            end loop;
      end if;
   end Build;


end COSC.Permutations;
