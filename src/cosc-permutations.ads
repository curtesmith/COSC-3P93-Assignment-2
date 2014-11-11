with Ada.Containers.Vectors;

package COSC.Permutations is
   subtype Nums_List_Type is Positive;

   package Nums_List is new Ada.Containers.Vectors
     (Element_Type => Integer,
      Index_Type => Nums_List_Type);

   type Int_Nums is array (Positive range <>) of Integer;

   function Is_Odd(I : Integer) return Boolean;
   function Swap (A : in out Int_Nums; Source, Destination : Integer) return Int_Nums;
   procedure Build(Index : Integer; Current_Permutation : in out Int_Nums; List_of_permutations : in out Nums_List.Vector);
   function Translate(From : in Integer) return Integer;
end COSC.Permutations;
