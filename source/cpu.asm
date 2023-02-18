; CustomASM

#ruledef instructions {
	ADD A, B					=> 0x0`4 @ 0`4
	SUB A, B					=> 0x1`4 @ 0`4
	ADC A, B					=> 0x2`4 @ 0`4
	SBB A, B					=> 0x3`4 @ 0`4
	SWP A, B					=> 0x4`4 @ 0`4
	LOAD A, {imm:u8}					=> 0x5`4 @ 0`4 @ imm`8
	LOAD A, [{disp:u12}]				=> 0x6`4 @ disp`12
	LOAD A, [{disp:u12}+C]				=> 0x7`4 @ disp`12
	STORE [{disp:u12}], A				=> 0x8`4 @ disp`12
	STORE [{disp:u12}+C], A				=> 0x9`4 @ disp`12
	SWP A, C					=> 0xa`4 @ 0`4
	JE {disp:u12}						=> 0xb`4 @ disp`12
	JMP {disp:u12}						=> 0xc`4 @ disp`12
	NOT A						=> 0xd`4 @ 0`4
	AND A, B					=> 0xe`4 @ 0`4
	OR A, B						=> 0xf`4 @ 0`4
}
