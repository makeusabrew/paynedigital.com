module.exports =
    admin:
        login: (browser) ->
            browser
            .fill("email", "test@example.com")
            .fill("password", "t3stp4ss")
            .pressButton("Login")
