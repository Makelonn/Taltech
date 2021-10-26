rm(list=ls())
graphics.off()

# 8 * (x  -1)² + 50(y -2)² = 1
# 8x² - 16x + 50y² -200y +207 = 0
# x² = z_1 | x = z_2 | y² = z_3 | y= z_4
# we want to go to 3D to be able to plot -> which variable ? try to remain an ellipse

# we remove z_4 : original equation become  8(x-1)² + 50y² + 200 = 1
# or 8(x-1)² + (y²+4)*50 = 1 <- take this equation
# 8z_1 +-16z_2 + 50 z_3 + 99 = 0 this is linear

#plot the ellipso from line 10 and the corresponding plane on the other side

library(PlaneGeometry)
library(rgl)

eq <- EllipseFromEquation(A=8,B=16,C=50,D=-200, E=208, F=1)
border <- eq$boundingbox()
par(mfrow=c(1,2))
plot(NULL, xlim=border$x, ylim=border$y,  main="Ellipsoid using modified equation", xlab=NA, ylab=NA)
draw(eq, col = "purple", border= "orange")

plot3d(NULL,xlim = border$x, ylim=border$y, main="Plane in 3D", xlab=NA, ylab=NA)
par(new=TRUE)
planes3d(8,-16,50,99)