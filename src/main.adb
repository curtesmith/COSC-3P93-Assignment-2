with Ada.Text_IO;
with COSC.Processors;
with COSC.Utilities;
with COSC.Permutations;
with COSC.Machines;
with COSC.Random;
with COSC.Semaphores;

procedure Main is
   Nodes : COSC.Processors.Nodes.Map;
   Factorial : Integer := 5;
   Factorial_numbers : COSC.Permutations.Int_Nums := (1,2,3,4,5);
   IDs : COSC.Permutations.Nums_List.Vector;
   First, Second : Integer := 0;
begin
   COSC.Permutations.Build(Factorial, Factorial_numbers, IDs);

   --setup the machine
   COSC.Machines.Generate(Nodes, IDs);
   COSC.Utilities.Make_Connections(Nodes, Factorial);

   --start the machine
   First := IDs(COSC.Random.Positive_Integer(Integer(IDs.Length)));
   while (First /= Second) loop
      Second := IDs(COSC.Random.Positive_Integer(Integer(IDs.Length)));
   end loop;

   Nodes(First).Ptask.RESET(Nodes(First), 0);
   Nodes(First).Ptask.ACK(Nodes(First));

   --report the results
   Ada.Text_IO.Put_Line(" PNO    #ACKs");
   for Node of Nodes loop
      Ada.Text_IO.Put_Line(Integer'Image(Node.ID) & "   " & Integer'Image(Node.ACKs));
   end loop;

   Ada.Text_IO.Put_Line("The star machine has been reset");
end Main;
