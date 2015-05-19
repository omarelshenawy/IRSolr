clc
clear all

load_path = 'data/processed/';
save_path = 'data/crawled_proccesed/';

%% Get all filenames in path
dir_contents = dir(load_path);

num_of_files = length(dir_contents) - 2;
files_proc = 0;

for file = 1:num_of_files
  dir_contents(file + 2).name;
  doc = loadjson([load_path dir_contents(file + 2).name], 'SimplifyCell', 1);
  after = doc.add.doc.after;
  previous = doc.add.doc.previous;
  
  
  %% Work with after
  if (~isempty(after))
    if (iscell(after) || size(after, 1) >= 2)
      %% First turn matrix into cell
      if (ismatrix(after) && ~iscell(after))
        temp = after;
        after = {};
        rows = size(after, 1);
        for row = 1:rows
          after{row} = temp(row, :);
        end
      end
      after1 = {};
      for i = 1:length(after)
        % First remove all non-letters
        after{i} = regexprep(after{i},'[^a-zA-Z0-9]',' ');
        % Split the string based on whitespaces
        after1 = horzcat(after1, strsplit(after{i}));
      end
      entire_after = '';
      entire_after_ori = '';
      num_of_words = length(after1);
      weights = linspace(1, 0, num_of_words);
      for word = 1:num_of_words
        entire_after_ori = [entire_after_ori ' ' after1{word}];
        after1{word} = [after1{word} '|' num2str(weights(word))];
        entire_after = [entire_after ' ' after1{word}];
      end
      doc.add.doc.after_weights = entire_after;
      doc.add.doc.after = entire_after_ori;
    else
      % First remove all non-letters
      after = regexprep(after,'[^a-zA-Z0-9]',' ');
      % Split the string based on whitespaces
      entire_after = '';
      entire_after_ori = '';
      after = strsplit(after);
      num_of_words = length(after);
      weights = linspace(1, 0, num_of_words);
      for word = 1:num_of_words
        weight = weights(end - word + 1);
        entire_after_ori = [entire_after_ori ' ' after{word}];
        after{word} = [after{word} '|' num2str(weights(word))];
        entire_after = [entire_after ' ' after{word}];
      end
      doc.add.doc.after_weights = entire_after;
      doc.add.doc.after = entire_after_ori;
    end
    
  else
    doc.add.doc.after = ' ';
    doc.add.doc.after_weights = ' ';
  end
  
  %% Work with previous
  if (~isempty(previous))
    if (iscell(previous) || size(previous, 1) >= 2)
      %% First turn matrix into cell
      if (ismatrix(previous) && ~iscell(previous))
        temp = previous;
        previous = {};
        [rows ~] = size(previous);
        for row = 1:rows
          previous{row} = temp(row, :);
        end
      end
      previous1 = {};
      for i = 1:length(previous)
        % First remove all non-letters
        previous{i} = regexprep(previous{i},'[^a-zA-Z0-9]',' ');
        % Split the string based on whitespaces
        previous1 = horzcat(previous1, strsplit(previous{i}));
      end
      entire_previous = '';
      entire_previous_ori = '';
      num_of_words = length(previous1);
      weights = linspace(0, 1, num_of_words);
      for word = 1:num_of_words
        entire_previous_ori = [entire_previous_ori ' ' previous1{word}];
        previous1{word} = [previous1{word} '|' num2str(weights(word))];
        entire_previous = [entire_previous ' ' previous1{word}];
      end
      doc.add.doc.previous_weights = entire_previous;
      doc.add.doc.previous = entire_previous_ori;
    else
      % First remove all non-letters
      previous = regexprep(previous,'[^a-zA-Z0-9]',' ');
      % Split the string based on whitespaces
      entire_previous = '';
      entire_previous_ori = '';
      previous = strsplit(previous);
      num_of_words = length(previous);
      weights = linspace(0, 1, num_of_words);
      for word = 1:num_of_words
        entire_previous_ori = [entire_previous_ori ' ' previous{word}];
        previous{word} = [previous{word} '|' num2str(weights(word))];
        entire_previous = [entire_previous ' ' previous{word}];
        
      end
      doc.add.doc.previous_weights = entire_previous;
      doc.add.doc.previous = entire_previous_ori;
    end    
  else
    doc.add.doc.previous = ' ';
    doc.add.doc.previous_weights = ' ';
  end
  
  
  %% Save
  %   t = savejson('', doc, [load_path 'test.json']);
  t = savejson('', doc, [save_path dir_contents(file + 2).name]);
  files_proc = files_proc + 1;
  if (mod(files_proc, 1000) == 0)
    disp(['files processed: ' int2str(files_proc)])
  end
end