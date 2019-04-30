function [raw_data] = DataImporter(filename)
% Returns a vector from the JSON formatted data.
raw_data = importdata(filename);
raw_data = cell2mat(raw_data);
raw_data = str2num(raw_data)*10^3;
end

