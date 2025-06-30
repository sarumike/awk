import datetime,sys, subprocess

from utilities import read_value

# usage steps
# convert filtered file epoch times to human readable hh:ss format
# calculate tps - this is unsorted
# sort the values by time



#check for no parameter, ie csv file supplied
if len(sys.argv) == 1:
    print("Error: please use format  : " \
    "" \
    "python process_tps.py file.csv")
    sys.exit(1)

filename = sys.argv[1]

print(f"file to process is: {filename}")

#extract filename ignoring the file  extension
ext = filename.find(".") 
file2 = filename[0:ext]

#count number of lines in csv file

with open(filename, 'r') as file:
    lines = file.readlines()

x = len(lines)

print (f"number of lines to process is : {x}")



# Save original stdout
o = sys.stdout

print(f"writing to file {file2}_epoch.txt")

with open(f"{file2}_epoch.txt", "w") as file:
    sys.stdout = file

    for i in range (1, x):

        #read in epoch time 
        epoch_time = int(read_value(filename,0,i,","))
        epoch_time2 = epoch_time/1000

        # Convert epoch to human-readable time
        readable_time = datetime.datetime.fromtimestamp(epoch_time2)
        
        formatted_time = readable_time.strftime('%H:%M:%S')
                                 
        print(formatted_time)
        






# Define the AWK command as a string

#awk calculate number of requests per sec
#NB this will be unsorted by time
awk_command = (f" awk -F \",\" \"{{a[$1]++}} END {{for(x in a) print x, a[x]}}\" {file2}_epoch.txt > {file2}_tps.txt")

result = subprocess.run(awk_command, text=True, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)


#awk sort the number of requests/sec by time
awk_command2 = (f" awk \"{{print $0}}\" {file2}_tps.txt|sort > {file2}_tps_sorted.txt")

result2 = subprocess.run(awk_command2, text=True, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)


# Restore stdout
sys.stdout = o
