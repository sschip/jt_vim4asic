#!/usr/bin/csh -f
set TAGS_BUILTIN_KW = (if else endif always always_comb always_ff always_latch forever initial begin end while for bit wire reg logic define parameter localparam module endmodule interface endinterface class endclass task endtask function endfunction)
foreach kw_to_remove ($TAGS_BUILTIN_KW)
    sed -i "/^\s*${kw_to_remove}\s/d" $1
end
