## Wst�p do modelowania stochastycznego
## Projekt 1
## Agata 
## Katarzyna 
## Piotr 


# Badanie punktow stalych - kod programu

#okre�lenie dziedziny funkcji
x<-seq(0,1,0.001)

#okre�lenie i narysowanie funkcji
f <- function(x) {1+4*x*(x-1)
}
plot(x,f(x),col='blue',type='l',)

#wyliczenie punkt�w sta�ych
x0<-x[which(f(x)==x)]

#graficzne przedstawienie punkt�w sta�ych
lines(x,x,col='gray')
points(x0,f(x0),col='red')
text(x0,f(x0),c(x0[1],x0[2]), pos=1, col='red')

#wyznacza macierz trajektorii dla wielu warunk�w pocz�tkowych jednocze�nie
traj = function(N){
       macierz = matrix(0,N,1000) # 1000 kolumn dla 1000 punkt�w pocz�tkowych
       
         macierz[1,] = seq(0.001,1,0.001) # wektor punkt�w pocz�tkowych
        
          for(j in 1:1000){
               for(i in 1:(N-1)){
                   macierz[i+1,j] = f(macierz[i,j])
                 }
             }
         macierz
}
#ustawia maksymaln� liczb� iteracji na 1000
N<-1000


#rysuje histogramy dla punktu p0=0.249
p0<-0.249 
p<-which(traj(N)[1,]==p0)#wylicznie miejsca punktu w macierzy

par(mfrow = c(1,3))
h10<-hist(traj(N)[1:10,p],breaks=seq(min(traj(N)), max(traj(N)), length.out = ceiling(sqrt(N))+1),freq=TRUE,main = paste("Histogram trajektorii dla i=1:10"),xlab="Cz�sto�� kumulacyjna po 10-tej iteracji")
h100<-hist(traj(N)[1:100,p],breaks=seq(min(traj(N)), max(traj(N)), length.out = ceiling(sqrt(N))+1),freq=TRUE,main = paste("Histogram trajektorii dla i=1:100"),xlab="Cz�sto�� kumulacyjna po 100-tej iteracji")
h1000<-hist(traj(N)[1:1000,p],breaks=seq(min(traj(N)), max(traj(N)), length.out = ceiling(sqrt(N))+1),freq=TRUE,main = paste("Histogram trajektorii dla i=1:1000"),xlab="Cz�sto�� kumulacyjna po 1000-tej iteracji")


#rysuje histogramy dla punktu p0=0.25
p0<-0.25 
p<-which(traj(N)[1,]==p0)#wylicznie miejsca punktu w macierzy

par(mfrow = c(1,3))
h10<-hist(traj(N)[1:10,p],breaks=seq(min(traj(N)), max(traj(N)), 
length.out = ceiling(sqrt(N))+1),freq=TRUE,main = paste("Histogram trajektorii dla i=1:10"),
xlab="Cz�sto�� kumulacyjna po 10-tej iteracji")
h100<-hist(traj(N)[1:100,p],breaks=seq(min(traj(N)), max(traj(N)),
length.out = ceiling(sqrt(N))+1),freq=TRUE,main = paste("Histogram trajektorii dla i=1:100"),
xlab="Cz�sto�� kumulacyjna po 100-tej iteracji")
h1000<-hist(traj(N)[1:1000,p],breaks=seq(min(traj(N)), max(traj(N)), 
length.out = ceiling(sqrt(N))+1),freq=TRUE,main = paste("Histogram trajektorii dla i=1:1000"),
xlab="Cz�sto�� kumulacyjna po 1000-tej iteracji")

#rysuje histogramy dla punktu p0=0.251
p0<-0.251 
p<-which(traj(N)[1,]==p0)#wylicznie miejsca punktu w macierzy

par(mfrow = c(1,3))
h10<-hist(traj(N)[1:10,p],breaks=seq(min(traj(N)), max(traj(N)), 
length.out = ceiling(sqrt(N))+1),freq=TRUE,main = paste("Histogram trajektorii dla i=1:10"),
xlab="Cz�sto�� kumulacyjna po 10-tej iteracji")
h100<-hist(traj(N)[1:100,p],breaks=seq(min(traj(N)), max(traj(N)), 
length.out = ceiling(sqrt(N))+1),freq=TRUE,main = paste("Histogram trajektorii dla i=1:100"),
xlab="Cz�sto�� kumulacyjna po 100-tej iteracji")
h1000<-hist(traj(N)[1:1000,p],breaks=seq(min(traj(N)), max(traj(N)), 
length.out = ceiling(sqrt(N))+1),freq=TRUE,main = paste("Histogram trajektorii dla i=1:1000"),
xlab="Cz�sto�� kumulacyjna po 1000-tej iteracji")



#rysuje histogramy dla wielu warunk�w pocz�tkowych jednocze�nie
par(mfrow = c(2,3))
h10<-hist(traj(N)[1:10,],breaks=seq(min(traj(N)), max(traj(N)), length.out = ceiling(sqrt(N))+1),freq=TRUE,
main = paste("Histogram trajektorii dla i=1:10"),xlab="Cz�sto�� kumulacyjna po 10-tej iteracji")
h100<-hist(traj(N)[1:100,],breaks=seq(min(traj(N)), max(traj(N)), length.out = ceiling(sqrt(N))+1),freq=TRUE,
main = paste("Histogram trajektorii dla i=1:100"),xlab="Cz�sto�� kumulacyjna po 100-tej iteracji")
h1000<-hist(traj(N)[1:1000,],breaks=seq(min(traj(N)), max(traj(N)), length.out = ceiling(sqrt(N))+1),freq=TRUE,
main = paste("Histogram trajektorii dla i=1:1000"),xlab="Cz�sto�� kumulacyjna po 1000-tej iteracji")

#rysuje wykresy g�sto�ci dla wielu warunk�w pocz�tkowych jednocze�nie
g10<-hist(traj(N)[1:10,],breaks=seq(min(traj(N)), max(traj(N)), length.out = ceiling(sqrt(N))+1),prob=T,ylim=c(0,4),
main = paste("Wykres g�sto�ci dla i=1:10"),xlab="G�sto�� po 10 iteracjach")
lines(x,1/(pi*sqrt(x*(1-x))),col="blue")
g100<-hist(traj(N)[1:100,],breaks=seq(min(traj(N)), max(traj(N)), length.out = ceiling(sqrt(N))+1),prob=T,ylim=c(0,4),
main = paste("Wykres g�sto�ci dla i=1:100"),xlab="G�sto�� po 100 iteracjach")
lines(x,1/(pi*sqrt(x*(1-x))),col="blue")
g1000<-hist(traj(N)[1:1000,],breaks=seq(min(traj(N)), max(traj(N)), length.out = ceiling(sqrt(N))+1),prob=T,ylim=c(0,4),
main = paste("Wykres g�sto�ci dla i=1:1000"),xlab="G�sto�� po 1000 iteracjach")
lines(x,1/(pi*sqrt(x*(1-x))),col="blue")

#przedstawia histogram, wykres g�sto��i oraz dystrybuant� empiryczn� dla 1000 iteracji
par(mfrow = c(1,3))
h1000<-hist(traj(N)[1:1000,],breaks=seq(min(traj(N)), max(traj(N)), length.out = ceiling(sqrt(N))+1),freq=TRUE,
main = paste("Histogram trajektorii dla i=1:1000"),xlab="Cz�sto�� kumulacyjna po 1000-tej iteracji")
g1000<-hist(traj(N)[1:1000,],breaks=seq(min(traj(N)), max(traj(N)), length.out = ceiling(sqrt(N))+1),prob=T,ylim=c(0,4),
main = paste("Wykres g�sto�ci dla i=1:1000"),xlab="G�sto�� po 1000 iteracjach")
lines(x,1/(pi*sqrt(x*(1-x))),col="blue")
d1000<-plot(ecdf(traj(10)[1:1000]),main="Dystrybuanta empiryczna dla i=1:1000")
