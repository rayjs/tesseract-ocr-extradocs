#!/usr/bin/tclsh8.5
# Licensed under the Apache 2.0 License

if {$argc == 0} {
	puts "Usage: $argv0 filename"
	exit 1
}

set f [open [lindex $argv 0] "rb"]

puts "HEADER:"

binary scan [read $f 4] h* bytes
binary scan [read $f 4] iu auto_encode
binary scan [read $f 4] iu neuron_count
binary scan [read $f 4] iu input_count
binary scan [read $f 4] iu output_count

puts "signature is $bytes"
puts "auto encode: $auto_encode"
puts "neuron count: $neuron_count"
puts "input count: $input_count"
puts "output count: $output_count"

puts ""
puts "NODE TYPES:"

for {set x 0} {$x < $neuron_count} {incr x} {
	if { $x < $input_count } {
		puts "  neuron $x: input"
	} elseif { $x >= ($neuron_count - $output_count) } {
		puts "  neuron $x: output"
	} else {
		puts "  neuron $x: hidden"
	}
}

puts ""
puts "OUTPUT CONNECTIONS:"

for {set x 0} {$x < $neuron_count} {incr x} {
	binary scan [read $f 4] iu num_connections

	puts "  neuron $x"
	puts "    $num_connections connections"
	set connections {}
 	for {set y 0} {$y < $num_connections} {incr y} {
		binary scan [read $f 4] iu connection
		lappend connections $connection
	}
	if { $num_connections > 0 } {
		puts "      $connections"
	}
}

puts ""
puts "INPUT CONNECTIONS:"

for {set x 0} {$x < $neuron_count} {incr x} {
	binary scan [read $f 4] f bias
	puts "  neuron $x"
	puts "    bias: $bias"

	binary scan [read $f 4] iu num_weights
	puts "    $num_weights weights"
	set weights {}
 	for {set y 0} {$y < $num_weights} {incr y} {
		binary scan [read $f 4] f weight
		lappend weights $weight
	}
	if { $num_weights > 0 } {
		puts "      $weights"
	}
}

puts ""
puts "STATISTICS:"

binary scan [read $f 4] f inputs_mean
binary scan [read $f 4] f inputs_stddev
binary scan [read $f 4] f inputs_min
binary scan [read $f 4] f inputs_max

puts "input mean values is $inputs_mean"
puts "input standard deviations values is $inputs_stddev"
puts "input min values is $inputs_min"
puts "input max values is $inputs_max"
