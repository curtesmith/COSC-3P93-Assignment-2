with COSC.Machines;

package body COSC.Utilities is

   procedure Make_Connections(Nodes_Map : in out Cosc.Processors.Nodes.Map; Factorial : Integer) is
      Number_of_connections : Integer := 0;
      ID : String (1..Factorial+1);
      NewID : String (1..Factorial+1);
      First_char : Character;
   begin
      for Node of Nodes_Map loop
         ID := Integer'Image(Node.ID);
         First_char := ID(2);
         for I in 3..Factorial+1 loop
            NewID := ID;
            NewID(2) := ID(I);
            NewID(I) := First_char;
            if (Node.Neighbours.Contains(Integer'Value(NewID)) = False) then
                   COSC.Machines.Connect(Nodes_Map(Node.ID), Nodes_Map(Integer'Value(NewID)));
            end if;
         end loop;
      end loop;

   end Make_Connections;

end COSC.Utilities;
