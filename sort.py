import re
from collections import defaultdict

dct = defaultdict(list)


def sort_photos(file_names):
    for file_name in file_names:
        first_part = re.split('[^a-zA-Z]', file_name)[0]
        dct[first_part].append(file_name)
    print(dct)
