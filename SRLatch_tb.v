`timescale 1ns / 1ps

module SRLatch_tb();
    
    reg R,S;
    wire Q,Qcom;
    
    reg prev_Q;
    
    SRLatch uut(R,S,Q,Qcom);
    
    initial begin
        $monitor("Time=%0t | R=%b S=%b | Q=%b Qcom=%b", $time, R, S, Q, Qcom);
    
        R = 0; S = 0;
        #10;
    
        S = 1; R = 0;
        #10;
    
        prev_Q = Q;
    
        S = 0; R = 0;
        #10;
    
        if (Q === prev_Q)
            $display("PASS: Memory retained. Q stayed at %b", Q);
        else
            $display("FAIL: Memory lost. Q changed to %b", Q);
    
        R = 1; S = 0;
        #10;
    
        prev_Q = Q;
    
        R = 0; S = 0;
        #10;
    
        if (Q === prev_Q)
            $display("PASS: Memory retained after reset. Q=%b", Q);
        else
            $display("FAIL: Memory lost after reset. Q=%b", Q);
    
        $finish;
    end
endmodule
