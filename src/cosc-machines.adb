with COSC.Processors;
use COSC.Processors;

package body COSC.Machines is
   procedure Generate (Nodes_Map : in out Nodes.Map; List_of_IDs : in Permutations.Nums_List.Vector) is
      Empty : Nodes.Map;
   begin
      for Item of List_of_IDs loop
         Nodes_Map.Insert(Key      => Item,
                  New_Item => new Node'(ID => Item,
                                             State => 0,
                                             PTask => new Node_Task,
                                             Neighbours => Empty,
                                             ACKs => 0));
      end loop;

   end Generate;


   procedure Connect(Node1 : Node_access; Node2 : Node_access) is
   begin
      Node1.Neighbours.Insert(Key      => Node2.ID,
                          New_Item => Node2);
      Node2.Neighbours.Insert(Key      => Node1.ID,
                          New_Item => Node1);
   end Connect;
end COSC.Machines;
