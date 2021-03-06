% read in 100 running times for each method, for each d.
dmax = 3;

gdapB_times = zeros(100,dmax);
mosek_times = zeros(100,dmax);
DIA_times   = zeros(100,dmax);

gdapB_errors = zeros(100,dmax);
mosek_errors = zeros(100,dmax);
DIA_errors   = zeros(100,dmax);


for d=2:dmax
    for i=1:100
        
        dir = sprintf('./benchmarking_results/d%i',d);
        
        load([dir,'/dataset',num2str(i)]);
        
        load([dir,'/DIA_results',num2str(i)]);
        DIA_times(i,d)  = elapsedTime;
        choi_DIA        = reshape(choi_ml_vec,[],d*d);
        DIA_errors(i,d) = trace_dist(choi_ground/trace(choi_ground),choi_DIA/trace(choi_DIA));
        
        clear choi_ml_vec
               
        load([dir,'/gdapB_results',num2str(i)]);
        gdapB_times(i,d) = elapsedTime;
        choi_gdapB        = reshape(choi_ml_vec,[],d*d);
        gdapB_errors(i,d) = trace_dist(choi_ground/trace(choi_ground),choi_gdapB/trace(choi_gdapB));
        
        clear choi_ml_vec
        
        load([dir,'/mosek_results',num2str(i)]);
        mosek_times(i,d) = elapsedTime;    
        choi_mosek        = reshape(choi_ml_vec,[],d*d);
        mosek_errors(i,d) = trace_dist(choi_ground/trace(choi_ground),choi_mosek/trace(choi_mosek));
        
        clear choi_ml_vec
    end
end

figure; hold on;

errorbar(2:dmax,mean(DIA_times(:,2:end)),std(DIA_times(:,2:end)),'-rd');
errorbar(2:dmax,mean(gdapB_times(:,2:end)),std(gdapB_times(:,2:end)),'-b*');
errorbar(2:dmax,mean(mosek_times(:,2:end)),std(mosek_times(:,2:end)),'-gx');
xlim([1.8,dmax+0.2])
xlabel 'Hilbert space dimension'
ylabel 'times taken (s)';
legend('DIA','gdapB','mosek')
saveas(gcf,'time.png')


figure; hold on;

errorbar(2:dmax,mean(DIA_errors(:,2:end)),std(DIA_errors(:,2:end)),'-rd');
errorbar(2:dmax,mean(gdapB_errors(:,2:end)),std(gdapB_errors(:,2:end)),'-b*');
errorbar(2:dmax,mean(mosek_errors(:,2:end)),std(mosek_errors(:,2:end)),'-gx');
xlim([1.8,dmax+0.2])
ylim([0,1])
xlabel 'Hilbert space dimension'
ylabel 'J distance';
legend('DIA','gdapB','mosek')
saveas(gcf,'errors.png')


