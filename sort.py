import re
from collections import defaultdict

dct = defaultdict(list)


def sort_photos(file_names):
    for file_name in file_names:
        first_part = re.split('[^a-zA-Z]', file_name)[0]
        dct[first_part].append(file_name)
    print(dct)
files = ['mallika_1.jpg', 'dog005.jpg', 'grandson_2018_01_01.png', 'dog008.jpg', 'mallika_6.jpg', 'grandson_2018_5_23.png', 'dog01.png', 'mallika_11.jpg', 'mallika2.jpg', 'grandson_2018_02_5.png', 'grandson_2019_08_23.jpg', 'dog9.jpg', 'mallika05.jpg' ]

sort_photos(files)


## Output =  {'mallika': ['mallika_1.jpg', 'mallika_6.jpg', 'mallika_11.jpg', 'mallika2.jpg', 'mallika05.jpg'], 'dog': ['dog005.jpg', 'dog008.jpg', 'dog01.png', 'dog9.jpg'], 'grandson': ['grandson_2018_01_01.png', 'grandson_2018_5_23.png', 'grandson_2018_02_5.png', 'grandson_2019_08_23.jpg']}
