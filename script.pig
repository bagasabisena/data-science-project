A = load 'CompanyList.csv' using PigStorage(',') AS (rank,name,country,sector,value);
companies = FOREACH A GENERATE name;

B = load 'small_input.warc';
data = foreach B generate FLATTEN(TOKENIZE($0));

J = JOIN companies BY $0 RIGHT OUTER, data BY $0;

K = FILTER J BY $0 IS NOT NULL;

L = group K by $0;

M = foreach L generate $0, COUNT($1);

N = order M by $1 desc;

DUMP N;