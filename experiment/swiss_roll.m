addpath('drtoolbox');
addpath('drtoolbox/techniques');

[X, labels] = generate_data('swiss', 500);

figure, scatter3(X(:,1), X(:,2), X(:,3), 5, labels); title('Swiss-Roll dataset'), drawnow

[mappedX, mapping] = compute_mapping(X, 'PCA', 2);	
figure, scatter(mappedX(:,1), mappedX(:,2), 5, labels); title('Result of PCA'); drawnow


[mappedX, mapping] = compute_mapping(X, 'Isomap', 2);	
figure, scatter(mappedX(:,1), mappedX(:,2), 5, labels(mapping.conn_comp)); title('Result of Isomap'); drawnow

[mappedX, mapping] = compute_mapping(X, 'LLE', 2);	
figure, scatter(mappedX(:,1), mappedX(:,2), 5, labels(mapping.conn_comp)); title('Result of LLE'); drawnow