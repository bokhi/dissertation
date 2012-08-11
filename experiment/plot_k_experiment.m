load ('k_result');

figure;
hold all;
plot (1:length(acc), maximum);
plot (1:length(acc), minimum);
plot (1:length(acc), average);

xlabel ('k');
ylabel ('accuracy');
legend ('maximum', 'minimum', 'average');

print -dpng k_result.png