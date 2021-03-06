SET mapred.reduce.slowstart.completed.maps 0.9
SET DEFAULT_PARALLEL 20

REGISTER udfs.jar

A = load '/user/TUD-DS01/CompanyList.csv' using PigStorage(',') AS (rank,name,country,sector,value);
companies = FOREACH A GENERATE name;

B = load '/data/public/common-crawl/crawl-data/CC-MAIN-2014-10/segments/*/wet/*' as line;

C =FILTER B BY NOT(line MATCHES '^WARC.*' or line MATCHES '^Content-.*');
data = foreach C generate flatten(udfs.NGramGenerator($0));


J = JOIN companies BY $0 RIGHT OUTER, data BY $0;

K = FILTER J BY $0 IS NOT NULL;

L = group K by $0;

M = foreach L generate $0, COUNT($1);

N = order M by $1 desc;

store N into '/user/TUD-DS01/outputs_2015_07_07_full';
