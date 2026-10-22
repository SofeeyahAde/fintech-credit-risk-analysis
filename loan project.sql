-- Step 1: Initial Profiling & Duplication Audit
SELECT COUNT(*)
FROM loans;

SELECT id, COUNT(*)
FROM loans
GROUP BY id
HAVING COUNT(*) > 1;

-- Step 2: Null/Missing Value Check
SELECT
	SUM(CASE WHEN loan_amnt IS NULL THEN 1 ELSE 0 END) AS missing_loan_amounts,
	SUM(CASE WHEN loan_status IS NULL OR loan_status = '' THEN 1 ELSE 0 END) AS missing_statuses,
	SUM(CASE WHEN home_ownership IS NULL OR home_ownership = '' THEN 1 ELSE 0 END) AS missing_ownership
FROM loans;

-- Step 3: Categorical Baseline Exploration
SELECT loan_status, COUNT(*), AVG(loan_amnt)
FROM loans
GROUP BY loan_status;

SELECT home_ownership, COUNT(*)
FROM loans
GROUP BY home_ownership;

SELECT verification_status, COUNT(*), SUM(loan_amnt)
FROM loans
GROUP BY verification_status;

SELECT SUM(loan_amnt) AS total_loan, AVG(loan_amnt) AS avg_loan
FROM loans;

SELECT loan_status, SUM(loan_amnt) AS total_loan, AVG(loan_amnt) AS avg_loan
FROM loans
GROUP BY loan_status;

SELECT purpose, COUNT(*) AS total_count, AVG(loan_amnt) AS avg_loan
FROM loans
GROUP BY purpose
ORDER BY total_count DESC;

-- Step 4: Answering the Business Questions
-- Business Question 1 : Do larger loans default more than smaller loans?
WITH tiering AS
	(SELECT 
		loan_status, 
        loan_amnt,
		CASE 
			WHEN loan_amnt <= 10000 THEN 'Small'
			WHEN loan_amnt <= 20000 THEN 'Medium'
			ELSE 'High'
		END AS loan_tier
	FROM loans)
SELECT 
	loan_tier, 
    COUNT(*) AS total_loans,
    COUNT(CASE WHEN loan_status = 'Charged Off' THEN 1 END) total_charged,
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN 1 END)/ COUNT(*)) * 100 AS `Default Rate`
FROM tiering
GROUP BY loan_tier;

-- Answer: Default rates rises with loan size: 13.1% for small loans, 14.4% for medium, and 18.8% for high.

-- Business Question 2 : Does a borrower's housing stability correlate with their creditworthiness?
SELECT 
	home_ownership,
    SUM(loan_amnt) AS total_amount,
    COUNT(*) AS total_loans,
    COUNT(CASE WHEN loan_status = 'Charged Off' THEN 1 END) AS total_charged,
	(COUNT(CASE WHEN loan_status = 'Charged Off' THEN 1 END)/ COUNT(*)) * 100 AS `Default Rate`
FROM loans
GROUP BY home_ownership;

-- Answer: Renters combine high volume with a higher default rate of 15.02%, making them the main segment driving capital loss.

SELECT 
	home_ownership,
    COUNT(*)
FROM loans
GROUP BY home_ownership;
-- OTHER has the highest default rate (18.37%) but only 98 loans, so the figure is unstable and I excluded it from conclusions.

-- Business Question 3 : What is the total monetary cost of defaults to date, and how much is permanently trapped in Charged Off status?
SELECT 
	SUM(loan_amnt) AS total_amount,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN loan_amnt END) AS total_loss,
    (SUM(CASE WHEN loan_status = 'Charged Off' THEN loan_amnt END)/ SUM(loan_amnt)) * 100 AS `Loss Rate`
FROM loans;

/* Answer: About 15.3% of the total loan value ($68.1M of $445.6M) is in Charged Off status. */

-- Business Question 4 : Does verified borrowers default less often, or is the verification process failing to screen out risky borrowers?
SELECT 
	verification_status,
    COUNT(*) AS `Total Loan Volume`,
	SUM(loan_amnt) AS `Total Amount`,
    SUM(CASE WHEN loan_status = 'Charged Off' THEN loan_amnt END) AS `Total Cash Lost`,
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN 1 END)/ COUNT(*)) * 100 AS `Default Rate`,
	(SUM(CASE WHEN loan_status = 'Charged Off' THEN loan_amnt END)/ SUM(loan_amnt)) * 100 AS `Loss Rate`
FROM loans
GROUP BY verification_status;

/* Answer: Verified loans default 3.3 percentage points more often than unverified loans. Verification may be applied to higher-risk 
applications, or it may not be screening risk effectively.*/

-- Business Question 5 : What is the quantifiable financial impact of tightening our lending requirements?
SELECT 
	loan_status, 
    COUNT(*) AS 'Total Loans', 
    SUM(loan_amnt) AS 'Total Amount'
FROM loans
WHERE loan_amnt >= 20000 AND home_ownership = 'RENT'
GROUP BY loan_status;

/* Answer: Restricting this segment would have avoided about $9.9M in charged-off loans, but it would also have blocked 
about $40.6M in loans that were repaid or stil current. The segment's default is 19.14%, against a portfolio baseline of about 15.3%.*/









