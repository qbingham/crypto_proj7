'''
Class: CPSC 353
Name: Brewer Slack
Name1: Quin Bingham
Name2: Jon Reid
GU	Username: bslack
'''

import math
import random

S0 = [[1,0,3,2],[3,2,1,0],[0,2,1,3],[3,1,3,2]]
S1 = [[0,1,2,3],[2,0,1,3],[3,0,1,0],[2,1,0,3]]

# diffie-hellman exchange. Takes a public prime, primitive root, and Bob's result
# returns: Alice and Bob's shared key, K.
def dif_hell(p, g, B): #715225741, 2
	a = random.randint(1, p)
	#b = random.randint(1, p) #bob
	A = mod((g ** a), p)
	#B = mod((g ** b), p) # bob
	K = mod((B ** a), p)
	#check_bob = mod((A ** b), p)
	return(K)

def sDES(plaintext, key):
	#initial permutation
	pt_list = list(plaintext)
	init_permutation = (1,5,2,0,3,7,4,6)
	pt_permuted = pt_list
	for i in range(8):
		pt_permuted[i] = pt_list[init_permute[i]]
	
	#subkeys
	key_list = list(key)
	subkey_permutation = (2,4,1,6,3,9,0,8,7,5)
	subkey_permuted = key_list 
	for i in range(10):
		subkey_permuted[i] = key_list[subkey_permutation[i]]
	subkeyA_round1 = subkey_permuted[1:5]
	subkeyA_round1.append(subkey_permuted[0])
	subkeyB_round1 = subkey_permuted[6:]
	subkeyB_round1.append(subkey_permuted[5])
	subkey_round1 = subkeyA_round1.extend(subkeyB_round1)
	bits_from_result = (5,2,6,3,7,4,9,8)
	subkey_one = []
	for i in range(8):
		subkey_one.append(subkey_round1[bits_from_result[i]])
	#subkey one complete
	subkeyA_round2 = subkeyB_round1[2:]
	subkeyA_round2.extend(subkeyA_round1[:2])
	subkeyB_round2 = subkeyB_round1[2:]
	subkeyB_round2.extend(subkeyB_round1[:2])
	subkey_round2 = subkeyA_round2.extend(subkeyB_round2)
	subkey_two = []
	for i in range(8):
		subkey_two.append(subkey_round2[bits_from_result[i]])
	#subkey two complete

	#1. Initial permutation.
	#2. Feistel operation using subkey K1. 
	#3. Switch left and right halves.
	#4. Feistel operation using subkey K2. 
	#5. Inverse permutation.


	#feistel type function
def feistel_step(Li, Ri, Ki):
	Ln = Li ^ (mixing_function(Ki, Ri))
	Rn = Ri
	return Ln, Rn

def mixing_function(Ki, Ri):
	#expand 4-bit block
	block = Ri
	subkey = Ki
	b3b0 = block[3:1]
	b1b2 = block[1:3]
	expansion = b3b0.extend(b1b2.extend(b1b2.extend(b3b0)))
	xor_result = subkey ^ expansion
	xorA = xor_result[:4]
	#S-bo
	rowS0 = int(''.join(xorA[3:1]),2)
	colS0 = int(''.join(xorA[1:3]),2)
	xorB = xor_result[4:]
	rowS1 = int(''.join(xorB[3:1]),2)
	colS1 = int(''.join(xorB[1:3]),2)
	S0_int_result = S0[rowS0][colS0]
	S1_int_result = S1[rowS1][colS1]
	#int to binary
	get_bin = lambda x: format(x, 'b')
	S0_2bit = list(int(get_bin(S0_int_result)))
	S1_2bit = list(int(get_bin(S1_int_result)))
	final_4bit = [S0_2bit[1],S1_2bit[1],S1_2bit[0],S0_2bit[0]]
	return final_4bit

def el_gamal_enc(p, g, m):
	g = mod(primitive_root(p),p)
	A = random.randint(1, p)
	B = g ** A
	k = random.randint(1,p)
	c1 = g^k
	c2 = (B^k)*m
	return (c1, c2, A)
	
			  
def el_gamal_dec(p, g, c1, c2, A):
	return c2 / c1^A
	
	
	
	
	
	