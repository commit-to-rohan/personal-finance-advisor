% Person Data
% Risk Levels range from 1-3 where 1 has low risk tolerance and 3 can tolerate high risk
person(info(Profession, Age, Monthly_income, Risk_tolerance, Investable_amount, Remaining, Etf, Stocks, Bonds)) :-
    ((Profession = student,
        ((Age >= 18, Age =< 30, Risk_tolerance = 2, Investable_amount is 2 * (Monthly_income / 4)) ;
         (Age >= 31, Age =< 45, Risk_tolerance = 2, Investable_amount is 2 * (Monthly_income / 4)) ;
         (Age >= 46, Age =< 59, Risk_tolerance = 1, Investable_amount is 1 * (Monthly_income / 4)))) ->
            												Remaining is Monthly_income - Investable_amount,
            asset_distribution(Risk_tolerance, Investable_amount, Etf, Stocks, Bonds);
        (Profession = working,
        ((Age >= 18, Age =< 30, Risk_tolerance = 3, Investable_amount is 3 * (Monthly_income / 4)) ;
         (Age >= 31, Age =< 45, Risk_tolerance = 3, Investable_amount is 3 * (Monthly_income / 4)) ;
         (Age >= 46, Age =< 59, Risk_tolerance = 2, Investable_amount is 1 * (Monthly_income / 4)))) ->
           	 												Remaining is Monthly_income - Investable_amount,
            asset_distribution(Risk_tolerance, Investable_amount, Etf, Stocks, Bonds);
        (Profession = retired,
          			 Age >= 60, Risk_tolerance = 1, Investable_amount is Monthly_income / 4) ->
            												Remaining is Monthly_income - Investable_amount,
            asset_distribution(Risk_tolerance, Investable_amount, Etf, Stocks, Bonds)).

asset_distribution(1, Investable_amount, Etf, Stocks, Bonds) :-
    Etf is Investable_amount * 0.5,
    Stocks is Investable_amount * 0.1,
    Bonds is Investable_amount * 0.2.
asset_distribution(2, Investable_amount, Etf, Stocks, Bonds) :-
    Etf is Investable_amount * 0.5,
    Stocks is Investable_amount * 0.3,
    Bonds is Investable_amount * 0.2.
asset_distribution(3, Investable_amount, Etf, Stocks, Bonds) :-
    Etf is Investable_amount * 0.4,
    Stocks is Investable_amount * 0.6,
    Bonds is 0.

%Growth in Market Price of ETFs.
etfs(assets_class(EU_ETFs, US_ETFs, EU_ETFs_Growth, US_ETFs_Growth)) :-
    EU_ETFs = [large_cap-[90, 85, 67, 100],
               mid_cap-[70, 80, 79, 86],
               small_cap-[33, 40, 19, 21]],
    US_ETFs = [large_cap-[9, 12, 13, 20],
    	   	   mid_cap-[4, -0.2, 4.2, 4.5],
    	   	   small_cap-[7, 4, 1, 10]],
    maplist(total_growth, EU_ETFs, EU_ETFs_Growth),
    maplist(total_growth, US_ETFs, US_ETFs_Growth).

%Growth in Market Price of Stocks.
stocks(assets_class(EU_Stock, US_Stocks, EU_Stocks_Growth, US_Stocks_Growth)) :-
    EU_Stock = [siemens-[35, 46, 18, 57],
    	   		 hsbc-[6, 27, 10, 37],
    	   		 nestle-[2.6, 2.8, 2.9, 1],
   	 	   		 sap-[1.6, 2.8, 1.2, 1.4]],
    US_Stocks = [apple-[45, 66, 68, 72],
    	   		 microsoft-[150, 60, 360, 330],
    	   		 google-[65, 46, 108, 109],
   	 	   		 tesla-[30, 36, 38, 42]],
    maplist(total_growth, EU_Stock, EU_Stocks_Growth),
    maplist(total_growth, US_Stocks, US_Stocks_Growth).

%Growth in Market Price of Bonds. 
bonds(assets_class(EU_Bonds, US_Bonds, EU_Bonds_Growth, US_Bonds_Growth)) :-
    EU_Bonds = [eu_govt-[90, 89, 91, 94],
                eu_ishare-[85, 89, 93, 92],
                eu_ibond-[95, 100, 101, 105]],
    US_Bonds = [us_govt-[100, 105, 106, 109],
                us_ishare-[10, 12, 12, 13],
                us_ibond-[120, 125, 126, 127]],
    maplist(total_growth, EU_Bonds, EU_Bonds_Growth),
    maplist(total_growth, US_Bonds, US_Bonds_Growth).

% Calculate total growth in percentage.
total_growth(Key-Values, Key=Growth) :-
    [Initial|Rest] = Values,
    last(Rest, Final),
    Growth is round(((Final - Initial) * 100.0) / Initial * 100) / 100.

%Taxations, with a flat 27.5 tax rate on Capital Gains as per Austrian law
tax(components(Capital, Growth_Bonds, Growth_Stocks, Growth_ETFs, Avg_Growth, Income, Profit, TaxAmount, RemainingAmount)) :-
    Avg_GrowthFloat is ((Growth_Bonds + Growth_Stocks + Growth_ETFs) / 3),
    Avg_Growth is round(Avg_GrowthFloat * 100) / 100,
    IncomeFloat is Capital + (Capital * Avg_Growth / 100),
    Income is round(IncomeFloat * 100) / 100,
    ProfitFloat is Income - Capital,
    Profit is round(ProfitFloat * 100) / 100,
    Gains is Capital * Avg_Growth / 100,
    TaxAmountFloat is Gains * 0.275,
    TaxAmount is round(TaxAmountFloat * 100) / 100,
    RemainingAmountFloat is Income - TaxAmount,
    RemainingAmount is round(RemainingAmountFloat * 100) / 100.