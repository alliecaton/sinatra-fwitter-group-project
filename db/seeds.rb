allie = User.create(username: "alliecaton", email: "alliecaton3@gmail.com", password: "hello")
dallas = User.create(username: "dallascaton", email: "dallas@gmail.com", password: "hello1")

allie.tweets << Tweet.create(content: "My first tweet!")
dallas.tweets << Tweet.create(content: "Hello this is my twitter account!")