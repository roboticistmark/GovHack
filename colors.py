# adapted from: http://mc706.com/tip_trick_snippets/1/
import colorsys

OUTFILE = 'palette.txt'

def generate_colors(n):
    '''Generate n colors and returns a list in hex format'''
    HSV_tuples = [(x*1.0/n+.5, 0.6, 0.5) for x in range(n)] #Uses HSV colors to find equidistant colors on color wheel
    RGB_tuples = map(lambda x: colorsys.hsv_to_rgb(*x), HSV_tuples) #use colorsys to convert all hsv values to rgb
    RGB_set = []
    for r,g,b in RGB_tuples:
        color = (int(r*255),int(g*255),int(b*255))
        RGB_set.append(color)
    hex_set = []
    for tup in RGB_set:
        hexa ="#%02x%02x%02x" % tup #convert all values in list to hex for use in html
        hex_set.append(hexa)
    return_set = []
    i = 0
    while len(hex_set)>0:    # reorder list so each subsequent color is farthest distance from adjacent colors
        if i%2 == 0:
            return_set.append(hex_set.pop(0))
        else:
            return_set.append(hex_set.pop())
    return return_set

def write_colors(n):
    f = open(OUTFILE, 'w')
    cols = generate_colors(n)
    nums = [x/2.0 for x in range(0, n)]
    vals = zip(cols, nums)
    for c,i in vals:
        f.write("[score > %f] {polygon-fill: %s;}\n" % (i,c))
    f.close()
