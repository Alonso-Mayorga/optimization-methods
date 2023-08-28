function[] = dibujar_funcion2(f, rangox, rangoy, cantidad)
x = linspace(rangox(1), rangox(2), cantidad); 
y = linspace(rangoy(1), rangoy(2), cantidad);
[X, Y] = meshgrid(x, y);   % create a meshgrid
for i = 1:cantidad
    for j = 1:cantidad
        Z(i, j) = f([x(i), y(j)]);
    end
Z;

colormap('jet');           % set the colormap to "hot"
imagesc(x, y, Z);          % plot the function
colorbar;                  % add a colorbar to the plot
end