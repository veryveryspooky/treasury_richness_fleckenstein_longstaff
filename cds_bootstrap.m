cds_data = readtable('./cds_data_processed.csv');           
interest_rates = readtable('./interest_rates_from_df.csv');
%%
settlement_date = '2014-09-18';
sd_dn = datenum(settlement_date);
r = interest_rates(interest_rates.Date == settlement_date, :);
%%
zero_rates = table2array(r(:, 16:end))'/100;
zero_dates = datenum(table2array(r(:, 2:15)))';
zero_data = [zero_dates zero_rates];
%%
mkt = cds_data(cds_data.SettlementDate == settlement_date, :);
mkt_dates = datenum(table2array(mkt(:, 2:8)))';
mkt_rates = table2array(mkt(:, 9:end))';
mkt_data = [mkt_dates, mkt_rates];
%%
[ProbData,HazData] = cdsbootstrap(zero_data,mkt_data,sd_dn, 'ZeroCompounding', -1);

%%
plot(zero_rates)
