<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SignUp.ascx.cs" Inherits="RoyalCancun.UserControls.Login.SignUp" %>
<div class="row">
    <div>
        <div class="centered"><label>Please enter your new user data:</label></div>
        <div class="form-group">
            <label>Username:</label>
            <input type="text" name="signup_username" id="signup_username" class="form-control" maxlength="45"/>
            <label>Name:</label>
            <input type="text" name="signup_username" id="signup_name" class="form-control" maxlength="45"/>
            <label>Last Name:</label>
            <input type="text" name="signup_username" id="signup_lastName" class="form-control" maxlength="45"/>
            <label>Password</label>
            <input type="password" name="signup_pw" id="signup_pw" class="form-control" maxlength="100"/>
            <label>Confirm your Password</label>
            <input type="password" name="signup_pwConfirm" id="signup_pwConfirm" class="form-control" maxlength="100"/>
        </div>
        <div class="form-group">
            <button type="button" class="btn btn-success" id="signup_SubmitButton">LOGIN</button>
        </div>
    </div>
</div>
<script>
    $(function () {
        $("#signup_SubmitButton").on("click", function () {
            submitUser();
        });
    });

    function submitUser() {
        var username = $("#signup_username").val()
        var name = $("#signup_name").val()
        var lastName= $("#signup_lastName").val()
        var pw = $("#signup_pw").val()
        var pwConfirm = $("#signup_pwConfirm").val()
        if (pw == pwConfirm) {
            if (username != "" && name != "" && lastName != "" && pw != "" && pwConfirm != "" ) {
                $.ajax({
                    type: 'POST',
                    url: 'Login.aspx/SignUpUser',
                    data: '{ username: "' + username + '", "name":"'+name+'", "lastName":"'+lastName+'", pw: "' + pw + '"}',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (response) {
                        if (response.d == "1")
                            window.location.replace("Default.aspx");
                        else {
                            var values = response.d.split(';')
                            alert(values[1]);
                        }
                            
                    },
                    error: function (error) {
                        alert(error.d);
                    }
                });
            } else {
                alert("All fields are required, please complete the information")
            }
        } else {
            alert("Both passwords must be the same");
        }
    }
</script>