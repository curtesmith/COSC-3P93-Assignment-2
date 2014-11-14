with COSC.Semaphores;

use COSC.Semaphores;

package body COSC.Processors is

   task body Node_Task is
      State, Caller_ID, Expected_ACKs, Number_Of_RESETs : Integer := 0;
      Me, Callback_Node, Second_callback_node : Node_access := null;
      Are_we_done, Second_done : COSC.Semaphores.SEMAPHORE_access := null;
   begin
      loop
         select
            accept RESET(Self : Node_access; Caller : Integer; Done : COSC.Semaphores.SEMAPHORE_access) do
               if (Number_Of_RESETs = 0) then
                  Me := Self;
                  Caller_ID := Caller;
                  Me.State := 1; -- Reset in progress
                  State := Me.State;
                  Are_we_done := Done;
               else
                  Second_done := Done;
                  for Node of Me.Neighbours loop
                     if (Node.ID = Caller) then
                        Second_callback_node := Node;
                     end if;
                  end loop;

               end if;

               Number_Of_RESETs := Number_Of_RESETs + 1;

            end RESET;

            if (Number_Of_RESETs = 1) then
               for Node of Me.Neighbours loop
                  if (Node.ID = Caller_ID) then
                     Callback_Node := Node;
                  end if;

                  if (Node.State = 0 and Node.ID /= Caller_ID) then
                     Node.Ptask.RESET(Node, Me.ID, null);
                     Expected_ACKs := Expected_ACKs + 1;
                  end if;
               end loop;

               if (Expected_ACKs = 0) then
                  COSC.Write(COSC.To_String(Me.ID) & "   " & COSC.To_String(Me.ACKs));

                  if (Caller_ID /= -1) then
                     Callback_Node.Ptask.ACK;
                  elsif (Are_we_done /= null) then
                     Are_we_done.SIGNAL;
                  end if;
               end if;

            elsif (Number_Of_RESETs > 1) then
               if (Second_done /= null) then
                  Second_done.SIGNAL;
               end if;
               if (Second_callback_node /= null) then
                  Second_callback_node.Ptask.ACK;
               end if;

            end if;

         or accept ACK do
               Me.ACKs := Me.ACKs + 1;
            end ACK;

            if (Me.ACKs = Expected_ACKs) then
               COSC.Write(COSC.To_String(Me.ID) & "   " & COSC.To_String(Me.ACKs));
               if(Are_we_done /= null) then
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
