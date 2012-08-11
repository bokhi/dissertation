load ('k_result');

figure;
hold all;
plot (1:length(acc), max);
plot (1:length(acc), min);
plot (1:length(acc), mean);

xlabel ('k');
ylabel ('accuracy');
legend ('max', 'min', 'mean');

print -dpng k_result.png