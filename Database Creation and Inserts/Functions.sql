DELIMITER //
CREATE FUNCTION login(uName VARCHAR(255), uPasssword VARCHAR(255)) RETURNS BIT
BEGIN
	if EXISTS(select * from user where uName = user.user_id and uPassword = user.user_password)
		THEN
			return 1;
	END if;
END //
DELIMITER ;
