function[] = dibujar_funcion(f, rangox, rangoy, cantidad, puntosx, puntosy)
x = linspace(rangox(1), rangox(2), cantidad);  % create a 100x100 grid from -5 to 5
y = linspace(rangoy(1), rangoy(2), cantidad);
[X, Y] = meshgrid(x, y);   % create a meshgrid
for i = 1:cantidad
    for j = 1:cantidad
        Z(i, j) = f([x(i), y(j)]);
    end
end


colormap('jet');          
imagesc(y, x, Z);          
colorbar;                  
if length(puntosx) ~= 0
    hold on;
    n = numel(puntosx);
    plot(puntosx, puntosy, 'o', 'MarkerSize', 10, 'MarkerFaceColor', 'red', 'MarkerEdgeColor', 'black');
    hold on;


end
end