import random

r0 = 0
r1 = 0
r2 = 0
r3 = 0
r4 = 0
r5 = 0
r6 = 0
r7 = 0
rO = 0

#program1
r2 = 128
r3 = 2

while r7 < 16:
	r6 = r3 & 1
	if(r6 != 0):
		r5 = r2 + r5
		if(r5 > 511):
			rO = 1
			r5 = r5 & 511
		else: 
			r0 = 0
		r4 = rO + r4
		r4 = r1 + r4
	r6 = r2 & 128
	r2 = r2 << 1
	r2 = r2 & 511
	r1 = r1 << 1
	r1 = r6 + r1
	r3 = r3 >> 1
	r7 = 1 + r7
	if ( r7 == 8):
		r3 = 2
		r2 = r5
		r1 = r4
		r4 = 0
		r5 = 0
print r4
print r5

#program 2
r0 = 0
r1 = 0
r2 = 0
r3 = 0
r4 = 0
r5 = 0
r6 = 0
r7 = 0
rO = 0

string_array = random.sample(range(1, 512), 64)

while r3 < 64:

































