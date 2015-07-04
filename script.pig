A = load '/user/TUD-DS01/CompanyList.csv' using PigStorage(',') AS (rank,name,country,sector,value);
companies = FOREACH A GENERATE name;

B = load '/data/public/common-crawl/crawl-data/CC-TEST-2014-10/segments/1394678706211/wet/CC-MAIN-20140313024506-00099-ip-10-183-142-35.ec2.internal.warc.wet.gz' as line;
C =FILTER B BY NOT(line MATCHES '^WARC.*' or line MATCHES '^Content-.*');
data = foreach C generate flatten(udfs.NGramGenerator($0));

J = JOIN companies BY $0 RIGHT OUTER, data BY $0;

K = FILTER J BY $0 IS NOT NULL;

L = group K by $0;

M = foreach L generate $0, COUNT($1);

N = order M by $1 desc;

store N into '/user/TUD-DS01/output3.txt';
