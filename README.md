# Academic projects - portfolio
This repository contains my projects which I made during my studies. Projects written in R, python, sql, html.

Repozytorium zawiera wybrane projekty, które realizowałam w ramach niektórych przedmiotów na studiach licencjackich i magisterskich na kierunku matematyka.

## Opisy projektów

###  Bazy danych

Projekt jest podzielony na dwie części, z czego pierwsza była wykonana samodzielnie, a druga w parach.

W części I zaprojektowałam i stworzyłam przykładową bazę danych Muzeum  Historii Naturalnej obejmującą znajdujące się w muzeum eksponaty, bazę pomieszczeń, pracowników i odwiedzających.

[proj1_diagram.pdf](Bazy_danych/proj1_diagram.pdf)  zawiera diagram tejże bazy.

[proj1_widoki_funkcje_wyzwalacze.sql](Bazy_danych/proj1_widoki_funkcje_wyzwalacze.sql) zawiera kod w SQL tworzący wszystkie tabele i relacje, i część została wygenerowana w programie Oracle Data Modeler. Dalej w tym pliku umieściłam kod w SQL stworzony przeze mnie, gdzie wprowadzam przykładowe dane do tabel, tworzę przykładowe widoki realizujące konkretne potrzeby. zawiera także funkcje, np. funkcje sprawdzającą poprawność wpisywanego nr. PESEL oraz przykładowe wyzwalacze.

Plik [sql_procedury.sql](Bazy_danych/sql_procedury.sql) jest zbiorem przykładowych funkcji i procedur napisanych w SQL. Zadanie było wykonane w grupie dwuosobowej i jest niezależny od powyższych zadań.

W pliku [sql_wyzwalacze.sql](Bazy_danych/sql_wyzwalacze.sql) znajdują się różnego typu wyzwalacze, które zostały napisane w grupie dwuosobowej.


### Eksploracje internetu

W ramach przedmiotu wykonałam kilka drobnych projektów, które miały na celu stworzenie prostych stron internetowych.

[html5_css](eksploracja_internetu/html5_css) to prosta strona internetowa napisane przeze mnie w HTML.  W celu obejrzenia rezultatu należy pobrać wszystkie pliki.

[javascript1](eksploracja_internetu/javascript1)  to strona internetowa, na której dzięki JavaScript, obliczana jest objętość bryły o wymiarach podanych przez użytkownika.  W celu obejrzenia rezultatu należy pobrać wszystkie pliki.

[javascript2](eksploracja_internetu/javascript2) (zadanie wykonywane w grupie) to strona internetowa, na której dzięki JavaScript,  można zmodyfikować tabelę filmów oraz  zobaczyć wyliczenia pewnych podstawowych statystyk dotyczących danych zawartych w tabeli. W celu obejrzenia rezultatu należy pobrać wszystkie pliki.

###  Analizy epidemiologiczne

W tym folderze znajdują się projekty wykonywane w ramach przedmiotu Analizy epidemiologiczne i prognozy medyczne. Programy są napisane w pythonie i były tworzone w grupach 3-osobowych.

[Projekt1](Analizy_epidemiologiczne/Projekt1_średnia_ruchoma.ipynb) zastosowanie średniej ruchomej do prognozowania zachorowań na covid-19 w Polsce.

[Projekt2](Analizy_epidemiologiczne/Projekt2_model_Lotki_Volterry.ipynb) jakościowa analiza równania różniczkowego model Lotki Volterry.

[Projekt3](Analizy_epidemiologiczne/Projekt3_prognoza_Covid.ipynb) prognozowanie zachorowań na covid-19 przy zastosowaniu modelu deterministycznego SIR z uwzględnieniem wskaźnika szczepień.

###  Statystyka i modelowanie stochastyczne

Projekty realizowane w ramach przedmiotów statystyka, wstęp do modelowania stochastycznego, wnioskowanie w wielowymiarowej statystyce. Wszystkie programy zostały napisane w języku R, a część z nich załączam jako raport w Markdown.

[wms_punkty_stale.r](Statystyka_i_modelowanie_stochastyczne/wms_projekt_punkty_stale.r) kod w R, w programie badane są punkty stałe danej funkcji.

[wms_generatory.r](Statystyka_i_modelowanie_stochastyczne/wms_projekt2_generatory.R) kod w R, generatory liczb pseudolosowych utworzone metodą odwrotnej dystrybuanty dla rozkładów ciągłych i dyskretnych oraz generowanie liczb metodą eliminacji.

[symulacja_zad_prawdop](Statystyka_i_modelowanie_stochastyczne/symulacja_zad_prawdop.md) raport w Markdownie; symulacja rozwiązania zadania z rachunku prawdopodobieństwa polegającego na policzeniu prawdopodobieństwa trafienia w tarczę w dwóch rzutach.

[generatory](Statystyka_i_modelowanie_stochastyczne/generatory.md) raport w Markdownie; generatory liczb pseudolosowych z rozkładu normalnego z wykorzystaniem Centralnego Twierdzenia Granicznego oraz algorytmu Boxa-Mullera i badanie ich różnic.

[proj1_PCA](Statystyka_i_modelowanie_stochastyczne/proj1_PCA.R) kod w R; przeprowadzenie analizy składowych głównych, w pierwszej części z wykorzystaniem podstawowych obliczeń matematycznych, a w drugiej części wykorzystując gotowy pakiet przeznaczony do PCA w R.

[k-srednich.Rmd](Statystyka_i_modelowanie_stochastyczne/k-srednich.Rmd)  raport w R Markdown; badanie istotności założeń algorytmu k-średnich oraz zastosowanie go do kompresji obrazu. Aby zobaczyć wyniki programu należy ściągnąć go oraz plik dane_zad1.csv lub można zobaczyć też raport pod linkiem https://rpubs.com/Agata99/kmeans 

[logistyczny model wzrostu.Rmd](Statystyka_i_modelowanie_stochastyczne/logistyczny model wzrostu.Rmd)  raport w R Markdown, projekty realizowany w parach;  raport zawiera opis i porównanie modelu deterministycznego (równanie różniczkowe) oraz losowego. Aby zobaczyć wyniki programu należy ściągnąć go lub można zobaczyć też raport pod linkiem https://rpubs.com/Agata99/logistic_growth

[monte Carlo.Rmd](Statystyka_i_modelowanie_stochastyczne/monte Carlo.Rmd) raport w R Markdown;  porównanie całkowania numerycznego metodami Riemanna oraz metodą Monte Carlo, ulepszenie metody Monte Carlo za pomocą zmiennych antytetycznych. Aby zobaczyć wyniki programu należy ściągnąć go lub można zobaczyć też raport pod linkiem https://rpubs.com/Agata99/MonteCarlo

###  Algorytmy grafowe

Projekt realizowany w parach na przedmiocie Grafowe Prezentacji Danych, napisany w R.

Plik [komiwojażer](Algorytmy_grafowe/komiwojazer.Rmd) zawiera raport projektu. Zadanie polegało na znalezieniu najkrótszej ścieżki przechodzącej przez wszystkie punkty na mapie, zatem na rozwiązaniu problemu komiwojażera. W raporcie opisano problem i zastosowany algorytm, zaimplementowano kod oraz zapisano wyniki. Aby zobaczyć wyniki programu należy ściągnąć go wraz z wszystkimi  obrazkami lub można zobaczyć też raport pod linkiem https://rpubs.com/Agata99/TSP


