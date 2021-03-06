clc; clear all; close all;
%---------PUNTO 1------------------------------------------
imagen=imread('imagendeprueba.bmp');
imagenruidoGaus = double(imnoise(imagen,'gaussian',0,0.02))/255;
%---------PUNTO 2 Ruido Gaussiano---------------------------
%Suavizado por Media
mascaraMedia=fspecial('average',[3,3]);
    imagen1(:,:,1)=conv2(imagenruidoGaus(:,:,1),mascaraMedia,'same'); %Same quita bordes negros
    imagen1(:,:,2)=conv2(imagenruidoGaus(:,:,2),mascaraMedia,'same'); %Same quita bordes negros
    imagen1(:,:,3)=conv2(imagenruidoGaus(:,:,3),mascaraMedia,'same'); %Same quita bordes negros
%Suavizado por Mascara Gaussiana
mascaraGussiana=fspecial('gaussian',[13,13],2);
    imagen2(:,:,1)=conv2(imagenruidoGaus(:,:,1),mascaraGussiana,'same'); %Same quita bordes negros
    imagen2(:,:,2)=conv2(imagenruidoGaus(:,:,2),mascaraGussiana,'same'); %Same quita bordes negros
    imagen2(:,:,3)=conv2(imagenruidoGaus(:,:,3),mascaraGussiana,'same'); %Same quita bordes negros
%Filtro de mediana      
ventana=[1 1 1;1 1 1;1 1 1];       
    imagen3(:,:,1)=ordfilt2(imagenruidoGaus(:,:,1),5,ventana);
    imagen3(:,:,2)=ordfilt2(imagenruidoGaus(:,:,2),5,ventana);
    imagen3(:,:,3)=ordfilt2(imagenruidoGaus(:,:,3),5,ventana);
%Filtro de minimo       
    imagen4(:,:,1)=ordfilt2(imagenruidoGaus(:,:,1),1,ventana);
    imagen4(:,:,2)=ordfilt2(imagenruidoGaus(:,:,2),1,ventana);
    imagen4(:,:,3)=ordfilt2(imagenruidoGaus(:,:,3),1,ventana);
% impresion por pantalla
        figure(1), subplot(3,2,1),imshow(imagenruidoGaus),title('Imagen Contaminada: Ruido Gausiano')
        subplot(3,2,2),imshow(imagen1),title('Imagen Filtrada: mascara media')
        subplot(3,2,3),imshow(imagen2),title('Imagen Filtrada: mascara Gaussiana')
        subplot(3,2,4),imshow(imagen3),title('Imagen Filtrada: Filtro de Mediana')
        subplot(3,2,5),imshow(imagen4),title('Imagen Filtrada: Filtro de minimos')
        subplot(3,2,6),imshow(imagen),title('Imagen Original')

%---------PUNTO 4 Sal y Pimienta------------------------------
imagenTR=imread('imagendeprueba.bmp');
imagenTRGray=rgb2gray(imagenTR);
imagenruidoSalyPim = double(imnoise(imagenTRGray,'salt & pepper',0.15))/255;
%---------PUNTO 5 Sal y Pimienta------------------------------
%Suavizado por Media
mascaraMedia2=fspecial('average',[5,5]);
    imagenSalyPimMedia=conv2(imagenruidoSalyPim,mascaraMedia2,'same'); %Same quita bordes negros
%Suavizado por Mascara Gaussiana
mascaraGussiana2=fspecial('gaussian',[13, 13],2);
    imagenSalyPimGaus=conv2(imagenruidoSalyPim,mascaraGussiana2,'same');
%Filtro de mediana       
    imagenSalyPimMediana=ordfilt2(imagenruidoSalyPim,13,ones(5));
%Filtro de minimo 
    imagenSalyPimMaximo=ordfilt2(imagenruidoSalyPim,1,ones(5));
    figure(2), subplot(3,2,1),imshow(imagenruidoSalyPim),title('Imagen Contaminada: Sal y Pimienta')
    subplot(3,2,2),imshow(imagenSalyPimMedia),title('Imagen Filtrada: mascara media')
    subplot(3,2,3),imshow(imagenSalyPimGaus),title('Imagen Filtrada: mascara Gaussiana')
    subplot(3,2,4),imshow(imagenSalyPimMediana),title('Imagen Filtrada: Filtro de Mediana')
    subplot(3,2,5),imshow(imagenSalyPimMaximo),title('Imagen Filtrada: Filtro de minimos')
    subplot(3,2,6),imshow(imagenTRGray),title('Imagen Original')

% % % % %  Ruido periodico
imagenRP=imread('filter_fftdenoise_before.jpg');
imagenRPn=double(imagenRP)/255;
figure(101),imshow(imagenRPn);,title('Imagen Original');
ventana=[
    0	0	0	0	1;
    0   0	0	1	0;
    0	0	1	0	0;
    0	1	0	0	0;
    1	0	0	0	0
    ]/5
imagenRPmedia=conv2(imagenRPn,ventana,'same');
figure(102),imshow(imagenRPmedia);title('ImagenFiltrada: Mascara de la media');


