rm(list=ls())
graphics.off()

#Cosntant, coef x^1, coef x^2, coef x^3
coef1 <- c(1,2,3,4/8)
coef2 <- c(-100, 4,5, 2/3)

seq1_f = function(x){coef1[1] +coef1[2] * x + coef1[3] * x**2 + coef1[4] * x**3}
seq2_f = function(x){coef2[1] +coef2[2] * x + coef2[3] * x**2 + coef2[4] * x**3}


curve(seq1_f, from=-20, to=15, lwd=3, xlab='', ylab='', col='darkslateblue',xlim=c(-10,10),ylim=c(-100,150))
par(new=TRUE)
curve(seq2_f, from=-20, to=15, lwd=3, xlab='', ylab='', col='orange',xlim=c(-10,10),ylim=c(-100,150))

seq1 <- c()
seq2 <- c()
for(i in seq(-20,15,0.5))
{
  seq1 <- c(seq1, seq1_f(i))
  seq2 <- c(seq2, seq2_f(i))
}

save(seq1, seq2,file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\TD8\\data_DTW.RData")

seq1 <- c(2.5,4,5,8,9,12,13,11)
seq2 <- c(2,3,4,3,5,7,8,9,12)
plot(seq1, col=2, ylim=c(0,15),xlim=c(0,12)) 
par(new=TRUE)
plot(seq2, ylim=c(0,15),xlim=c(0,12))
save(seq1, seq2,file="C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\TD8\\data_DTW2.RData")
