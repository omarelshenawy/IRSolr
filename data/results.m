clc
clear all
close all

%% Get folder contents
cont = dir('results/');

search = cell(1, 14);
evaluations = cell(5, 14);
feat = 0;

q = 0;
for i = 1:length(cont)
  if (~cont(i).isdir)
    q = q + 1;
    search{q} = cont(i).name;
    %% Read file
    fid = fopen(['results/' cont(i).name]);
    tline = fgets(fid);
    while ischar(tline)
      if (length(tline) ~= 1)
        if (tline(end - 1) == ':')
          feat = 0;
          % We have the feature
          if (tline(1) == 'p')
            feat = 1;
          elseif (tline(1) == 'm')
            feat = 2;
          elseif (tline(1) == 'w')
            feat = 3;
          elseif (tline(1) == 'c')
            feat = 4;
          elseif (tline(1) == 'g')
            feat = 5;
          end
        else
          % We get the evaluations
          res = 0;
          evaluations{feat, q} = zeros(1, 30);
          doc = 0;
          for s = 1:(length(tline) - 1)
            if (tline(s) ~= ' ' && tline(s) ~= ',' && tline(s) ~= '0')
              doc = doc + 1;
              evaluations{feat, q}(doc) = 1;
            elseif (tline(s) == '0')
              doc = doc + 1;
            end
          end
        end
      end
      tline = fgets(fid);
    end
  end
end
relevant_total = 200;
%% We have the data. Time to make some graphs
% For every search, plot the precisions and recalls over num of docs for all
% features
features = {'phrase', 'multi word', 'weighted', 'color', 'geo-tagging'};

for q = 1:length(search)
  precision = figure;
  recall = figure;
  
  legend_names = {};
  leg = 0;
  for feat = 1:5
    if (~isempty(evaluations{feat, q}))
      leg = leg + 1;
      legend_names{leg} = features{feat};
      % Plot recall
      figure(recall);
      plot(1:30, cumsum(evaluations{feat, q}) / relevant_total)
      hold on
      
      % Plot precision
      figure(precision)
      plot(1:30, cumsum(evaluations{feat, q}) / 30)
      hold on
    end
  end
  figure(precision);
  grid
  xlabel('Results');
  ylabel('Precision');
  legend(legend_names, 'Location', 'northwest');
%   ylim([0 1]);
  title(['Precision over No. of results of "' search{q} '" using different features'])
  saveas(precision, ['results/new_graphs/' search{q} '_precision.jpg']);

  
  figure(recall);
  grid
  xlabel('Results');
  ylabel('Recall');
  legend(legend_names, 'Location', 'northwest');
%   ylim([0 1]);
  title(['Recall over No. of results of "' search{q} '" using different features'])
  saveas(recall, ['results/new_graphs/' search{q} '_recall.jpg']);
  close all
end

