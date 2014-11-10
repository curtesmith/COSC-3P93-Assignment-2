package body COSC.Semaphores is
   task body SEMAPHORE is
      COUNT : Integer := INITVALUE;
   begin
      loop
         select
            accept SIGNAL;
            COUNT := COUNT + 1;
         or when COUNT > 0 => accept WAIT;
               COUNT := COUNT -1;
         or
              terminate;
         end select;
      end loop;
   end SEMAPHORE;

end COSC.Semaphores;
