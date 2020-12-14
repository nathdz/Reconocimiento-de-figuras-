//Macro Sistemas de Visión: Identificación de figuras//
//Natalia Hernández Ramos

//Fase 1: Pre-procesamiento
macro "Macro Sistemas de Visión [q]"{
open();
run("Split Channels"); //Separa la imagen en los tres canales RGB
waitForUser ("Selecciona el plano de color"); //Nos permite seleccionar el plano de color con el que queremos trabajar
run("Gaussian Blur...", "sigma=1"); //Aplica un filtro de desenfoque gaussiano para la reducción de ruido en la imagen
setAutoThreshold("Triangle"); //Inicia el proceso de umbralización
//run("Threshold...");
setAutoThreshold("Default");
setThreshold(0, 87); //Valores utilizados para la umbralización
setOption("BlackBackground", false);

//Fase 2: Segmentación o identificación de figuras
run("Convert to Mask"); //Convierte la imagen a tipo binario
run("Find Edges"); //Encuentra los bordes de la imagen sustituyendo al filtro laplaciano
run("Convert to Mask"); 
run("Hough Circle Transform"); //Aplica la transformada de Hough
run("Hough Circle Transform","minRadius=10, maxRadius=100, inc=1, minCircles=1, maxCircles=65535, threshold=0.5, resolution=656, ratio=1.0, bandwidth=10, local_radius=10,  reduce show_mask show_centroids show_scores results_table"); //Parámetros utilizados para la transformada de Hough
selectWindow("Centroid overlay");
selectWindow("Centroid map");

//Fase 3: Análisis de partícula
waitForUser ("Selecciona imagen a analizar"); //Nos permite seleccionar la imagen a la que queremos aplicar análisis de partícula
run("Analyze Particles...", "  show=[Overlay Masks] display exclude clear include summarize add in_situ"); //Parámetros del análisis de partícula
}