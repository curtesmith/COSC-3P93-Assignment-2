with COSC.Semaphores;

use COSC.Semaphores;

package body COSC.Processors is

   task body Node_Task is
      State, Caller_ID, Expected_ACKs : Integer := 0;
      Me, Callback_Node : Node_access := null;
      Are_we_done : COSC.Semaphores.SEMAPHORE_access := null;
   begin
      loop
         select
            accept RESET(Self : Node_access; Caller : Integer; Done : COSC.Semaphores.SEMAPHORE_access) do
               Me := Self;
               Caller_ID := Caller;
               Me.State := 1; -- Reset in progress
               State := Me.State;
               Are_we_done := Done;
            end RESET;

            for Node of Me.Neighbours loop
               if (Node.ID = Caller_ID) then
                  Callback_Node := Node;
               end if;

               if (Node.State = 0 and Node.ID /= Caller_ID) then
                  Node.Ptask.RESET(Node, Me.ID, null);
                  Expected_ACKs := Expected_ACKs + 1;
               end if;
            end loop;

            if (Expected_ACKs = 0 and Caller_ID /= -1) then
               Callback_Node.Ptask.ACK;
            elsif (Expected_ACKs = 0 and Are_we_done /= null) then
               COSC.Write("Node#" & COSC.To_String(Me.ID) & " signal no acks");
               Are_we_done.SIGNAL;
            end if;

         or accept ACK do
               Me.ACKs := Me.ACKs + 1;
            end ACK;

            if (Me.ACKs = Expected_ACKs) then
               if(Are_we_done /= null) then
                  COSC.Write("Node#" & COSC.To_String(Me.ID) & " signal");
                  Are_we_done.SIGNAL;
               end if;

               Callback_Node.Ptask.ACK;
            end if;

         or
            terminate;
         end select;
      end loop;
   end Node_Task;

end COSC.Processors;
