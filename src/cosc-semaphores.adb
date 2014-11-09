package body COSC.Semaphores is
   task body SEMAPHORE is
      COUNT : Integer := INITVALUE;
   begin
      loop
         select
            accept SIGNAL;
            accept WAIT;
         end select;
      end loop;
   end SEMAPHORE;

end COSC.Semaphores;
