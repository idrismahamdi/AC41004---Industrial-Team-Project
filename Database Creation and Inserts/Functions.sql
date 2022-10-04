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
