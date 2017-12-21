// test assembler program RISC-V processor

start:
	# test normal operation
	lw x5, 12 (x0)		# 	load a word in x5
	addi x6, x0, 3		# 	add immediate (3) to zero and save in x6
	addi x7, x0, -10	# 	add immediate (-10) to zero and save in x6
	addi x28, x5, 5		# 	add 5 to loaded value
	and x29, x0, x5 	# 	AND variable with zero, should result in zero
	add x30, x6, x7 	# 	add x6 and x7 -> result should be -7 (0b111111111001 = 0xFF9)
	# test forwarding in pipeline
	addi x31, x30, 8	# 	x31 is after instruction executes: 1
	and x28, x30, x31	# 	x28 is then 1
	add x29, x31, x28	# 	x29 is then 2
	ori x29, x6, 15		# 	x29 is then 15 (0b1111 = 0xf)
	add x16, x29, x29	# 	x16 is then 30 (0b11110 = 0x1e)
	# test mem forwarding
	lw x5, 8 (x0)		#	load constant 15
	sw x5, 16 (x0)		# 	must forward x5 from load instr
	lw x0, 16 (x0)		# 	load 15 into register 0
	sw x0, 20 (x0)		# 	should not forward 15

lw x5, 12 (x0):
0000 0000 1100 0000 0010 0010 1000 0011 -> 0x00c02283
immediate 		rs 		f3 		rd 		opcode
000000001100 	00000 	010 	00101 	0000011

addi x6, x0, 3:
0000 0000 0011 0000 0000 0011 0001 0011 -> 0x00300313
immediate 		rs 		f3 		rd 		opcode
000000000011 	00000 	000 	00110 	0010011

addi x7, x0, -10:
1111 1111 0110 0000 0000 0011 1001 0011 -> 0xff600393
immediate 		rs 		f3 		rd 		opcode
111111110110 	00000 	000 	00111 	0010011

addi x28, x5, 5:
0000 0000 0101 0010 1000 1110 0001 0011 -> 0x00528e13
immediate 		rs 		f3 		rd 		opcode
000000000101 	00101 	000 	11100 	0010011

and x29, x0, x5:
0000 0000 0101 0000 0111 1110 1011 0011 -> 0x00507eb3
funct7		rs2		rs1		funct3	rd		opcode
0000000		00101	00000	111		11101	0110011

add x30, x6, x7:
0000 0000 0111 0011 0000 1111 0011 0011 -> 0x00730f33
funct7		rs2		rs1		funct3	rd		opcode
0000000		00111	00110	000		11110	0110011

# forwarding test
addi x31, x30, 8:
0000 0000 1000 1111 0000 1111 1001 0011 -> 0x008f0f93
immediate 		rs 		f3 		rd 		opcode
000000001000 	11110 	000 	11111 	0010011

and x28, x30, x31:
0000 0001 1111 1111 0111 1110 0011 0011 -> 0x01ff7e33
funct7		rs2		rs1		funct3	rd		opcode
0000000		11111	11110	111		11100	0110011

add x29, x31, x28:
0000 0001 1100 1111 1000 1110 1011 0011 -> 0x01cf8eb3
funct7		rs2		rs1		funct3	rd		opcode
0000000		11100	11111	000		11101	0110011

ori x29, x6, 15:
0000 0000 1111 0011 0110 1110 1001 0011 -> 0x00f36e93
immediate 		rs 		f3 		rd 		opcode
000000001111 	00110 	110 	11101 	0010011

add x16, x29, x29:
0000 0001 1101 1110 1000 1000 0011 0011 -> 0x01de8833
funct7		rs2		rs1		funct3	rd		opcode
0000000		11101	11101	000		10000	0110011

# mem forwarding test
lw x5, 8 (x0):
0000 0000 1000 0000 0010 0010 1000 0011 -> 0x00802283
immediate 		rs 		f3 		rd 		opcode
000000001000 	00000 	010 	00101 	0000011

sw x5, 16 (x0):
0000 0000 0101 0000 0010 1000 0010 0011 -> 0x00502823
imm[11:5]	rs2		rs1		funct3	imm[4:0]	opcode
0000000		00101	00000	010 	10000		0100011

lw x0, 16 (x0):
0000 0001 0000 0000 0010 0000 0000 0011 -> 0x01002003
immediate 		rs 		f3 		rd 		opcode
000000010000 	00000 	010 	00000 	0000011

sw x0, 20 (x0):
0000 0000 0000 0000 0010 1010 0010 0011 -> 0x00002a23
imm[11:5]	rs2		rs1		funct3	imm[4:0]	opcode
0000000		00000	00000	010 	10100		0100011