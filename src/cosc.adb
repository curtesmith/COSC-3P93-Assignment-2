with Ada.Text_IO;

package body COSC is
   procedure Write(Message : String) is
   begin
      Ada.Text_IO.Put_Line(Message);
   end Write;

   function To_String(Value : Integer) return String is
   begin

      return Integer'Image(Value);
   end To_String;

end COSC;
