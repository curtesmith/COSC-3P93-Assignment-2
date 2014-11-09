package COSC.Semaphores is
   task type SEMAPHORE (INITVALUE : Integer := -1) is
   	entry WAIT;
   	entry SIGNAL;
   end SEMAPHORE;
end COSC.Semaphores;
