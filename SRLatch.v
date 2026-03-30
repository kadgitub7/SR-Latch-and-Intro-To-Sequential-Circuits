`timescale 1ns / 1ps

module SRLatch(
    input R,
    input S,
    output Q,
    output Qcom
    );
    
    assign Q = ~(R | Qcom);
    assign Qcom = ~(S | Q);
    
endmodule
