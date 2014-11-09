with Ada.Text_IO;
with COSC.Processors;
with COSC.Utilities;
with COSC.Permutations;
with COSC.Machines;
with COSC.Random;
with COSC.Semaphores;

procedure Main is
   Nodes : COSC.Processors.Nodes.Map;
   Factorial : Integer := 2;
   Factorial_numbers : COSC.Permutations.Int_Nums := (1,2);
   IDs : COSC.Permutations.Nums_List.Vector;
   First, Second : Integer := 0;
   DONE : COSC.Semaphores.SEMAPHORE (INITVALUE => 0);
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
   COSC.Write("MAIN: Calling Reset on " & Integer'Image(First));
   Nodes(First).Ptask.RESET(Nodes(First), -1);
   --COSC.Write("MAIN: Calling ACK on " & Integer'Image(First));
   --Nodes(First).Ptask.ACK;

   --DONE.WAIT; --wait for the First node to be done
   delay 5.0;
   --report the results
   Ada.Text_IO.Put_Line(" PNO    #ACKs");
   for Node of Nodes loop
      Ada.Text_IO.Put_Line(Integer'Image(Node.ID) & "   " & Integer'Image(Node.ACKs));
   end loop;

   Ada.Text_IO.Put_Line("The star machine has been reset");
end Main;
