module read_image_hex#(
  parameter     
  WIDTH = 509,
  HEIGHT = 512,
  INPUT_FILE  = "./assets/hex/kumalala.hex",
  START_UP_DELAY = 100,
  VALUE = 100, // brightness
  THRESHOLD = 90, //threshold
  SIGN = 1 // 0: brightness subtraction, 1: brightness addition
)
(
  input HCLK, // clock     
  input HRESETn, // reset (active low)
  output VSYNC, // vertical synchronous pulse
 // This signal is often a way to indicate that one entire image is transmitted.
 // Just create and is not used, will be used once a video or many images are transmitted.
  output reg HSYNC, // horizontal synchronous pulse
 // An HSYNC indicates that one line of the image is transmitted.
 // Used to be a horizontal synchronous signals for writing bmp file.
  output reg [7:0]  DATA_R0,  // 8 bit Red data (even)
  output reg [7:0]  DATA_G0,  // 8 bit Green data (even)
  output reg [7:0]  DATA_B0,  // 8 bit Blue data (even)
  output reg [7:0]  DATA_R1,  // 8 bit Red  data (odd)
  output reg [7:0]  DATA_G1,  // 8 bit Green data (odd)
  output reg [7:0]  DATA_B1,  // 8 bit Blue data (odd)
  // Process and transmit 2 pixels in parallel to make the process faster, you can modify to transmit 1 pixels or more if needed
  output ctrl_done // done flag
);  

initial begin
   // read an image hex file
   $display("Reading input image file...");
end
   
endmodule