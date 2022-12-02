from tempfile import mkstemp
from shutil import move, copymode
from os import fdopen, remove
import os
import re
import argparse

parser = argparse.ArgumentParser(description='Transform build tags into image tags for use in gitlab-ci')
parser.add_argument('--file', help='path to compose file to update')
parser.add_argument('--variables', help='environment variable names that contain the image names and tags', nargs='+')

args = parser.parse_args()
values = [os.environ.get(v.upper()) for v in args.variables]

def replace_first_occurrence(file, pattern, subst):
    #Create temp file
    replaced = False
    fh, abs_path = mkstemp()
    with fdopen(fh,'w') as new_file:
        with open(file) as old_file:
            for line in old_file:
                new_line = re.sub(pattern, subst, line)
                if not replaced:
                    new_file.write(new_line)
                    print(new_line, line)
                    if new_line != line:
                        replaced = True
                else:
                    new_file.write(line)

    #Copy the file permissions from the old file to the new file
    copymode(file, abs_path)
    #Remove original file
    remove(file)
    #Move new file
    move(abs_path, file)


for value in values:
    replace_first_occurrence(args.file, 'build(.*)$', 'image: %s' % value)




