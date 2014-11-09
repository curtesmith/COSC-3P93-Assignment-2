package body COSC.Processors is
   task body Node_Task is
      Reset_called : Boolean := False;
      Me : Node_access;
      Caller_ID : Integer;
   begin
      loop
         select
            accept RESET(Self : Node_access; Caller : Integer) do
               Reset_called := True;
               Me := Self;
               Caller_ID := Caller;
               Me.State := 1; -- 'Resetting' state
            end RESET;

            for Node of Me.Neighbours loop
               if (Node.ID /= Caller_ID and Node.State = 0) then
                  Node.Ptask.RESET(Node, Me.ID);
                  Node.Ptask.ACK(Node);
                  Me.ACKs := Me.ACKs + 1;
               end if;
            end loop;

            Me.State := 2; -- 'Reset completed' state

         or when Reset_called => accept ACK(Self : Node_access) do
               Reset_called := False;
               Self.State := 3; -- 'Acknowledged' state
            end ACK;
         or
            terminate;
         end select;
      end loop;
   end Node_Task;

end COSC.Processors;
