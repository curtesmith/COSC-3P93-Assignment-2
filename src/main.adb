with Ada.Text_IO;
with COSC.Processors;
with COSC.Utilities;
with COSC.Permutations;
with COSC.Machines;
with COSC.Random;
with COSC.Semaphores;

procedure Main is
   Nodes : COSC.Processors.Nodes.Map;
   Factorial_numbers : COSC.Permutations.Int_Nums := (3,2,1);
   IDs : COSC.Permutations.Nums_List.Vector;
   First, Second : Integer := 0;
   --DONE : COSC.Semaphores.SEMAPHORE (INITVALUE => -1);
   Done_access : COSC.Semaphores.SEMAPHORE_access := new COSC.Semaphores.SEMAPHORE (INITVALUE => -1);
begin
   COSC.Permutations.Build(Factorial_numbers'Length, Factorial_numbers, IDs);

   --setup the machine
   COSC.Machines.Generate(Nodes, IDs);
   COSC.Utilities.Make_Connections(Nodes, Factorial_numbers'Length);

   --RESET the machine
   First := IDs(COSC.Random.Positive_Integer(Integer(IDs.Length)));
   Second := First;
   while (First = Second) loop
      Second := IDs(COSC.Random.Positive_Integer(Integer(IDs.Length)));
   end loop;

   COSC.Write("MAIN: Calling Reset on " & COSC.To_String(First));
   Nodes(First).Ptask.RESET(Nodes(First), -1, DONE_access);
   COSC.Write("MAIN: Calling Reset on " & COSC.To_String(Second));
   Nodes(Second).Ptask.RESET(Nodes(Second), -1, DONE_access);

   DONE_access.WAIT;

   --report the results
   Ada.Text_IO.Put_Line(" PNO    #ACKs");
   for Node of Nodes loop
      Ada.Text_IO.Put_Line(Integer'Image(Node.ID) & "   " & Integer'Image(Node.ACKs));
   end loop;

   Ada.Text_IO.Put_Line("The star machine has been reset");
end Main;
