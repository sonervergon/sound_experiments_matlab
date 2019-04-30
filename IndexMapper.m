function [code, str] = IndexMapper(frequencies, returnKey)
  n = 0:9;
  numbers = [n n n n n n];
  frequencies = round(frequencies, 1);
  possible_frequencies = (300:100:6300)/1000;
  indexes = zeros(size(frequencies));
  ii = 1;
  if strcmp(returnKey, 'code')
    for frequency = frequencies
      index = find(possible_frequencies == frequency);
      indexes(ii) = index;
      ii = ii+1;
    end
    code = strjoin(string(numbers(indexes)));
  else
    A = 300:1000:6000;
    code = frequencies*100 + A;
    str = strjoin(string(frequencies));
    disp('Code ' + strjoin(string(frequencies)) +' hashed to frequencies:')
    disp(num2str(code))
    disp(' ')
  end
end