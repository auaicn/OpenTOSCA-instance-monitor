import re
import json

def main():
    f = open("container_log.log", "r")
    #log = f.read()
    k = []
    while True:
        l += 1
        line = f.readline()
        if not line: break
        #print(line)
        if "[default-workqueue-5]" in line and "serviceInstanceID" in line: 
            k.append((l,line))
        
    f.close()

if __name__ == '__main__':
  main()