<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.ascx.cs" Inherits="RoyalCancun.UserControls.Login.LoginForm" %>
<div class="row">
    <div>
        <div class="centered"><label>Please enter your user data:</label></div>
        <div class="form-group">
            <label>Username:</label>
            <input type="text" name="login_username" id="login_username" class="form-control" maxlength="45"/>
            <label>Password</label>
            <input type="password" name="login_pw" id="login_pw" class="form-control" maxlength="100"/>
        </div>
        <div class="form-group">
            <button type="button" class="btn btn-success" id="login_SubmitButton">LOGIN</button>
        </div>
    </div>
</div>
<script>
    $(function () {
        $("#login_SubmitButton").on("click", function () {
            LoginAttempt();
        });
    });

    function LoginAttempt() {
        var username = $("#login_username").val()
        var pw = $("#login_pw").val()
        if (username != "" && pw != "") {
            $.ajax({
                type: 'POST',
                url: 'Login.aspx/LoginAttempt',
                data: '{ username: "' + username + '", pw: "' + pw + '"}',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    if(response.d == "1")
                        window.location.replace("Default.aspx");
                    else
                        alert("Invalid Login data, please verify");
                },
                error: function (error) {
                    alert(error.d);
                }
            });
        } else {
            alert("Please enter both fields for Login")
        }
        
    }
</script>