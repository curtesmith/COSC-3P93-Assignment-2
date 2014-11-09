with COSC.Permutations;
with COSC.Processors;

package COSC.Machines is
   procedure Generate (Nodes_Map : in out COSC.Processors.Nodes.Map; List_of_IDs : in COSC.Permutations.Nums_List.Vector);
   procedure Connect(Node1 : COSC.Processors.Node_access; Node2 : COSC.Processors.Node_access);
end COSC.Machines;
