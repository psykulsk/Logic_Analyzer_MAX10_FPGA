
FIFO_DEPTH = 16384;   %Depth of FIFO Memory Block in MAX10 FPGA
delete(figure(1))     %Delete figure so the new text will not overlap with the old

if(size(instrfind) ~= 0)  %Delete and release all serial port objects
    fclose(instrfind);
    delete(instrfind);
end

%Setup serial port
serialPort = serial('COM10');
set(serialPort, 'InputBufferSize',FIFO_DEPTH+1);
set(serialPort, 'FlowControl', 'none');
set(serialPort, 'BaudRate', 625000);
set(serialPort, 'Parity', 'none');
set(serialPort, 'DataBits', 8);
set(serialPort, 'StopBit', 1);
set(serialPort, 'Terminator', 'LF');

%Try to open serial port
try
fopen(serialPort);
catch
    disp('Serial port not available')
    return
end

samplerate = 10^7;          %Sample rate of 10 MHz
FIFOLength = FIFO_DEPTH;
timespan = FIFOLength/samplerate;
%TimeScope setup
LogicAnalyzerViewer = dsp.TimeScope('YLimits',[0,1.1], 'TimeSpan',timespan, 'BufferLength',FIFOLength, 'FrameBasedProcessing',false, ...
'SampleRate', samplerate, 'TimeSpanOverrunAction','Scroll', 'NumInputPorts',3,'LayoutDimensions',[3,1], 'PlotType','Stairs');
LogicAnalyzerViewer.show();

figure(1)
message = text(0.1,0.5,'Press to measure');
message.FontSize = 25;
message.Color = 'red';
waitforbuttonpress
delete(message);
while(true)
    delete(message);                                    
    message = text(0.1,0.5,'Measurement live');
    message.FontSize = 25;
    message.Color = 'green';
    pause(0.1)                  %Pause to let the message appear
    data = int8(fscanf(serialPort));        %Wait for uart buffer to fill
    if(size(data,2) == FIFO_DEPTH+1)
        for i = 1:FIFO_DEPTH
            linestate = data(i);   %For each byte of data read 3 lowest bits seperately and display them in the TimeScope
            step(LogicAnalyzerViewer, bitget(data(i),1), bitget(data(i),2), bitget(data(i),3));
        end
    end
    delete(message);
    message = text(0.1,0.5,'Press to measure');         %Update message
    message.FontSize = 25;
    message.Color = 'red';
    waitforbuttonpress
end