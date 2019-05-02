function [code, str] = IndexMapper(frequencies, returnKey, startF, marginF)
  n = 0:9;
  numbers = [n n n n n n];
  frequencies = round(frequencies, 2);
  amountOfFrequencies = 60;
  startF = startF;
  endF = startF+marginF*(amountOfFrequencies-1);
  endF = endF;
  possible_frequencies = (startF:marginF:endF)/1000;
  indexes = [];
  number = [];
  ii = 1;
  if strcmp(returnKey, 'code')
    for ii = 1:length(frequencies)
      index = find(possible_frequencies == frequencies(ii));
      if (length(index) == 0)
        index = 1;
      end
      number(ii) = numbers(index);
    end
    code = strjoin(string(number));
  else
    code = frequencies*marginF + (startF:10*marginF:endF);
    str = strjoin(string(frequencies));
    disp('Code ' + strjoin(string(frequencies)) +' hashed to frequencies:')
    disp(num2str(code))
    disp(' ')
  end
end