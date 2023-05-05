from py_pdf_parser.loaders import load_file
from pprint import pprint

def get_instructions_from_manual(inPDFpath, keywords):
    document = load_file(inPDFpath)

    elements = document.elements.filter_by_text_contains(keywords[0])
    for key in keywords:
        elements = elements.__or__(document.elements.filter_by_text_contains(key))

    h_elements = elements.filter_by_fonts('Arial-BoldMT,10.5','Arial-Black,14.0')

    flag =  False
    inst_elements = [] #Vehicles with a smart key system
    inst2_elements = [] #Vehicles without a smart key system
    tools_elements = []
    blacklist =["Downloaded from manualsnet.com search engine", "COROLLA_TMMMS_TMMC_U (OM12J84U)", "The air conditioning filter must be changed regularly to maintain\nair conditioning efficiency.", "Removal method","Replace the battery with a new one if it is depleted.","You will need the following items:", "Replacing the battery", "Head restraints are provided for all seats.", "Adjustment procedure", "Use the overhead switches to open and close the moon roof and\ntilt it up and down.", "Warning lights inform the driver of malfunctions in the indicated vehicle’s\nsystems."]
    breaks = ["CAUTION","n Checking interval", "n Use a CR2016 (vehicles without a smart key system) or CR2032 (vehicles", "n The moon roof can be operated when", "*1: Vehicles without a smart key system:"]
    exc = ["\uf075 Flat dipstick", "\uf075 Non-flat dipstick"]
    prev = -1
    pages = []
    for element in h_elements:
        for e in document.elements.below(element, all_pages=True):
            if e.text() in breaks:
                break
            if e.text().split()[0] != "n" and e.text() not in blacklist:
                if e.font_name != "Arial-BoldMT":
                    if e.text().split()[0] == "l"  or (prev != -1 and prev.text().split()[0] == "l"):
                        tools_elements.append(e)
                        pages.append(e.page_number)
                    else: 
                        if  e.text().split()[0] == "\uf075" and e.text()not in exc: 
                            flag = not flag
                            continue
                        if flag == False:
                            inst_elements.append(e)  
                            if e.page_number not in pages:
                                pages.append(e.page_number)
                        else:
                            inst2_elements.append(e)
                            if e.page_number not in pages:
                                pages.append(e.page_number)
                else:     
                    break   
            prev = e

    inst = "\n".join(e.text() for e in inst_elements)
    inst2 = "\n".join(e.text() for e in inst2_elements)
    tools = "\n".join(e.text() for e in tools_elements)

    output = {
        "source": "manual",
        "instructions": inst,
        "instructions 2": inst2,
        "tools/parts": tools,
        "pages": pages
    }

    return output





import os

cd = os.path.dirname(__file__)
inPDF = "2016_toyota_corolla.pdf"
outXML = "output.xml"
outHTML = "output.html"
inPDFpath = cd+"\\"+inPDF
outXMLpath = cd+"\\"+outXML
outHTMLpath = cd+"\\"+outHTML

# keywords= [ "Find Vehicle Identification Number", "VIN"]
# keywords= [ "Hood", "hood" ]
# keywords= [ "Battery", "battery" ] #!!!
# keywords= [ "coolant" ]
# keywords = ["engine oil"]
# keywords = ["Brake fluid"]
# keywords = ["Windshield fluid", "windshield fluid"]
# keywords = ["Flat tire","flat tire"] #!!!
# keywords = ["Wiper blades", "wiper blades"] 
# keywords= [ "Headlights", "headlights"] #!!!
# keywords = ["Front turn signal/parking lights"]
# keywords = ["rear turn signal lights"]
# keywords =["Stop/tail/rear side marker lights"]
# keywords = ["Brake lights", "brake lights"]
keywords = ["Air conditioning filter"]
# keywords = ["Wireless remote control/electronic key \nbattery"]
# keywords = ["Front seats"] #!!!
# keywords = ["Folding down the rear seatbacks"]
# keywords = ["Head restraints"] #???
# keywords = ["Outside rear view mirrors"]
# keywords = ["Moon roof"] #???
# keywords = ["Warning lights","Warning light"]

pprint(get_instructions_from_manual(inPDFpath, keywords))