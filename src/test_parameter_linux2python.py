import sys
if __name__=='__main__':
	arg1, arg2 = sys.argv[1], sys.argv[2]
	arg2=arg2.split("/")[-1]
	print(arg1, arg2)
