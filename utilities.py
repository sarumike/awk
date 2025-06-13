import csv

# function to read a data entry in a file, typically a csv but can be any text file type
# takes filename, row, column and a data delimiter (ie comma, space, semi colon) reference
def read_value(filename, col, row, seperator):
    with open(filename, mode = 'r') as file:
        reader = csv.reader(file, delimiter = seperator)
        row_count = 0
        for n in reader:
            if row_count == row:
                data = n[col]
                return data
            row_count += 1
    return data
