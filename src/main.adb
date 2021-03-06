with Ada.Text_IO;
with COSC.Processors;
with COSC.Utilities;
with COSC.Permutations;
with COSC.Machines;
with COSC.Random;
with COSC.Semaphores;

procedure Main is
   Nodes : COSC.Processors.Nodes.Map;
   Factorial_numbers : COSC.Permutations.Int_Nums := (5,4,3,2,1);
   IDs : COSC.Permutations.Nums_List.Vector;
   First, Second : Integer := 0;
   Done_access : COSC.Semaphores.SEMAPHORE_access := new COSC.Semaphores.SEMAPHORE (INITVALUE => -1);
begin
   COSC.Permutations.Build(Factorial_numbers'Length, Factorial_numbers, IDs);

   --setup the machine
   COSC.Machines.Generate(Nodes, IDs);
   COSC.Utilities.Make_Connections(Nodes, Factorial_numbers'Length);

   --RESET the machine
   First := IDs(COSC.Random.Positive_Integer(Integer(IDs.Length)));
   Second := COSC.Permutations.Translate(First);

   --report the results
   COSC.Write(" PNO    #ACKs");

   Nodes(First).Ptask.RESET(Nodes(First), -1, DONE_access);
   Nodes(Second).Ptask.RESET(Nodes(Second), -1, DONE_access);

   DONE_access.WAIT;

   COSC.Write("The star machine has been reset");
end Main;
