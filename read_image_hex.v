/**
 * @module read_image_hex
 * @brief This module reads an image from a hex file and processes the image data.
 * 
 * The module takes in a clock signal (HCLK) and a reset signal (HRESETn). It outputs various signals
 * for controlling the image processing. The image data is read from a hex file specified by the INPUT_FILE
 * parameter. The module processes the image data and stores it in temporary storage arrays for further
 * processing.
 * 
 * The module supports various parameters such as WIDTH and HEIGHT for specifying the dimensions of the image,
 * START_UP_DELAY for introducing a delay at startup, VALUE for brightness adjustment, THRESHOLD for thresholding,
 * and SIGN for brightness subtraction or addition.
 * 
 * The module uses different states to control the image processing. It starts processing the image data when
 * the start signal is asserted. The processed image data is stored in temporary storage arrays for further use.
 * 
 * @param WIDTH             Width of the image in pixels.
 * @param HEIGHT            Height of the image in pixels.
 * @param INPUT_FILE        Path to the hex file containing the image data.
 * @param START_UP_DELAY    Delay in clock cycles at startup.
 * @param VALUE             Brightness adjustment value.
 * @param THRESHOLD         Threshold value for thresholding operation.
 * @param SIGN              Brightness subtraction or addition flag.
 * 
 * @input HCLK              Clock signal.
 * @input HRESETn           Reset signal (active low).
 * @output HSYNC            Horizontal synchronous pulse.
 * @output VSYNC            Vertical synchronous pulse.
 * @output DATA_R0          8-bit Red data (even).
 * @output DATA_G0          8-bit Green data (even).
 * @output DATA_B0          8-bit Blue data (even).
 * @output DATA_R1          8-bit Red data (odd).
 * @output DATA_G1          8-bit Green data (odd).
 * @output DATA_B1          8-bit Blue data (odd).
 * @output ctrl_done        Done flag.
 */

`include "parameter.v"

module read_image_hex#(
  parameter
  WIDTH = 509,
  HEIGHT = 512,
  INPUT_FILE  = "./assets/hex/sample.hex",
  START_UP_DELAY = 100,
  VALUE = 100, // brightness
  THRESHOLD = 90, // threshold
  SIGN = 1 // 0: brightness subtraction, 1: brightness addition
)
(
  input HCLK, // clock
  input HRESETn, // reset (active low)
  output reg HSYNC, // horizontal synchronous pulse
  output reg VSYNC, // vertical synchronous pulse
  output reg [7:0]  DATA_R0,  // 8 bit Red data (even)
  output reg [7:0]  DATA_G0,  // 8 bit Green data (even)
  output reg [7:0]  DATA_B0,  // 8 bit Blue data (even)
  output reg [7:0]  DATA_R1,  // 8 bit Red  data (odd)
  output reg [7:0]  DATA_G1,  // 8 bit Green data (odd)
  output reg [7:0]  DATA_B1,  // 8 bit Blue data (odd)
  output ctrl_done // done flag
);  

parameter sizeOfWidth = 8;
parameter sizeOfLengthReal = 1179648; // 781824 bytes: 509 * 512 *3

localparam  ST_IDLE  = 2'b00, // idle state
   ST_VSYNC = 2'b01, // state for creating vsync 
   ST_HSYNC = 2'b10, // state for creating hsync 
   ST_DATA  = 2'b11; // state for data processing 
reg [1:0] cstate, // current state
nstate; // next state   
reg start; // start signal
reg HRESETn_d; // delayed reset signal: used to create start signal
reg ctrl_vsync_run; // control signal for vsync counter  
reg [8:0] ctrl_vsync_cnt; // counter for vsync
reg ctrl_hsync_run; // control signal for hsync counter
reg [8:0] ctrl_hsync_cnt; // counter  for hsync
reg ctrl_data_run; // control signal for data processing
reg [7:0] total_memory [0:sizeOfLengthReal-1]; // memory to store 8-bit data image
integer temp_BMP   [0 : WIDTH * HEIGHT * 3 - 1]; // temporary storage for image data
integer org_R  [0 : WIDTH*HEIGHT - 1];  // temporary storage for R component
integer org_G  [0 : WIDTH*HEIGHT - 1]; // temporary storage for G component
integer org_B  [0 : WIDTH*HEIGHT - 1]; // temporary storage for B component
integer i, j;
integer tempR0,tempR1,tempG0,tempG1,tempB0,tempB1; // temporary variables in contrast and brightness operation

integer value,value1,value2,value4;// temporary variables in invert and threshold operation
reg [9:0] row; // row index of the image
reg [10:0] col; // column index of the image
reg [18:0] data_count; // data counting for entire pixels of the image


initial begin
    $readmemh(INPUT_FILE, total_memory, 0, sizeOfLengthReal - 1); // read file from INPUT_FILE and store it in total_memory
end
// use 3 intermediate signals RGB to save image data
always@(start) begin
    if(start == 1'b1) begin
        for(i = 0; i < WIDTH * HEIGHT * 3 ; i = i + 1) begin
            temp_BMP[i] = total_memory[i + 0][7:0]; 
        end
        
        for(i = 0; i < HEIGHT; i = i + 1) begin
            for(j = 0; j < WIDTH; j = j + 1) begin
                org_R[WIDTH * i + j] = temp_BMP[WIDTH * 3 * (HEIGHT - i - 1)+ 3 * j + 0]; // save Red component
                org_G[WIDTH * i + j] = temp_BMP[WIDTH * 3 * (HEIGHT - i - 1)+ 3 * j + 1]; // save Green component
                org_B[WIDTH * i + j] = temp_BMP[WIDTH * 3 * (HEIGHT - i - 1)+ 3 * j + 2]; // save Blue component
            end
        end
    end
end

///////////////////////// Read image file once reset was high //////////////////////////
always@(posedge HCLK, negedge HRESETn) begin
    if(!HRESETn) begin
        start <= 0;
  HRESETn_d <= 0;
    end
    else begin    
        HRESETn_d <= HRESETn;
  if(HRESETn == 1'b1 && HRESETn_d == 1'b0) // starting pulse
   start <= 1'b1;
  else
   start <= 1'b0;
    end
end

///////////////////////// Finite State Machine for reading RGB888 data from memory and creating hsync and vsync pulses //////////////////////////
always@(posedge HCLK, negedge HRESETn)
begin
    if(~HRESETn) begin
        cstate <= ST_IDLE;
    end
    else begin
        cstate <= nstate; // update next state 
    end
end

   
endmodule