#Wstep do modelowania stochastycznego
#Agata 
#Katarzyna 
#Piotr 

#Projekt 2 
#zadanie 1

#Porównanie dystrybuanty z dystrybuant¹ odwrotn¹  

 x=seq(from=0, to=1, by=0.01)
 plot(x,2*asin(sqrt(x))/pi, type="l", lwd=2, ylab="F(x), F^-1(x)")
 lines(x,(sin(pi*x/2))^2, type="l", col="red", lwd=2)

#Generator licz pseudolosowych o rozk³adzie jednostajnym  runif()

#wyznaczamy wektor ( z dystrybuanty odwrotnej )

 w=sin(runif(1000,-1,1)*pi/2)^2
#porównanie wartoœci sredniej i var ze statystykami naszego wektora 
 mean(w)#1/2

 var(w)#1/8


#Histogram wraz z naniesion¹ funkcj¹ gestoœci 
 hist(w,20,prob=TRUE)
 x=seq(0,1,by=0.01)
 lines(x,1/(pi*sqrt(x*(1-x))),col="red",lwd=2)
 
# Dystrybuanta empiryczna z naniesion¹ dystrybuant¹ teoretyczn¹ F
 plot(ecdf(w),lwd=3)
 lines(x,2*asin(sqrt(x))/pi,col="red",lwd=2)
 

 #Próba o d³ugoœci 20
 x1<-c(1,2,5,2,1,1,5,2,5,1,2,8,9,1,2,1,1,1,2,5)
 
 #Próba uporz¹dkowana rosn¹co
 sort(x1)
 
 #Œrednia
 srednia1<-mean(x1)
 
 #Licznoœæ próby
 licznosc1<-table(x1)
 
 #Czêstoœæ próby
 czestosc1<-table(x1)/length(x1)
 
 #Przedstawienie graficzne liczebnoœci, czêstoœci i dystrybuanty
 par(mfrow=c(1,3))
 plot(licznosc1,main="Licznoœæ",ylab="n")
 plot(czestosc1,main="Czêstoœæ",ylab="P(X = x)")
 plot(ecdf(x1),main="Dystrybuanta")
 
 
 #Mediana z definicji oraz z wbudowanej funkcji
 sum(sort(x1)[c(10,11)])/2
 mediana1<-median(x1) 
 
 #Wariancja
 wariancja1<-var(x1)
 
 #Odchylenie standardowe
 odchylenie1<-sd(x1)
 
 
 
 
 ####Przyk³ad 2####
 
 #Próba o d³ugoœci 100
 x2<-rep(x1,5)[sample(1:100)]
 
 #Próba uporz¹dkowana rosn¹co
 sort(x2)
 
 #Œrednia
 srednia2<-mean(x2)
 
 #Licznoœæ próby
 licznosc2<-table(x2)
 
 #Czêstoœæ próby
 czestosc2<-table(x2)/length(x2)
 
 #Przedstawienie graficzne liczebnoœci, czêstoœci i dystrybuanty
 par(mfrow=c(1,3))
 plot(licznosc2,main="Licznoœæ",ylab="n")
 plot(czestosc2,main="Czêstoœæ",ylab="P(X = x)")
 plot(ecdf(x2),main="Dystrybuanta")
 
 
 #Mediana z definicji oraz z wbudowanej funkcji
 sum(sort(x2)[c(50,51)])/2
 mediana2<-median(x2) 
 
 #Wariancja
 wariancja2<-var(x2)
 
 #Odchylenie standardowe
 odchylenie2<-sd(x2)
 
 
 
 
 ####Porównanie danych z przyk³adu 1 i 2####
 
 #Porównanie graficzne
 par(mfrow=c(2,3))
 plot(licznosc1,main="Licznoœæ n=20",ylab="n")
 plot(czestosc1,main="Czêstoœæ n=20",ylab="P(X = x)")
 plot(ecdf(x1),main="Dystrybuanta n=20")
 plot(licznosc2,main="Licznoœæ n=100",ylab="n")
 plot(czestosc2,main="Czêstoœæ n=100",ylab="P(X = x)")
 plot(ecdf(x2),main="Dystrybuanta n=100")
 
 #porównanie w tabeli
 dane1<-c(srednia1,mediana1,wariancja1,odchylenie1)
 dane2<-c(srednia2,mediana2,wariancja2,odchylenie2)
 porownanie<-cbind(dane1,dane2)
 colnames(porownanie)<-c("Próba n=20","Próba n=100")
 rownames(porownanie)<-c("Œrednia","Mediana","Wariancja","Odchylenie standardowe")
 
 show(porownanie)
 
 
 
 
 
 
 
 
 #opisanie rozk³adu logarytmiczno-normalnego z parametrami
 #sigma=1/2
 s<-1/2
 #mi=1
 m<-1
 
 #badany przedzia³
 x<-seq(0.01,10,0.01)
 
 #funkcja gêstoœci o parametrach s-sigma oraz m-mi
 f<-function(x,s,m) (1/(sqrt(2*pi)*(s)*x))*exp(-(log(x)-m)^2/(2*(s)^2))
 
 #funkcja b³êdu Gaussa
 erf<-function(x) 2*pnorm(sqrt(2)*x)-1
 
 #dystrybuanta teoretyczna
 F<-function(x,s,m) 1/2+1/2*erf((log(x)-m)/(s*sqrt(2)))
 
 par(mfrow=c(1,1))
 #wykres gêstoœci i dystrybuanty
 plot(x,f(x,s,m), type="l", lwd=2, ylab="f(x)")  
 plot(x,F(x,s,m), type="l", lwd=2, ylab="F(x)")
 
 
 #####METODA ELIMINACJI#####
 
 #budowanie prostok¹ta zawieraj¹cego wykres gêstoœci
 xmin<-min(x)
 xmax<-max(x)
 ymin<-min(f(x,s,m))
 ymax<-max(f(x,s,m))
 
 #pole prostok¹ta
 poleM<-(xmax-xmin)*(ymax-ymin)
 
 #wygenerowanie wektora liczb pseudolosowych o danym rozk³adzie
 w=c()
 while(length(w)<1000){
   xn<-runif(1,0,poleM)/(ymax-ymin)+xmin
   yn<-runif(1,ymin,ymax)
   if(yn<=f(xn,s,m)){
     w<-append(w,xn)}
 }
 
 #####BADANIE WYGENEROWANEGO WEKTORA#####
 
 #wariancja wektora w oraz teoretyczna
 var(w)
 (exp((s)^2)-1)*exp(2*m+(s)^2)
 
 #œrednia wektora w oraz teoretyczna
 mean(w)
 exp(m)
 
 #porównanie histogramu z wykresem gêstoœci
 hist(w,40,prob=TRUE)
 lines(x,f(x,s,m), col="red", lwd=2)
 
 #porównanie dystrybuanty empirycznej z teoretyczn¹
 plot(ecdf(w),lwd=4)
 lines(x,F(x,s,m), col="red", lwd=2)
 
 
 
 
 