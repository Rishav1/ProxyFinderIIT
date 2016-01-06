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
		com1="http_proxy=http://"+str(a)+"."+str(b)+"."+str(i)+"."+str(j)+":"+str(p)+"/ curl -s --connect-timeout "+str(t)+" www.google.com/humans.txt>~/Desktop/temp.txt"
		os.system(com1)
		Myfile=open("/home/rishav/Desktop/temp.txt","r")
		read=Myfile.read()
		if(read=="Google is built by a large team of engineers, designers, researchers, robots, and others in many different sites across the globe. It is updated continuously, and built with more tools and technologies than we can shake a stick at. If you'd like to help us out, see google.com/careers.\n"):
			com2="echo "+str(a)+"."+str(b)+"."+str(i)+"."+str(j)+":"+str(p)+">>~/Desktop/Proxy_list.txt"
			os.system(com2)
com3="rm ~/Desktop/temp.txt"
os.system(com3)