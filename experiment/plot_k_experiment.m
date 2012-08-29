function [] = plot_k_experiment (file, method)

  load (['k_' method '_' file]);

  no_dims=1;
  while (isempty(CRTT{no_dims}))
    no_dims = no_dims+1;
  end

  for i = no_dims:length(CRTT)
    [maximum(i), max_ind(i)] = max (CRTT{i});
    minimum(i) = min(CRTT{i});
    average(i) = mean (CRTT{i});
  end
  
  [AX,H1,H2] = plotyy(no_dims:length(CRTT), maximum(no_dims:length(CRTT)), no_dims:length(CRTT), CONN_COMP(no_dims:length(CRTT)), 'plot');

  set(get(AX(1),'Ylabel'),'String','best accuracy') 
  set(get(AX(2),'Ylabel'),'String','graph coverage') 
  
  xlabel ('k');

  print ('-dpng', ['k_' method '_' file '_result.png']);
end