cds_data = readtable('./cds_data_processed.csv');           
interest_rates = readtable('./interest_rates_from_df.csv');
%%
ind1 = interest_rates(interest_rates.Date == '2014-09-18', :);

