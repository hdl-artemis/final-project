module read_image_hex_tb;

  // Parameters
  parameter WIDTH = 640;
  parameter HEIGHT = 480;
  parameter INPUT_FILE = "image.hex";
  parameter START_UP_DELAY = 10;
  parameter VALUE = 128;
  parameter THRESHOLD = 200;
  parameter SIGN = 0;

  // Inputs
  reg HCLK;
  reg HRESETn;

  // Outputs
  wire HSYNC;
  wire VSYNC;
  wire [7:0] DATA_R0;
  wire [7:0] DATA_G0;
  wire [7:0] DATA_B0;
  wire [7:0] DATA_R1;
  wire [7:0] DATA_G1;
  wire [7:0] DATA_B1;
  wire ctrl_done;

  // Instantiate the module under test
  read_image_hex dut (
    .WIDTH(WIDTH),
    .HEIGHT(HEIGHT),
    .INPUT_FILE(INPUT_FILE),
    .START_UP_DELAY(START_UP_DELAY),
    .VALUE(VALUE),
    .THRESHOLD(THRESHOLD),
    .SIGN(SIGN),
    .HCLK(HCLK),
    .HRESETn(HRESETn),
    .HSYNC(HSYNC),
    .VSYNC(VSYNC),
    .DATA_R0(DATA_R0),
    .DATA_G0(DATA_G0),
    .DATA_B0(DATA_B0),
    .DATA_R1(DATA_R1),
    .DATA_G1(DATA_G1),
    .DATA_B1(DATA_B1),
    .ctrl_done(ctrl_done)
  );

  // Add testbench code here

endmodule