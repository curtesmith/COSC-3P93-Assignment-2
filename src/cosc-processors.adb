package body COSC.Processors is

   task body Node_Task is
      State, Caller_ID, Expected_ACKs : Integer := 0;
      Me, Callback_Node : Node_access := null;
   begin
      loop
         select
            when State = 0 =>
               accept RESET(Self : Node_access; Caller : Integer) do
                  Me := Self;
                  Caller_ID := Caller;
                  Me.State := 1; -- Reset in progress
               end RESET;

               COSC.Write("NODE#" & COSC.To_String(Me.ID) & ": RESET called");

               for Node of Me.Neighbours loop
                  if (Node.ID = Caller_ID) then
                     Callback_Node := Node;
                  end if;

                  if (Node.State = 0 and Node.ID /= Caller_ID) then
                     Node.Ptask.RESET(Node, Me.ID);
                     Expected_ACKs := Expected_ACKs + 1;
                  end if;
               end loop;

               if (Expected_ACKs = 0 and Caller_ID /= -1) then
                  COSC.Write("NODE#" & COSC.To_String(Me.ID) & ": I'm going to ack "
                             & COSC.To_String(Caller_ID) & " back");
                  Callback_Node.Ptask.ACK;
                  COSC.Write("NODE#" & COSC.To_String(Me.ID) & ": " & COSC.To_String(Caller_ID)
                             & " got acked");
               end if;

         or accept ACK do
               COSC.Write("NODE#" & COSC.To_String(Me.ID) & ": ACK called");
               Me.ACKs := Me.ACKs + 1;
            end ACK;

            if (Me.ACKs = Expected_ACKs) then
               COSC.Write("Node#" & COSC.To_String(Me.ID) & ": ACK needs to Callback#" & COSC.To_String(Callback_Node.ID));
               Callback_Node.Ptask.ACK;
               COSC.Write("Node#" & COSC.To_String(Me.ID) & ": ACK Callback done to #" & COSC.To_String(Callback_Node.ID));
            end if;

         or
            terminate;
         end select;
      end loop;
   end Node_Task;

end COSC.Processors;
