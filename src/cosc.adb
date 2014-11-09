with Ada.Text_IO;

package body COSC is
   procedure Write(Message : String) is
   begin
      Ada.Text_IO.Put_Line(Message);
   end Write;
end COSC;
