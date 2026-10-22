# Fintech Credit Risk & Underwriting Optimization

Fintech credit-risk analytics project using MySQL and Power BI to evaluate historical default patterns, loan-size risk, housing-related risk, verification patterns and underwriting trade-offs.

## Project Overview

Digital lending portfolios need to balance loan growth with credit risk and financial exposure.

This project analyzes 39,717 historical LendingClub loan records to identify observed risk patterns and evaluate a targeted underwriting scenario using SQL analysis and Power BI.

## Business Problem

The analysis focuses on questions that can support credit-risk monitoring and underwriting decisions:

- Does observed default risk increase with loan size?
- How do housing categories differ in default risk and financial exposure?
- How much loan amount is associated with Charged Off records?
- Does verification status show different observed default patterns?
- What is the historical trade-off associated with restricting higher-risk loan segments?

## Objectives

- Analyze observed default rates across loan-size tiers.
- Compare housing categories by loan volume, exposure and default rate.
- Quantify the loan amount associated with Charged Off records.
- Compare default patterns across verification-status categories.
- Simulate the historical impact of a targeted underwriting restriction.
- Translate the analysis into an executive Power BI dashboard.

## Business Questions

1. Do larger loans show higher observed default rates than smaller loans?
2. How does housing status relate to observed credit risk and capital exposure?
3. What is the monetary loan amount associated with Charged Off records?
4. How do observed default rates differ by verification status?
5. What is the historical trade-off of restricting RENT borrowers requesting loans of $20,000 or more?

## Dataset

- Dataset: LendingClub Loan Default Risk Dataset
- Records analyzed: 39,717
- Primary analytical outcome: Charged Off loan status
- Other loan statuses: Current and Fully Paid

Initial SQL profiling checked record counts, duplicate IDs, missing values and categorical distributions before the business-question analysis.

## SQL Analysis

MySQL was used as the primary analytical engine.

The workflow included:

1. Initial data profiling
2. Duplicate and missing-value checks
3. Categorical exploration
4. Loan-size segmentation
5. Housing-risk analysis
6. Portfolio loss/exposure analysis
7. Verification-status analysis
8. Targeted underwriting-policy simulation

Loan-size tiers were defined as:

- Small: <= $10,000
- Medium: > $10,000 and <= $20,000
- High: > $20,000

## Power BI Dashboard

The Power BI dashboard presents:

- Portfolio KPIs
- Default rate by loan-size tier
- Default rate by home ownership
- Default rate by verification status
- Underwriting policy scenario for the RENT + >=$20,000 segment

The dashboard is designed to connect descriptive risk analysis with a specific business decision scenario.

## Key Findings

### 1. Default Rates Increased With Loan Size

Observed default rates increased across the analyzed loan tiers:

- Small: 13.12%
- Medium: approximately 14.36%
- High: approximately 18.76%

### 2. Housing Categories Show Different Risk and Exposure Profiles

Mortgage borrowers had the lowest observed default rate at 13.18% but represented more than $224M in loan exposure.

Renters recorded a 15.02% observed default rate and represented a significant share of loan volume.

### 3. Charged-Off Loan Amount Was Significant

Approximately $68.11M in loan amount was associated with Charged Off records, representing roughly 15.3% of total analyzed loan amount.

This figure represents the loan amount associated with Charged Off records; it should not automatically be interpreted as final accounting loss after recoveries, interest, fees or other adjustments.

### 4. Verification Status Showed an Unexpected Pattern

Verified loans recorded a 16.01% observed default rate compared with 12.66% for Not Verified loans.

This is an observed association. It does not establish that verification causes higher default risk. Possible explanations include selection effects or differences in underwriting criteria.

### 5. The RENT + >=$20,000 Segment Had Elevated Historical Risk

The targeted segment recorded a 19.14% historical default rate.

Within the segment:

- Charged Off: 401 loans / approximately $9.88M
- Current: 123 loans / approximately $3.11M
- Fully Paid: 1,571 loans / approximately $37.50M
- Total: 2,095 loans / approximately $50.49M

A blanket restriction could historically have avoided exposure associated with the Charged Off loans, but it would also have affected loans that were Current or Fully Paid.

## Underwriting Scenario

The project evaluates the historical trade-off associated with restricting borrowers who:

- Have RENT as their home ownership status
- Requested a loan amount of $20,000 or more

The analysis does not establish that blanket rejection is the optimal policy. Instead, it demonstrates the trade-off between potential risk reduction and retained lending volume.

Potential areas for further evaluation include:

- Risk-based credit limits
- Additional underwriting criteria
- Risk-based pricing
- Enhanced verification requirements

## Recommendations

- Apply greater risk controls to larger loan requests.
- Investigate the RENT + >=$20,000 segment before applying blanket restrictions.
- Investigate the unexpected verification-status pattern.
- Monitor both default rate and financial exposure.
- Establish ongoing monitoring of Charged Off exposure and key risk segments.

## Limitations

- The analysis uses historical observational data and identifies associations rather than causation.
- Findings are based on 39,717 historical loan records and should not automatically be generalized to every lender or current lending environment.
- Charged Off is treated as the default outcome for this analysis.
- Charged-Off loan amount is not necessarily equivalent to final accounting loss.
- The underwriting scenario is a historical simulation, not a predictive model.
- The Current and Fully Paid amounts in the targeted segment should not be described as guaranteed future revenue or profit.
- Risk rate and financial exposure measure different dimensions of portfolio risk.

## Tools

- MySQL
- MySQL Workbench
- SQL
- Power BI
- DAX

## Project Files

- SQL analysis script
- Loan dataset
- Power BI report
- Project documentation
- Dashboard/exported report

## Outcome

The project demonstrates an end-to-end credit-risk analytics workflow:

SQL profiling → Business-question analysis → Risk segmentation → Financial exposure analysis → Policy simulation → Power BI dashboard

## Author

Sofeeyah Adekunle
Data Analyst
