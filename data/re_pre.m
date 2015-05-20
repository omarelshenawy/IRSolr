%% calculate precision and recall for different searches
search = 'RedFlower';
relevant_total = 100;
phrase = [
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
];
multi = [
0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
];
weights = [
0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
];
color = [
0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
];
% geo = [
% 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 0, 18, 19, 20, 21, 0, 23, 24, 25, 26, 27, 28, 29
% ];
%% PHRASE
num = 30;
type = 'phrase';
recall = zeros(1, num);
relevant = 0;
Recall = 0;
precision = zeros(1, num);
Precision = 0;
for i = 1:num
  if phrase(i) ~= 0
    relevant = relevant + 1;
  end
  precision(i) = relevant / i;
  recall(i) = relevant / relevant_total;
end
Precision = relevant / num;
Recall = relevant / relevant_total;
fig = figure;
plot(recall, precision)
title(['Precision - Recall curve for the phrase search of "' search '"'])
xlabel('Recall');
ylabel('Precision');
xlim([0 1]);
ylim([0 1]);
saveas(fig, ['graphs/' search '_R_P_phrase.jpg']);
close

fig = figure;
plot(1:num, recall);
hold on
xlabel('Results');
ylabel('Recall');
ylim([0 1]);
title(['Recall over No. of results for the phrase search of "' search '"'])
text(num, recall(num), ['Final Recall = ' num2str(Recall)], 'HorizontalAlignment', 'right')
saveas(fig, ['graphs/' search '_R_phrase.jpg']);
close

fig = figure;
plot(1:num, precision);
hold on
xlabel('Results');
ylabel('Precision');
ylim([0 1]);
title(['Precision over No. of results for the phrase search of "' search '"'])
text(num, precision(num), ['Final Precision = ' num2str(Precision)], 'HorizontalAlignment', 'right')
saveas(fig, ['graphs/' search '_P_phrase.jpg']);
close

%% MULTI
num = 30;
type = 'multi';
recall = zeros(1, num);
relevant = 0;
Recall = 0;
precision = zeros(1, num);
Precision = 0;
for i = 1:num
  if multi(i) ~= 0
    relevant = relevant + 1;
  end
  precision(i) = relevant / i;
  recall(i) = relevant / relevant_total;
end
Precision = relevant / num;
Recall = relevant / relevant_total;
fig = figure;
plot(recall, precision)
title(['Precision - Recall curve for the multi word search of "' search '"'])
xlabel('Recall');
ylabel('Precision');
xlim([0 1]);
ylim([0 1]);
saveas(fig, ['graphs/' search '_R_P_multi.jpg']);
close

fig = figure;
plot(1:num, recall);
hold on
xlabel('Results');
ylabel('Recall');
ylim([0 1]);
title(['Recall over No. of results for the multi word search of "' search '"'])
text(num, recall(num), ['Final Recall = ' num2str(Recall)], 'HorizontalAlignment', 'right')
saveas(fig, ['graphs/' search '_R_phrase.jpg']);
close

fig = figure;
plot(1:num, precision);
hold on
xlabel('Results');
ylabel('Precision');
ylim([0 1]);
title(['Precision over No. of results for the multi word search of "' search '"'])
text(num, precision(num), ['Final Precision = ' num2str(Precision)], 'HorizontalAlignment', 'right')
saveas(fig, ['graphs/' search '_P_multi.jpg']);
close

%% WEIGHTS
num = 30;
type = 'weights';
recall = zeros(1, num);
relevant = 0;
Recall = 0;
precision = zeros(1, num);
Precision = 0;
for i = 1:num
  if weights(i) ~= 0
    relevant = relevant + 1;
  end
  precision(i) = relevant / i;
  recall(i) = relevant / relevant_total;
end
Precision = relevant / num;
Recall = relevant / relevant_total;
fig = figure;
plot(recall, precision)
title(['Precision - Recall curve for the weighted search of "' search '"'])
xlabel('Recall');
ylabel('Precision');
xlim([0 1]);
ylim([0 1]);
saveas(fig, ['graphs/' search '_R_P_weights.jpg']);
close

fig = figure;
plot(1:num, recall);
hold on
xlabel('Results');
ylabel('Recall');
ylim([0 1]);
title(['Recall over No. of results for the weighted search of "' search '"'])
text(num, recall(num), ['Final Recall = ' num2str(Recall)], 'HorizontalAlignment', 'right')
saveas(fig, ['graphs/' search '_R_weights.jpg']);
close

fig = figure;
plot(1:num, precision);
hold on
xlabel('Results');
ylabel('Precision');
ylim([0 1]);
title(['Precision over No. of results for the weighted search of "' search '"'])
text(num, precision(num), ['Final Precision = ' num2str(Precision)], 'HorizontalAlignment', 'right')
saveas(fig, ['graphs/' search '_P_weights.jpg']);
close


%% COLOR
num = 30;
type = 'color';
recall = zeros(1, num);
relevant = 0;
Recall = 0;
precision = zeros(1, num);
Precision = 0;
for i = 1:num
  if color(i) ~= 0
    relevant = relevant + 1;
  end
  precision(i) = relevant / i;
  recall(i) = relevant / relevant_total;
end
Precision = relevant / num;
Recall = relevant / relevant_total;
fig = figure;
plot(recall, precision)
title(['Precision - Recall curve for the color search of "' search '"'])
xlabel('Recall');
ylabel('Precision');
xlim([0 1]);
ylim([0 1]);
saveas(fig, ['graphs/' search '_R_P_color.jpg']);
close

fig = figure;
plot(1:num, recall);
hold on
xlabel('Results');
ylabel('Recall');
ylim([0 1]);
title(['Recall over No. of results for the color search of "' search '"'])
text(num, recall(num), ['Final Recall = ' num2str(Recall)], 'HorizontalAlignment', 'right')
saveas(fig, ['graphs/' search '_R_color.jpg']);
close

fig = figure;
plot(1:num, precision);
hold on
xlabel('Results');
ylabel('Precision');
ylim([0 1]);
title(['Precision over No. of results for the color search of "' search '"'])
text(num, precision(num), ['Final Precision = ' num2str(Precision)], 'HorizontalAlignment', 'right')
saveas(fig, ['graphs/' search '_P_color.jpg']);
close

% %% GEO
% num = 30;
% type = 'geo';
% recall = zeros(1, num);
% relevant = 0;
% Recall = 0;
% precision = zeros(1, num);
% Precision = 0;
% for i = 1:num
%   if color(i) ~= 0
%     relevant = relevant + 1;
%   end
%   precision(i) = relevant / i;
%   recall(i) = relevant / relevant_total;
% end
% Precision = relevant / num;
% Recall = relevant / relevant_total;
% fig = figure;
% plot(recall, precision)
% title(['Precision - Recall curve for the geo-tagging search of "' search '"'])
% xlabel('Recall');
% ylabel('Precision');
% xlim([0 1]);
% ylim([0 1]);
% saveas(fig, ['graphs/' search '_R_P_geo.jpg']);
% close
% 
% fig = figure;
% plot(1:num, recall);
% hold on
% xlabel('Results');
% ylabel('Recall');
% ylim([0 1]);
% title(['Recall over No. of results for the geo-tagging search of "' search '"'])
% text(num, recall(num), ['Final Recall = ' num2str(Recall)], 'HorizontalAlignment', 'right')
% saveas(fig, ['graphs/' search '_R_geo.jpg']);
% close
% 
% fig = figure;
% plot(1:num, precision);
% hold on
% xlabel('Results');
% ylabel('Precision');
% ylim([0 1]);
% title(['Precision over No. of results for the geo-tagging search of "' search '"'])
% text(num, precision(num), ['Final Precision = ' num2str(Precision)], 'HorizontalAlignment', 'right')
% saveas(fig, ['graphs/' search '_P_geo.jpg']);
% close
