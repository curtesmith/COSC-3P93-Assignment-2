with Ada.Containers.Ordered_Maps;


package COSC.Processors is
   type Node;
   type Node_access is access all Node;

   type Node_Task;
   type Node_Task_access is access Node_Task;

   subtype Node_IDs is Positive;

   package Nodes is new Ada.Containers.Ordered_Maps
     ( Key_Type     => Node_IDs,
       Element_Type => Node_access);

   type Node is
      record
         ID : Integer;
         State : Integer;
         Ptask : Node_Task_access;
         Neighbours : Nodes.Map;
         ACKs : Integer;
      end record;

   task type Node_Task is
      entry RESET (Self: Node_access; Caller : Integer);
      entry ACK (Self : Node_access);
   end Node_Task;
end COSC.Processors;
