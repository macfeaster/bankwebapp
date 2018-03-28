SSE Project
===========

Changelog
---------

Changes made from the starter code, without any particular ordering:

* **Fix:** Resolved a bug where ID mismatches between the Client Info and User tables would result in staff being unable to approve or deny new customer requests.
* **Fix:** Added authentication and authorization for Staff Dashboard, which can no longer be accessed without logging in as a bank employee.
* **Fix:** Resolved a bug where ID mismatches would render the transaction history list empty in the client dashboard view.
* **Fix:** Authentication and authorization for client dashboard.
* **Fix:** Authentication and authorization for new transactions (view and post.)

* **Feature:** The New Transaction functionality is now feature complete, i.e.
    + Transaction codes are now actually validated when making a new transaction.
    + Client Accounts can now be fetched, and for every new transaction the client account is validated to be a valid recipient account
    + Before a transaction can be made, a check will be made to make sure the user’s account has sufficient funds to complete the transaction
    + If the transaction is less than $10,000, the system will approve it and transfer the funds automatically
    + If the transaction is greater than $10,000, no funds will be transferred, and the transaction will be pending a bank employee’s approval

* **Feature:** When employees accept transactions, funds are transferred

* **Feature:** Each client can hold more than one account
    + Balances can be viewed for all accounts
    + When making a transfer, the client can choose which account to transfer from

