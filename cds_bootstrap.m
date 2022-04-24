cds_data = readtable('./cds_data_processed.csv');           
interest_rates = readtable('./interest_rates_from_df.csv');
%%
% start_date = datenum('2015-01-02');
% end_date = datenum('2022-03-31');
rows = zeros(length(cds_data.SettlementDate), 8);
% settlement_date = start_date;
for i = 1:length(cds_data.SettlementDate)

    settlement_date = cds_data.SettlementDate(i);
    sd_dn = datenum(settlement_date);
    r = interest_rates(interest_rates.Date == datestr(settlement_date), :);

    zero_rates = table2array(r(:, 17:end))'/100;
    zero_dates = datenum(table2array(r(:, 2:16)))';
    zero_data = [zero_dates zero_rates];

    mkt = cds_data(cds_data.SettlementDate == datestr(settlement_date), :);
    mkt_dates = datenum(table2array(mkt(:, 2:8)))';
    mkt_rates = table2array(mkt(:, 9:end))';
    mkt_data = [mkt_dates, mkt_rates];

    [temp,HazData] = cdsbootstrap(zero_data,mkt_data,sd_dn, 'ZeroCompounding', -1);
    rows(i, :) = [sd_dn HazData(:,2)'];

end
%%
a = num2cell(rows);
a = cell2table(a);
a.a1 = datestr(a.a1(:,1));
%%
writetable(a, 'hazard_rates.csv')
