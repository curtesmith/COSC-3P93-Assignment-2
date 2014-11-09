package body COSC.Processors is

   task body Node_Task is
      Reset_called : Boolean := False;
      Me : Node_access;
      ID : Integer := 0;
      Caller_ID : Integer;
      Caller : Node_access;
      Expected_ACKs : Integer := 0;
   begin
      loop
         COSC.Write("NODE#" & Integer'Image(ID) & ": task loop entered");
         select
            when Reset_called /= True => accept RESET(Self : Node_access; Caller : Integer) do
                 Me := Self;
                 ID := Me.ID;
                 COSC.Write("NODE#" & Integer'Image(ID) & ": RESET called");
                 Reset_called := True;
                 Caller_ID := Caller;
               Me.State := 1; -- 'Resetting' state
            end RESET;

            COSC.Write("NODE#" & Integer'Image(ID) & ": RESET block ended" & Integer'Image(Me.ID));

            for Node of Me.Neighbours loop
               if (Node.ID /= Caller_ID and Node.State = 0) then
                  Caller := Node;
                  COSC.Write("NODE#" & Integer'Image(ID) & ": RESET calling RESET of child node " & Integer'Image(Node.ID));
                  Node.Ptask.RESET(Node, Me.ID);
                  COSC.Write("NODE#" & Integer'Image(ID) & ": RESET control returned from call to RESET of child node " & Integer'Image(Node.ID));
                  Expected_ACKs := Expected_ACKs + 1;
               end if;
            end loop;

            Me.State := 2; -- 'Reset completed' state

         or accept ACK do
               COSC.Write("NODE#ACK called");
            end ACK;
            --Me.ACKs := Me.ACKs + 1;
         or
            terminate;
         end select;

         COSC.Write("NODE#" & Integer'Image(ID) & ": calling delay 5.0");
         delay 5.0;
         COSC.Write("NODE#" & Integer'Image(ID) & ": completed delay 5.0");

         if (Expected_ACKs = Me.ACKs) then
            COSC.Write("NODE#" & Integer'Image(ID) & ": Expected [" & Integer'Image(Expected_ACKs) & "], Actual ["
                         & Integer'Image(Me.ACKs) & "] RESET is calling the ACK of the caller, ID="
                       & Integer'Image(Caller_ID));
            Caller.Ptask.ACK;
            COSC.Write("NODE#" & Integer'Image(ID) & ": RESET returned from ACK call to  " & Integer'Image(Caller_ID));
         end if;

         COSC.Write("NODE#" & Integer'Image(ID) & ": task loop ended");
      end loop;
   end Node_Task;

end COSC.Processors;
