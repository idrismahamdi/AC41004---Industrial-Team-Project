
-- Login verifcation for users--
DELIMITER //
CREATE FUNCTION login(uName VARCHAR(255), uPassword VARCHAR(255)) RETURNS BIT
BEGIN
	if EXISTS(select * from user where uName = user.user_name and uPassword = user.user_password)
		THEN
			return 1;

	ELSE 
		return 0;
	END if;
END //
DELIMITER ;

--Gathers accounts based off userID--

DELIMITER //
CREATE PROCEDURE gather_accounts(uID int)
BEGIN

SELECT account.account_ref FROM account, customer, user WHERE account.customer_id = customer.customer_id AND user.user_ID = uID;

END //
DELIMITER ;
