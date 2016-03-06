#This is the first script. It uses curl on linux kernel(meant for linux only).
#I used python to execute bash commands(I should have made a bash script).
import os
print("Enter X for proxy X._._._:_")
a=input()
print("Enter X for proxy _.X._._:_")
b=input()
print("Enter starting value for proxy _._.X._:_")
I=int(input())
print("Enter starting value for proxy _._._.X:_")
J=int(input())
print("Enter X for proxy _._._._:X")
p=input()
print("Enter timeout is seconds")
t=input()
for i in range(I,254):
	for j in range(J,254):
		print("Testing proxy :> "+str(a)+"."+str(b)+"."+str(i)+"."+str(j)+":"+str(p))
		com1="http_proxy=http://"+str(a)+"."+str(b)+"."+str(i)+"."+str(j)+":"+str(p)+"/ curl -s --connect-timeout "+str(t)+" www.google.com; echo $?>~/Desktop/temp.txt "
		read=os.popen(com1).read();
		if(read=="0\n"):
			com2="echo "+str(a)+"."+str(b)+"."+str(i)+"."+str(j)+":"+str(p)+">>~/Desktop/Proxy_list.txt"
			os.system(com2)
com3="rm ~/Desktop/temp.txt"
os.system(com3)
