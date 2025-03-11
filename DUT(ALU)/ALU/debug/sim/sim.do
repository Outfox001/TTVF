
vlib work
vmap work work

vlog  ../../hdl/ALU_control.v
vlog  ../hdl/ALU_testbench.v
vlog  ../hdl/ALU_test.v
vsim  work.ALU_test -voptargs=+acc

do wave.do

run -all











