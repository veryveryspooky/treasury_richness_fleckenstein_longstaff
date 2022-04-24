cds_data = readtable('./cds_data_processed.csv');           
interest_rates = readtable('./interest_rates_from_df.csv');
%%
start_date = datenum('2015-01-01');
end_date = datenum('2022-03-31');
for settlementdate = start_date:end_date

sd_dn = datenum(settlement_date);
r = interest_rates(interest_rates.Date == settlement_date, :);
%%
zero_rates = table2array(r(:, 17:end))'/100;
zero_dates = datenum(table2array(r(:, 2:16)))';
zero_data = [zero_dates zero_rates];
%%
mkt = cds_data(cds_data.SettlementDate == settlement_date, :);
mkt_dates = datenum(table2array(mkt(:, 2:8)))';
mkt_rates = table2array(mkt(:, 9:end))';
mkt_data = [mkt_dates, mkt_rates];
%%
[ProbData,HazData] = cdsbootstrap(zero_data,mkt_data,sd_dn, 'ZeroCompounding', -1);

end
%%
plot(HazData(:,2))
