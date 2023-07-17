transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/achal/Desktop/385\ 2.2\ Files {C:/Users/achal/Desktop/385 2.2 Files/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/SLC3_2.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/REGs.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/MUXes.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/Mem2IO.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/ISDU.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/test_memory.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/synchronizers.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/ALU.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/REG_FILE.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/BEN.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/slc3.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/memory_contents.sv}
vlog -sv -work work +incdir+C:/Users/achal/Downloads/lab\ 5.1 {C:/Users/achal/Downloads/lab 5.1/slc3_testtop.sv}

vlog -sv -work work +incdir+C:/Users/achal/Desktop/Lab\ 5.1/../../Downloads/lab\ 5.1 {C:/Users/achal/Desktop/Lab 5.1/../../Downloads/lab 5.1/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
