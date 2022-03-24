"""
Git repository: https://github.com/thetbn12/GCode-Editor

HOW TO USE:
Drag and drop G-Code file into the same folder as this program.
Run the program.
Set the file explorer path of G-Code file to read. 
Set the file explorer path of G-Code file to write to.

Console will print:
- What lines edits were made at in both the original file and the new file
- Number of lines read
- Number of lines written
- Total number of edits made
"""

readFileName = input("File Explorer path of G-Code file to read: ")
writeFileName = input("File Explorer path of G-Code file to write to: ")
print("")

readFile = open(readFileName)
writeFile = open(writeFileName, "w")

# =============================================================================
"""
Delete any line that includes x:
    "x",

NOTES:
- The more specific you are with x, the less likely the 
    code will delete something you want to keep.  
- Don't forget the comma at the end of the line!
"""
deleteLinesWith = [
    "N40",
    "N45",
    ";(ORGX58=0,ORGY58=0,ORGZ58=0)",
    "G43",
]
# =============================================================================
"""
Replace any entire line x with line y (and line z):
    "x": "N y",
    "x": "N y\n N z",
    
NOTES:
- You can replace one line with multiple, just separate by "\n"
- Gotta be real specific. If you're off by even a 
    whitespace, software will note recognize it as the same line.
- The "N" in front of the replacement line is important (sets up the line 
    numbers in output file).
- Don't forget the comma at the end of the line!
"""
replaceLinesWith = {
    "N35 G53": "N## MCS Z0 \nN## MCS Y0",
}
# =============================================================================
"""
Replace any code x with y:
    "x": "y",
    
NOTES:
- Don't forget the comma at the end of the line!
"""
replaceCodes = {
    "M3": "M3 M7",
}
# =============================================================================
layerNumber = 0
deckingSwitchNumber = 99999999
lineCountRead = 0
lineCountWrite = 5
editCount = 0
# -----------------------------------------------------------------------------
def writeWithNum(string, num):
    if string.startswith("N"):
        stringParts = string.split()
        fullString = ""
        for part in stringParts:
            if not part.startswith("N"):
                fullString += part + " "
        return "N" + str(num) + " " + fullString + "\n"
    return string + "\n"
# -----------------------------------------------------------------------------
def consoleOut(numRead, numWrite):
    print("Edited read file line " + str(numRead) + " to write file line "
          + str(int((numWrite - 5) / 5)))
# -----------------------------------------------------------------------------

for nextLine in readFile:
    lineCountRead += 1
    # -------------------------------------------------------------------------
    if nextLine.find("END"):

        # Comment this line out if the flag line doesn't have G-Code
        writeFile.write(writeWithNum(nextLine, lineCountWrite))
        lineCountWrite += 5

        if layerNumber < deckingSwitchNumber:
            layerChangeGcode = [
                "#PCALL decking.nc P1=V.P.layer_num",
            ]
        else: # Thinner decking pass G-Code
            layerChangeGcode = [
                "line 1",
                "line 2",
                "line 3",
            ]

        for nextCode in layerChangeGcode:
            writeFile.write(writeWithNum(nextCode, lineCountWrite))
            lineCountWrite += 5

        consoleOut(lineCountRead, lineCountWrite)
        editCount += 1
        layerNumber += 1
        continue;
    # -------------------------------------------------------------------------
    deleteLine = False
    for deleteEntry in deleteLinesWith:
        if nextLine.find(deleteEntry) >= 0:
            writeFile.write("\n")
            lineCountWrite += 5
            consoleOut(lineCountRead, lineCountWrite)
            editCount += 1
            deleteLine = True
            break
    if deleteLine:
        continue
    # -------------------------------------------------------------------------
    replaceLine = False
    for replaceEntry in replaceLinesWith:
        if nextLine == replaceEntry + "\n":
            newLine = replaceLinesWith.get(replaceEntry)
            splitLine = newLine.split("\n")
            for sendLine in splitLine:
                writeFile.write(writeWithNum(sendLine, lineCountWrite))
                lineCountWrite += 5

            consoleOut(lineCountRead, lineCountWrite)
            editCount += 1
            replaceLine = True
            break
    if replaceLine:
        continue
    # -------------------------------------------------------------------------
    replaceCode = False
    nextLine = nextLine.split()
    for nextLineIndex in range(len(nextLine)):
        for checkReplace in replaceCodes:
            if nextLine[nextLineIndex] == checkReplace:
                nextLine[nextLineIndex] = replaceCodes.get(checkReplace)
                editCount += 1
                replaceCode = True

    fullLine = ""
    for nextCode in nextLine:
        fullLine += nextCode + " "

    writeFile.write(writeWithNum(fullLine, lineCountWrite))
    lineCountWrite += 5
    if replaceCode:
        consoleOut(lineCountRead, lineCountWrite)
    # -------------------------------------------------------------------------

print("\nLines read: " + str(lineCountRead))
print("Lines Written: " + str(int((lineCountWrite - 5) / 5)))
print("Edits made: " + str(editCount))

readFile.close()
writeFile.close()
