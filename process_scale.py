import datetime,sys

from utilities import read_value

#check for no parameter, ie csv file supplied
if len(sys.argv) == 1:
    print("Error: please use format  : " \
    "" \
    "python process_scale.py file.csv")
    sys.exit(1)

filename = sys.argv[1]
sampling_rate = sys.argv[2]

print(f"file to process is: {filename}")



#count number of lines in csv file

with open(filename, 'r') as file:
    lines = file.readlines()

x = len(lines)

print (f"number of lines to process is : {x}")


#extract filename ignoring the file  extension
ext = filename.find(".") 
file2 = filename[0:ext]

#scale is the sampling rate for the tps data file.  Too many data points  make the excel graph unreadable. 
#Scale factor reduces the number of data points to a more manageable set of data
scale = sampling_rate

# Save original stdout
o = sys.stdout

print(f"writing to file {file2}_scaled.txt")

with open(f"{file2}_tps_reduced.txt", "w") as file:
    sys.stdout = file

    for i in range (0, x, scale):

        #read in required line of data from tps file
        value = read_value(filename,0,i,",")
        
        print(value)                         
        
        


# Restore stdout
sys.stdout = o

