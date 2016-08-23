Libname assign 'O:\spring semester\Predictive assignment\LIB';run;
data assign.factor;
infile "C:\Users\virendsi\Google Drive\Study\2nd sem\Predictive\Assignment\hw 4\data.txt";
input (likeable knowledgeable unattractive Intelligent notsimilar goodlooking unexciting confident friendly unbelievable  expert ugly dontidentify competent active irritating nottrustworthy dull notsincere) (1.);
run;


/*1.1.*/

ODS RTF file = 'answer';
proc corr data = assign.factor;
run;
ODS RTF Close;

/*1.2.a */ 
ODS RTF file = 'answer1';
proc factor data = assign.factor
method = principal 
priors = smc
rotate = none
scree;

var likeable knowledgeable unattractive Intelligent notsimilar goodlooking unexciting confident friendly unbelievable  expert ugly dontidentify competent active irritating nottrustworthy dull notsincere;
run;
ODS RTF Close;
/* 1.2.b*/

ODS RTF file = 'answer1';
proc factor data = assign.factor
method = principal
priors = smc
nfactors=3
rotate = none
scree;

var likeable knowledgeable unattractive Intelligent notsimilar goodlooking unexciting confident friendly unbelievable  expert ugly dontidentify competent active irritating nottrustworthy dull notsincere;
run;
ODS RTF Close;



/*1.3*/

ODS RTF file = 'answer1';
proc factor data = assign.factor
method = principal
priors = smc
rotate = varimax
scree;

var likeable knowledgeable unattractive Intelligent notsimilar goodlooking unexciting confident friendly unbelievable  expert ugly dontidentify competent active irritating nottrustworthy dull notsincere;
run;
ODS RTF Close;


/*Answer 2*/

Libname assign 'O:\spring semester\Predictive assignment\LIB';
proc import datafile = "O:\spring semester\Predictive assignment\assign 4 data\pda_2001.csv"
dbms = csv

out = assign.cluster
replace;

getnames =yes;
run;

proc print data = assign.cluster;
run;


proc standard data = assign.cluster mean = 0 STD = 1 out  = assign.clusterSTD;
var Innovator	Use_message	Use_cell	Use_PIM	Inf_passive	INF_active	remote_access	Share_info	Monitor	Email	Web	M_media	ergonomic	monthly	price;

run;

proc print data = assign.clusterSTD;run;

ODS RTF File = "a1";
proc cluster data  = assign.clusterSTD method =ward  
outtree = assign.Initcluster ccc pseudo RMSSTD;
ID ID;
run;


proc tree data = assign.Initcluster out = fivenodetree n = 4 ;
 copy ID Innovator	Use_message	Use_cell	Use_PIM	Inf_passive	INF_active	remote_access	Share_info	Monitor	Email	Web	M_media	ergonomic	monthly	price;

run;

proc print data = fivenodetree;
run;

Proc import datafile = "O:\spring semester\Predictive assignment\assign 4 data\pda_disc2001.csv" 
dbms = csv

out = assign.clusterdemo
replace;

getnames =yes;
run;

proc print data = assign.clusterdemo;
run;

Proc sort data = fivenodetree;
BY ID;

run;
proc print ;
run;


Data assign.clustered;
Merge fivenodetree assign.clusterdemo ; by ID;RUN;proc print;
run;










ods rtf file = 'a3' ;
proc means data = assign.clustered;
class Cluster;

run;

ods rtf close;

proc means data = assign.clustered;


run;




ODS RTF Close;


/* answer 2.2 */

ODS RTF file = "a2";
proc fastclus data = assign.clusterSTD maxclusters = 4 replace = full out = assign.manualcluster; 
id ID ;
run;

proc sort data = assign.manualcluster;
by ID;
Run;
proc print; run;

data assign.manualclustered;
merge assign.manualcluster assign.clusterdemo; by ID;
run;
proc print; run;

ods rtf file = 'a6';

Proc means data = assign.manualclustered;
class cluster;
run;


ods rtf close;
Proc means data = assign.manualclustered;

run;

ODS RTF Close;
