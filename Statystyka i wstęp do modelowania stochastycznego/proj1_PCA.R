# Wnioskowanie w Wielowymiarowej Statystyce
# Projekt 1 Analiza PCA
# Agata  

library(rgl)
#install.packages('car')
library(car)


# Zad 1
dane <- read.table(file = './danePCA.csv',sep=';',header = TRUE) #zaladowanie danych z pliku csv
#wyswietlenie pierwszych 6 rekordow, wymiaru i charakterystyk kolumn
head(dane)
dim(dane)
str(dane)

X <-as.matrix(dane[,3:32]) #wybranie kolumn od 3 do 32 do analizy
X

# Zad 2
X_sr <- as.matrix(colMeans(X),nrow=30) #wektor srednich
X_sr
kow <- cov(X) #wektor kowariancji
kow
# Standaryzujemy dane i zapisujemy jako Y
Y <- (X - t(X_sr %*% matrix(rep(1,569),ncol=569)))%*%solve(sqrt(diag(diag(kow),ncol = 30,nrow = 30)))
Y

Y_sr <- as.matrix(colMeans(Y),nrow=30) #wektor srednich Y
Y_sr

S_y <- cov(Y) #macierz kowariancji Y
S_y

# Zad 3
#wyznaczenie wartosci i wektorow wlasnych macierzy S_y
eval <- eigen(S_y)$value; eval
evec <- eigen(S_y)$vector; evec

# Zad 4
tau <- eval/sum(eval) #proporcja wariancji
skum_tau <- cumsum(tau) #skumulowana proporcja
skum_tau

pc={} #wektor naglowkow
for (i in 1:30) {
  pc[i]=paste('PC',i) 
  
}

# wrzucamy informacje do tabeli
skladowe <- data.frame(wariancja = eval, proporcja_wariancji = tau, skumulowana_proporcja = skum_tau, row.names = pc)
skladowe

# zad 5

Z <- Y%*%evec # macierz skladowych glownych
z1 <- Y%*%evec[,1] # pierwsza skladowa glowna
z2 <- Y%*%evec[,2]  # druga skladowa glowna


#ilustracja wariancji skladowych glownych na wykresach osypiska

# dla wariancji bezwzglednej
plot(eval, type = "b", xlab="Sladowe glówne",ylab = "Wyjasniana wariancja", 
     main = "Wykres osypiska dla wariancji bezwzglednej")
abline(h=1,add=T, col='red')

# dla wariancji wzglednej

plot(tau, type = "b", xlab="Sladowe glówne",ylab = "Wariancja", 
     main = "Wykres osypiska dla wariancji wzglednej")


# zad 6

# Korelacja pomiedzy zmiennymi a skladowymi glownymi
r_1 <- cor(Y,z1)
r_2 <- cor(Y,z2)


# wykres korelacji pomiedzy zmiennymi a skladowymi glownymi wykreslone w kole

plot(r_1,r_2,xlim = c(-1,1),ylim = c(-1,1),xlab = "Pierwsza skladowa glowna",ylab = "Druga skladowa glowna",
     main = "Korelacja pomiedzy zmiennymi a skladowymi glownymi wykreslone w kole")
text(r_2~r_1,labels=c(1:30),cex=0.7,pos=3) #nadanie etykiet - numerow od 1 do 30
#rysujemy okrag o pr 1
curve(sqrt(1-x^2),-1,1,add = T)
curve(-sqrt(1-x^2),-1,1,add = T)

# Zad 7

# wykres skumulowanej proporcji
plot(cumsum(tau), type = "b", xlab="Sladowe glówne",ylab = "Wyjasniana wariancja", 
     main = "Wykres skumulowanej proporcji")

#rysujemy linie w ostatnim punkcie (ostatniej skladowej) gdzie wariancja przekracza 1
abline(h=cumsum(tau)[sum(skladowe$wariancja>1)], col='red') 
abline(v=sum(skladowe$wariancja>1), col='red')

# Zad 8

# wyznaczamy PC3
z3 <- Y%*%evec[,3]

#wykonujemy odpowiednio jedno-,dwu- i trójwymiarowe projekcje
par(mfrow=c(2,3))
stripchart(z1,xlab='PC1',main ='Projekcja na PC1')
stripchart(z2,xlab='PC2',main ='Projekcja na PC2')
stripchart(z3,xlab='PC3',main ='Projekcja na PC3')

plot(z1,z2,xlab='PC1',ylab='PC2',main ='Projekcja na PC1 i PC2')
plot(z1,z3,xlab='PC1',ylab='PC3',main ='Projekcja na PC1 i PC3')
plot(z2,z3,xlab='PC2',ylab='PC3',main ='Projekcja na PC2 i PC3')

plot3d(z1,z2,z3,xlim=c(-15,15),ylim=c(-15,15),zlim=c(-15,15), col = 'blue',
       xlab='PC1',ylab='PC2',zlab='PC3',main ='Projekcja na PC1,PC2 i PC3')



# Zad 9

#dodanie kolumny diagnosis
PC_lab<-data.frame(pc1=z1,pc2=z2,pc3=z3,diagnosis=dane$diagnosis);PC_lab

par(mfrow=c(3,1))
#projekcje jednowymiarowe z podzialem na zlosliwy M/lagodny B
stripchart(list(PC_lab$pc1[PC_lab$diagnosis=='M'],PC_lab$pc1[PC_lab$diagnosis=='B']),
           col = c('red','blue'),xlab='PC1',main ='Projekcja na PC1 w podziale na z³oœliwy 1 / ³agodny 2.')
stripchart(list(PC_lab$pc2[PC_lab$diagnosis=='M'],PC_lab$pc2[PC_lab$diagnosis=='B']),
           col = c('red','blue'),xlab='PC2',main ='Projekcja na PC2 w podziale na z³oœliwy 1 / ³agodny 2.')
stripchart(list(PC_lab$pc3[PC_lab$diagnosis=='M'],PC_lab$pc3[PC_lab$diagnosis=='B']),
           col = c('red','blue'),xlab='PC3',main ='Projekcja na PC3 w podziale na z³oœliwy 1 / ³agodny 2.')

par(mfrow=c(1,1))
# wykres rozproszenia z podzialem na zlosliwy M/lagodny B, projekcja PC1 i PC2

scatterplot(PC_lab$pc1,PC_lab$pc2,groups=PC_lab$diagnosis,col=c('blue','red'),regLine = F,
            smooth=F,xlim=c(-17,6),ylim = c(-10,13),xlab = 'PC1',ylab = 'PC2',
            main ='Projekcja obserwacji na PC1 i PC2 w podziale na z³oœliwy M / ³agodny B.',
            legend=list(coords='topright',columns=1,title=NULL))

# wykres rozproszenia z podzialem na zlosliwy M/lagodny B, projekcja PC1 i PC3

scatterplot(PC_lab$pc1,PC_lab$pc3,groups=PC_lab$diagnosis,col=c('blue','red'),regLine = F,
            smooth=F,xlim=c(-17,6),ylim = c(-10,13),xlab = 'PC1',ylab = 'PC3',
            main ='Projekcja obserwacji na PC1 i PC3 w podziale na z³oœliwy M / ³agodny B.',
            legend=list(coords='topright',columns=1,title=NULL))

# wykres rozproszenia z podzialem na zlosliwy M/lagodny B, projekcja PC2 i PC3

scatterplot(PC_lab$pc2,PC_lab$pc3,groups=PC_lab$diagnosis,col=c('blue','red'),regLine = F,
            smooth=F,xlim=c(-17,6),ylim = c(-10,13),xlab = 'PC2',ylab = 'PC3',
            main ='Projekcja obserwacji na PC2 i PC3 w podziale na z³oœliwy M / ³agodny B.',
            legend=list(coords='topright',columns=1,title=NULL))

# wykres rozproszenia z podzialem na zlosliwy M/lagodny B, projekcja PC1 i PC2
library(scatterplot3d)

colors <- c('red', 'blue')
colors <- colors[as.numeric(as.factor(PC_lab$diagnosis))]
scatterplot3d(PC_lab[,1:3],pch=16,color=colors,xlab = 'PC1',ylab = 'PC2',zlab='PC3',
            main ='Projekcja obserwacji na PC1,PC2 i PC3 w podziale na z³oœliwy M / ³agodny B.')


# wykres rozproszenia z podzialem na zlosliwy M/lagodny B z elipsa, PC1 i PC2
scatterplot(PC_lab$pc1,PC_lab$pc2,groups=PC_lab$diagnosis,col=c('blue','red'),regLine = F,
            smooth=F,xlim=c(-17,6),ylim = c(-10,13),xlab = 'PC1',ylab = 'PC2',
            main ='Projekcja obserwacji na PC1 i PC2 w podziale na z³oœliwy M / ³agodny B.',
            legend=list(coords='topright',columns=1,title=NULL))
#wyznaczenie srodka elipsy dla grupy M
center1<-c(mean(PC_lab[PC_lab$diagnosis=='M',1]),mean(PC_lab[PC_lab$diagnosis=='M',2])); center1
#wyznaczenie srodka elipsy dla grupy B
center2<-c(mean(PC_lab[PC_lab$diagnosis=='B',1]),mean(PC_lab[PC_lab$diagnosis=='B',2])); center2

#wyznaczenie pc1 i pc2 dla grupy M
z1M<-PC_lab[PC_lab$diagnosis=='M',1]
z2M<-PC_lab[PC_lab$diagnosis=='M',2]
#wyznaczenie pc1 i pc2 dla grupy B
z1B<-PC_lab[PC_lab$diagnosis=='B',1]
z2B<-PC_lab[PC_lab$diagnosis=='B',2]

#stala dla rownania elipsy
c=sqrt(qchisq(0.95,2));c

#wyznaczamy macierz kowariancji zmiennych z1 i z2 by znalezc ksztalt elipsy
kow_zB<-cov(cbind(z1B,z2B));kow_zB
kow_zM<-cov(cbind(z1M,z2M));kow_zM

#wykreslenie elips przy uzyciu macierzy kowariancji
ellipse(center2,shape = kow_zB,radius=c,add=T)
ellipse(center1,shape = kow_zM,radius=c,add=T, col = 'red')


###########################################################################

###########################################################################
# Wnioskowanie w Wielowymiarowej Statystyce
# Projekt 1 cz II - Analiza PCA z pakietow
# Agata 



#install.packages("factoextra")
library(factoextra)
library(stats)
library(ggpubr)


# Zad II 1

dane <- read.table(file = './danePCA.csv',sep=';',header = TRUE) #zaladowanie danych z pliku csv

#wyswietlenie pierwszych 6 rekordow, wymiaru i charakterystyk kolumn
head(dane)
dim(dane)
str(dane)

X <-as.matrix(dane[,3:32]) #wybranie kolumn od 3 do 32 do analizy
X


#implementacja PCA przy wykorzystaniu funkcji prcomp()
X_pca <- prcomp(X,center = T,scale = T,retx = T)
X_pca
summary(X_pca)

X_pca2 <- princomp(X,cor = T,scores = T)
X_pca2

#implementacja PCA przy wykorzystaniu funkcji PCA() z pakietu FactoMineR
#install.packages('FactoMineR')
library(FactoMineR)

X_pca3 <- PCA(X,scale.unit = T,ncp=30,graph = T)
X_pca3
summary(X_pca3)

#implementacja PCA przy wykorzystaniu funkcji dudi.pca() z pakietu ade4
#install.packages('ade4')
library(ade4)

X_pca4 <- dudi.pca(X,center =T,scale = T,scannf = F,nf = 30)
X_pca4
summary(X_pca4)

# Zad II 2

X_sr <- X_pca$center  #wektor srednich
D <- diag(X_pca$scale, ncol=30,nrow=30)      #macierz diagonalna z wariancjami na przekatnej

# Standaryzujemy dane i zapisujemy jako Y
Y <- (X - t(X_sr %*% matrix(rep(1,569),ncol=569)))%*%solve(D)
Y


#Zad II 3

# macierz wektorow wlasnych
evec <- X_pca$rotation
evec

#wektor wartosci wlasnych
eval <- get_eigenvalue(X_pca)$eigenvalue
eval
#Zad II 4

#podsumowanie zawierajace inf o bledzie standardowym, proporcji wariancji i skumulowanej proporcji
summary(X_pca)


pc={} #wektor naglowkow
for (i in 1:30) {
  pc[i]=paste('PC',i) 
  
}

#podsumowanie w tabeli zawierajace inf o wariancji, proporcji wariancji i skumulowanej proporcji
#korzystajac z funkcji get_eigenvalue()

skladowe <- data.frame(wariancja = get_eigenvalue(X_pca)$eigenvalue, 
                       proporcja_wariancji = get_eigenvalue(X_pca)$variance.percent/100, 
                       skumulowana_proporcja = get_eigenvalue(X_pca)$cumulative.variance.percent/100, 
                       row.names = pc)
skladowe

#Zad II 5

# wyznaczanie skladowych glownych
Z <- X_pca$x

z1 <- Z[,1]
z2 <- Z[,2]

#ilustracja wariancji skladowych glownych na wykresach osypiska

wyk_scree1 <-fviz_screeplot(X_pca, choice = c("eigenvalue") ,
                            geom = c('line'), ncp = 30 )
ggpubr::ggpar(wyk_scree1, main = "Wykres osypiska dla wariancji bezwzglednej",
              xlab = "Skladowe glowne", ylab = "Wyjasnianej wariancja",ylim = c(0,14) )+
  geom_hline(yintercept=1, linetype="dashed", color = "red") # czerwona linia na y=1


wyk_scree2 <-fviz_screeplot(X_pca, choice = c('variance'),
                            geom = c('line'), ncp = 30 )
ggpubr::ggpar(wyk_scree2, main = "Wykres osypiska dla wariancji bezwzglednej",
              xlab = "Skladowe glowne", ylab = "Procent wyjasnianej wariancja") 

# Zad II 6

# Korelacja pomiedzy zmiennymi a skladowymi glownymi
R <- get_pca_var(X_pca)$cor
r_1 <- get_pca_var(X_pca)$cor[,1]
r_2 <- get_pca_var(X_pca)$cor[,2]

# wykres korelacji pomiedzy zmiennymi a skladowymi glownymi wykreslone w kole

fviz_pca_var(X_pca, repel = T, col.var = 'black',
             geom = c('point','text'), 
             xlab = "Pierwsza skladowa glowna",ylab = "Druga skladowa glowna",
             title = "Korelacja pomiedzy zmiennymi a skladowymi glownymi wykreslone w kole")

# Zad II 7

# wykres skumulowanej proporcji
plot(get_eigenvalue(X_pca)[,3]/100, type = "b", xlab="Sladowe glówne",ylab = "Wyjasniana wariancja", 
     main = "Wykres skumulowanej proporcji")

#rysujemy linie w ostatnim punkcie (ostatniej skladowej) gdzie wariancja przekracza 1
abline(h=max(get_eigenvalue(X_pca)[get_eigenvalue(X_pca)[,1]>1,3])/100, col='red') 
abline(v=sum(get_eigenvalue(X_pca)[,1]>1), col='red')


# Zad II 8

#projekcje jednowymiarowe
stripchart(X_pca$x[,1],xlab='PC1',main ='Projekcja na PC1')
stripchart(X_pca$x[,2],xlab='PC2',main ='Projekcja na PC2')
stripchart(X_pca$x[,3],xlab='PC3',main ='Projekcja na PC3')

#projekcje dwuwymiarowe

fviz_pca_ind(X_pca, geom = c("point"),axes = c(1,2),xlab='PC1',ylab='PC2',title ='Projekcja na PC1 i PC2')
fviz_pca_ind(X_pca, geom = c("point"),axes = c(1,3),xlab='PC1',ylab='PC3',title ='Projekcja na PC1 i PC3')
fviz_pca_ind(X_pca, geom = c("point"),axes = c(2,3),xlab='PC2',ylab='PC3',title ='Projekcja na PC1 i PC2')

#projekcja trojwymiarowa
library(plotly)

scatter3d <- plot_ly(x = X_pca$x[,1], y = X_pca$x[,2], z = X_pca$x[,3]) %>%
  
  add_markers(size = 12)

tytul <- "Projekcja na PC1,PC2 i PC3"
scatter3d <- scatter3d %>%
  
  layout(
    
    title = tytul,
    scene = list(bgcolor = "#ffffff")
    
  )
scatter3d

# Zad II 9

# wyznaczenie grup na podstawie zmiennej diagnosis
groups <- as.factor(dane$diagnosis)

# wykres rozproszenia z podzialem na zlosliwy M/lagodny B, projekcja PC1 i PC2
wyk_diag12<-fviz_pca_ind(X_pca,
                         axes= c(1,2),
                         col.ind = groups, 
                         habillage = groups,
                         geom = c("point"),
                         palette = c("#00AFBB",  "#FC4E07"),
                         legend.title = "Diagnosis",
                         repel = T
)
ggpubr::ggpar(wyk_diag12, main = 'Projekcja obserwacji na PC1 i PC2 w podziale na z³oœliwy M / ³agodny B.',
              xlab = "PC1", ylab = "PC2")

# wykres rozproszenia z podzialem na zlosliwy M/lagodny B, projekcja PC1 i PC3
wyk_diag13<-fviz_pca_ind(X_pca,
                         axes= c(1,3),
                         col.ind = groups, 
                         habillage = groups,
                         geom = c("point"),
                         palette = c("#00AFBB",  "#FC4E07"),
                         legend.title = "Diagnosis",
                         repel = T
)
ggpubr::ggpar(wyk_diag13, main = 'Projekcja obserwacji na PC1 i PC3 w podziale na z³oœliwy M / ³agodny B.',
              xlab = "PC1", ylab = "PC3")


# wykres rozproszenia z podzialem na zlosliwy M/lagodny B, projekcja PC2 i PC3
wyk_diag23<-fviz_pca_ind(X_pca,
                         axes= c(2,3),
                         col.ind = groups, 
                         habillage = groups,
                         geom = c("point"),
                         palette = c("#00AFBB",  "#FC4E07"),
                         legend.title = "Diagnosis",
                         repel = T
)
ggpubr::ggpar(wyk_diag23, main = 'Projekcja obserwacji na PC1 i PC3 w podziale na z³oœliwy M / ³agodny B.',
              xlab = "PC2", ylab = "PC3")


# wykres rozproszenia z podzialem na zlosliwy M/lagodny B, projekcja PC1, PC2 i PC3

scatter3d <- plot_ly(x = X_pca$x[,1], y = X_pca$x[,2], z = X_pca$x[,3],
                     color = groups, colors = c("#00AFBB",  "#FC4E07")) %>%
  
  add_markers(size = 12)

tytul <- "Projekcja na PC1,PC2 i PC3"
scatter3d <- scatter3d %>%
  
  layout(
    
    title = tytul,
    scene = list(bgcolor = "#ffffff")
    
  )
scatter3d

# wykres rozproszenia z podzialem na zlosliwy M/lagodny B z elipsa, PC1 i PC2
wyk_diag<-fviz_pca_ind(X_pca,
                       axes = c(1,2),
                       col.ind = groups, 
                       habillage = groups,
                       geom = c("point"),
                       palette = c("#00AFBB",  "#FC4E07"),
                       addEllipses = TRUE, 
                       ellipse.level=0.95,
                       legend.title = "Diagnosis",
                       repel = T
)
ggpubr::ggpar(wyk_diag, main = 'Projekcja obserwacji na PC1 i PC2 w podziale na z³oœliwy M / ³agodny B.',
              xlab = "PC1", ylab = "PC2")


#biplot dla PC1 i PC2
wyk_diag2<-fviz_pca_biplot(X_pca,
                           col.ind = groups, 
                           habillage = groups,
                           geom = c("point"),
                           palette = c("#00AFBB",  "#FC4E07"),
                           addEllipses = TRUE, 
                           ellipse.level=0.95,
                           legend.title = "Diagnosis",
                           repel = T
)
ggpubr::ggpar(wyk_diag2, main = 'Projekcja obserwacji na PC1 i PC2 w podziale na z³oœliwy M / ³agodny B.',
              xlab = "PC1", ylab = "PC2")
