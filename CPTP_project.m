function [ projected_choi_vec ] = CPTP_project( choi_vec )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    x    = {choi_vec};
    GAP  = (1.0);
    k    = 1;
    p    = {0};
    q    = {0};
    y    = {0};
    while GAP(end) >= 1e-12 
%     for k=1:1000
%         x{k+1}=PSD_project(TP_project(x{k}));              % ALTERNATING
%         x{k+1}=0.5*PSD_project(x{k})+0.5*TP_project(x{k});   % AVERAGED 
        y{k}   = TP_project(x{k}+p{k}); % DIJKSTRA
        p{k+1} = x{k}+p{k}-y{k};
        x{k+1} = PSD_project(y{k}+q{k});
        q{k+1} = y{k}+q{k}-x{k+1};
%         GAP    = norm(x{end-1}-x{end});      
        if k>2
            GAP(k)  = norm(p{k-1}-p{k})^2+norm(q{k-1}-q{k})^2+2*p{k-1}'*(x{k}-x{k-1}+2*q{k-1}'*(y{k}-y{k-1}));
        end
        k = k + 1;
   end
    projected_choi_vec = x{end};

end

