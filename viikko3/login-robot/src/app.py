import re

class App:
    def __init__(self, user_sevice, io):
        self.user_sevice = user_sevice
        self.io = io

    def run(self):
        while True:
            command = self.io.read("Command (new or login): ")

            if not command:
                break

            if command == "new":
                (username, password) = self._read_credentials()

                try:
                    if len(username) < 3:
                        self.io.write("Username is less than three characters")
                    elif re.match("^[a-z]+$", username):
                        if len(password) < 8:
                            self.io.write("Password is less than eight characters")
                        elif re.match("^[a-z]+$", password):
                            self.io.write("Password consists of only letters")
                        else: 
                            self.user_sevice.create_user(username, password)
                            self.io.write("New user registered")
                    else:
                        self.io.write("Username has forbidden characters")
                except Exception as error:
                    self.io.write(str(error))
            elif command == "login":
                (username, password) = self._read_credentials()

                try:
                    self.user_sevice.check_credentials(username, password)
                    self.io.write("Logged in")
                except Exception as error:
                    self.io.write(str(error))

    def _read_credentials(self):
        username = self.io.read("Username: ")
        password = self.io.read("Password: ")

        return (username, password)
