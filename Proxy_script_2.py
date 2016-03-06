#Python script. No bash commands like the previous version. The execution is VERY slow. Performance wise 1st script is better.
from StringIO import StringIO    
import pycurl
import os
from os.path import getsize

url = 'http://www.facebook.com/'


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

Myfile=open("/home/rishav/Desktop/Proxy_List.txt","a")
storage = StringIO()
c = pycurl.Curl()
c.setopt(c.URL, url)
c.setopt(pycurl.PROXYPORT, p)
c.setopt(pycurl.TIMEOUT_MS,t)
c.setopt(c.WRITEFUNCTION, storage.write)
c.setopt(c.VERBOSE,False)
#c.setopt(pycurl.PROXYUSERPWD, 'user:pass')
#c.setopt(pycurl.PROXY, 'working_proxy')
c.perform()
testfile=storage.getvalue()
storage.truncate(0)
#print(testfile)
#c.setopt(pycurl.PROXYUSERPWD, None)

for i in range(I,254):
	for j in range(J,254):
		proxy=str(a)+"."+str(b)+"."+str(i)+"."+str(j)
		print("Testing proxy :> "+proxy+":"+str(p))
		try:
			c.setopt(pycurl.PROXY, proxy+':'+str(p))
			c.perform()
			content = storage.getvalue()
			storage.truncate(0)
#			print(content)
			if content==testfile:
				print("Proxy Successful")
				Myfile.write(proxy+":"+str(p)+"\n")
			else:
				print("Proxy Failed")
		except pycurl.error,error:
			print("Proxy Failed")
c.close()
Myfile.close()
