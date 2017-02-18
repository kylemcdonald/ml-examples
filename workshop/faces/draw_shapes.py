from skimage.draw import circle, circle_perimeter
from skimage.draw import polygon, polygon_perimeter

def draw_circle(canvas, xy, r=1, stroke=None, fill=None):
    x,y = xy
    if fill:
        rr,cc = circle(x, y, r, shape=canvas.shape)
        canvas[rr,cc] = fill
    if stroke:
        rr,cc = circle_perimeter(x, y, r, shape=canvas.shape)
        canvas[rr,cc] = stroke

def draw_rectangle(canvas, det, fill=None, stroke=None):
    n,e,s,w = (det.top(), det.right(), det.bottom(), det.left())
    x,y = (n,n,s,s), (w,e,e,w)
    if fill:
        rr,cc = polygon(x, y, shape=canvas.shape)
        canvas[rr,cc] = fill
    if stroke:
        rr,cc = polygon_perimeter(x, y, shape=canvas.shape)
        canvas[rr,cc] = stroke