package COSC.Semaphores is


   task type SEMAPHORE (INITVALUE : Integer := -1) is
   	entry WAIT;
   	entry SIGNAL;
   end SEMAPHORE;

   type SEMAPHORE_access is access SEMAPHORE;
end COSC.Semaphores;
