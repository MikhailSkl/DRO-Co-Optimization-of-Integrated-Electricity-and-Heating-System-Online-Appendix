% Input data file
%wind data
% Wind data
load('AV_AEMO');
% Wmin   Wmax   El_Bus
gridinfo.WindDATA=[
    0     50     3; %1 
    0     50     2; %1
%    0     200     6; %1
    ];
gridinfo.ChpDATA=[
% Pmin  Pmax   R+    R-   El_Bus   C_el     phi    Hmin  Hmax  C_heat Coef
   15    208.3  40    40     6       3.6    12.65    0    250   0.06002     1.5  ;   %1
%   0    152    40    40     2       22     13.45    0    304   4     1.5;    %2
    ];
gridinfo.HPDATA=[
% Hmin  Hmax   R+    R-   El_Bus   Cel    Cheat   COP
    5    100     20    5      3      12      4     2.5;   %1
%   0    152    40    40     2       22     4     0.9;   %2
    ];
%Heat system data
%% District heating data
%gridinfo.Nodes=["N1"; "N2"; "N3"; "N4"; "N5"];

heatgrid.Nodes=[1; 2; 3; 4; 5; 6; 7];
%%Set of nodes with single pipes starting
%gridinfo.NodesS=["N5"; "N1"; "N3"];
heatgrid.NodesS=[1; 6];
%gridinfo.NodesE=["N1"; "N2"; "N3"; "N4"];
heatgrid.NodesE=[2; 3; 4; 5; 7;];
%Set of pipes ending at node N;
%%Matrix NODESxPIPES
PipesEND=[0 0 0 0 0 0;
          1 0 0 0 0 0;
          0 1 0 0 0 0;
          0 0 1 0 1 0;
          0 0 0 1 0 0;
          0 0 0 0 0 0;
          0 0 0 0 0 1;];
PipesSTART=[1 0 0 0 0 0;
            0 1 1 0 0 0;
            0 0 0 0 0 0;
            0 0 0 1 0 1;
            0 0 0 0 0 0;
            0 0 0 0 1 0;
            0 0 0 0 0 0;];
heatgrid.PipesEND=PipesEND;
heatgrid.PipesSTART=PipesSTART;
 %Heat load
 % Heat load   Node   mfMax   mfmin 
Hl=[
    0         1        0         0;      
    0         2        0         0;     
   0.45       3        700      300; %l1
    0         4        0         0;     
   0.40       5        700      300; %l2
    0         6        0         0;     
   0.50       7        700      300;  %l3
    ];
%Heat source heat data
%   Node   mfMax   mfmin 
HS=[
          1        700     300; %s1     
          2        0        0;     
          3        0        0; 
          4        0        0;     
          5        0        0;  
          6        700     300; %s2
          7        0        0; 
    ];

%%IF ADD CHP or HP DONT FOGET TO CHANGE REALLY IMPORTANT!!!!!!!!!
hs_node=[1; 0; 0; 0; 0; 2; 0;];
chp_node=[1; 0; 0; 0; 0; 0; 0;];
hp_node=[0; 0; 0; 0; 0; 1; 0;];
%%IF ADD CHP or HP DONT FOGET TO CHANGE REALLY IMPORTANT!!!!!!!!!
heatgrid.hs_node=hs_node;
heatgrid.chp_node=chp_node;
heatgrid.hp_node=hp_node;
heatgrid.Hl =Hl(:,1);
heatgrid.mf_l_max=Hl(:,3);
heatgrid.mf_l_min=Hl(:,4);
heatgrid.mf_C_max=HS(:,2);
heatgrid.mf_C_min=HS(:,3);
%%
heatgrid.NodeL=[3; 5; 7;];
heatgrid.NodeSource=[1; 6;];
heatgrid.NodeHP=[6;];
heatgrid.NodeCHP=[1;];
%%
%maximum mass flow rates of the load
%%Temperature limits
heatgrid.Ts_max=[65; 65; 65; 65; 65; 65; 65]
heatgrid.Ts_min=[50; 50; 50; 50; 50; 50; 50]
heatgrid.Tr_max=[45; 45; 45; 45; 45; 45; 45]
heatgrid.Tr_min=[25; 25; 25; 25; 25; 25; 25;]
%%Presure limits
heatgrid.prS_max=[30000; 30000; 30000; 30000; 30000; 30000; 30000]
heatgrid.prS_min=[0; 0; 0; 0; 0; 0; 0]
heatgrid.prR_max=[30000; 30000; 30000; 30000; 30000; 30000; 30000]
heatgrid.prR_min=[0; 0; 0; 0; 0; 0; 0]
heatgrid.pr_diff_min=[0; 0; 50; 0; 50; 0; 50]
%% Pipes data

pipes_data_S=[
%pipe   %from   %to   %lemgth,m  minMF  maxMF  minT, C max, T 
    1     1      2       800      300      700     50    65;      
    2     2      3       600      300      700     50    65;       
    3     2      4       800      300      700     50    65;   
    4     4      5       500      300      700     50    65;
    5     6      4       800      300      700     50    65;   
    6     4      7       500      300      700     50    65;
    ];
heatgrid.mfS_max=pipes_data_S(:,6);
heatgrid.mfS_min=pipes_data_S(:,5);
heatgrid.Tpipe_S_max=pipes_data_S(:,8);
heatgrid.Tpipe_S_min=pipes_data_S(:,7);
heatgrid.Lp=pipes_data_S(:,4);
%Return pipes
pipes_data_R=[
%pipe   %from   %to   %lemgth,m  minMF  maxMF  minT, C max, T 
    1     2      1       800      300      700     25    45;      
    2     3      2       600      300      700     25    45;       
    3     4      2       800      300      700     25    45;   
    4     5      4       500      300      700     25    45;
    5     4      6       800      300      700     25    45;   
    6     7      4       500      300      700     25    45;
    ];
heatgrid.mfR_max=pipes_data_R(:,6);
heatgrid.mfR_min=pipes_data_R(:,5);
heatgrid.Tpipe_R_max=pipes_data_R(:,8);
heatgrid.Tpipe_R_min=pipes_data_R(:,7);
%%Set of HS stations


