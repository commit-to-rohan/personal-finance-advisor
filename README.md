# Personal Finance Advisor

A Prolog-based personal finance advisor designed to assist individuals in determining their optimal investment options and asset distribution based on their profession, age, monthly income, and risk tolerance. The advisor also calculates the growth of various investment assets and provides taxation details according to Austrian law.

## Table of Contents

- [Overview](#overview)
- [Usage](#usage)
- [Person Data](#person-Data)
- [Assets Growth](#assets-growth)
- [Taxation](#taxation)
- [Contributing](#contributing)
- [License](#license)

## Overview

The advisor classifies individuals into three professions: 
- Student
- Working Professional
- Retired

Based on the profession, age, monthly income, and risk tolerance of an individual, the advisor calculates the investable amount and suggests an asset distribution strategy among ETFs, stocks, and bonds.

## Usage

To use the personal finance advisor, you need to consult the Prolog file and then query the `person/1` predicate with the person's information.

## Person Data

```prolog
person(info(Profession, Age, Monthly_income, Risk_tolerance, Investable_amount, Remaining, Etf, Stocks, Bonds))
```
Profession: Possible values are student, working, and retired.<br />
Age: Age of the person.<br/>
Monthly_income: Monthly income of the person. <br/>
Risk_tolerance: Risk tolerance level (1 to 3). <br/>
Investable_amount: Calculated investable amount. <br/>
Remaining: Remaining amount after investment. <br/>
Etf, Stocks, Bonds: Asset distribution. <br/>

Example:
```prolog
?- person(info(working, 40, 5000, 3, Investable_amount, Remaining, Etf, Stocks, Bonds)).
```


## Assets Growth
The advisor calculates the growth in the market price of various assets including:
ETFs<br/>
Stocks<br/>
Bonds<br/>
The growth is represented as a percentage.

## Assets Growth Data
```prolog
etfs(assets_class(EU_ETFs, US_ETFs, EU_ETFs_Growth, US_ETFs_Growth)).
stocks(assets_class(EU_Stock, US_Stocks, EU_Stocks_Growth, US_Stocks_Growth)).
bonds(assets_class(EU_Bonds, US_Bonds, EU_Bonds_Growth, US_Bonds_Growth)).
```
Example:
```prolog
?- etfs(assets_class(EU_ETFs, US_ETFs, EU_ETFs_Growth, US_ETFs_Growth)).
```
## Taxation
The advisor also provides taxation details based on the capital gains with a flat 27.5% tax rate as per Austrian law.

```prolog
tax(components(Capital, Growth_Bonds, Growth_Stocks, Growth_ETFs, Avg_Growth, Income, Profit, TaxAmount, RemainingAmount))
```
Capital: Initial capital.<br/>
Growth_Bonds, Growth_Stocks, Growth_ETFs: Growth percentage of bonds, stocks, and ETFs. <br/>
Avg_Growth: Average growth percentage. <br/>
Income: Total income after growth. <br/>
Profit: Profit after investment.<br/>
TaxAmount: Tax amount to be paid.<br/>
RemainingAmount: Remaining amount after tax.<br/>

Example:
```prolog
?- tax(components(10000, 5, 10, 15, Avg_Growth, Income, Profit, TaxAmount, RemainingAmount)).
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
This project is licensed under the MIT License - see the LICENSE.md file for details.

```sql
Note: Please make sure to add a `LICENSE.md` file with the MIT License text or any other license you prefer.
```
