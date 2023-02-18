main:
	LOAD A, 0
	SWP A, C
	LOAD A, message.length
	SWP A, B

.loop:
	LOAD A, [message+C]
	STORE [0xF00+C], A

	; Increment message pointer
	SWP A, C
	SWP A, B ; These 3 SWP instructions are equivelent to a "SWP B, C" (which doesn't exist)
	SWP A, C
	LOAD A, 1
	ADD A, B

	; Check if End-of-Message has been reached
	SWP A, B
	SWP A, C
	JE .end

	; Make registers the correct order
	SWP A, B
	SWP A, C

	; If End-of-Message was reached jump to end, otherwise jump to start of loop
	JMP .loop
.end:
	JMP $

message:
	#d "Hello, world!"
.length = $ - message 
