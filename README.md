# jt_vim4asic
JT's vim settings for ASIC design, ASIC verification
# Setup for VIM on Linux
1. RTL TB (UVM) source code browing with VIM + CTAGS
   1) Add the following line in your .vimrc at the home directory (~/.vimrc) for VIM + CTAGS keyboard mappings  
      **source <your directory of jt_vim4asic>/vimrc_template/vimrc_ctags**
   2) Generate tags files for both definitions and referencing.  
     **make all INPUT_DIR=\<your directory with RTL and Testbench\> OUTPUT_DIR=~/tags_out**
   3) Open any RTL/TB file and do source code browsing with in provided Keyboard mappings defined in vimrc_template/vimrc_ctags
2. To be added
# Keyboard mappings
1. RTL TB (UVM) source code browing with VIM + CTAGS, the keyboard mapping is defined in vimrc_template/vimrc_ctags.
   1)  <Ctrl + ]> - jump to the first definition
   2)  <Ctrl + l> - jump to the first reference
   3)  g]         - list all definitions and choose one of them to jump to
   4)  gl         - list all references and choose one of them to jump to
   5)  <Ctrl + t> - jump back, it works with the above keyboard mappings 1) to 4).
   6)  \<F12\>    - RTL signal cross hierachy tracking
2. To be added
# See help with make help.
