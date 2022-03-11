import sys
import json
import xml.etree.ElementTree as ET

f_L = """
{"files": [
    {"f": "A.jar", "v": "1", "crc": "12", "crcZ": "11"},
    {"f": "B.jar", "v": "2", "crc": "22", "crcZ": "21"},
    {"f": "C.jar", "v": "3", "crc": "32", "crcZ": "31"}
]}
"""

f_0 = """
<files>
    <file crc32rar="11" crc32="12" len="13">A.jar</file>
    <file crc32rar="71" crc32="22" len="23">B.jar</file>
    <file crc32rar="31" crc32="72" len="33">C.jar</file>
    <file crc32rar="41" crc32="42" len="43">D.jar</file>
</files>
"""

VER = "LAS6.777"
# VER = sys.argv[1]

# tree = ET.parse(f)

L_map = {}
for el in json.loads(f_L)['files']:
    L_map[el['f']] = el

XML_CRC = 'crc32'
XML_CRC_Z = 'crc32rar'

crc_list = []
index_0 = ET.fromstring(f_0)
for el in index_0.iter():
    if not el.attrib:
        continue

    curr = el.attrib
    prev = L_map.get(el.text, {})

    modified = False
    if not prev or prev['crc'] != curr[XML_CRC]:
        modified = True

    if modified:
        # копируешь файл или что там
        print('modified', el.text)

    crc_list.append({
        'f': el.text,
        'v': VER if modified else prev.get('v', VER),
        'crc': curr[XML_CRC],
        'crcZ': curr[XML_CRC_Z]
    })

print(json.dumps({'files': crc_list}))
