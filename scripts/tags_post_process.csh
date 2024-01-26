#!/usr/bin/csh -f
set TAGS_BUILTIN_KW = (if else endif while for which module endmodule interface endinterface class endclass task endtask function endfunction)
foreach kw_to_remove ($TAGS_BUILTIN_KW)
    sed -i "/^\s*${kw_to_remove}\s/d" $1
end
