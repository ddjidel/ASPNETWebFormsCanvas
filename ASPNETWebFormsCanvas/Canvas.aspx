<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Canvas.aspx.cs" Inherits="ASPNETWebFormsCanvas.Canvas" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="CanvasClasses" %>

<!DOCTYPE html>

<script runat="server">
    
    public String _signedRequestJson;
    
    public void Page_Load(object sender, EventArgs e)
    {
        String _consumerSecret = Environment.GetEnvironmentVariable("CANVAS_CONSUMER_SECRET", EnvironmentVariableTarget.Machine);
        String _signedRequestParam = Request.Params["signed_request"];

        if (_signedRequestParam == null)
        {
            return;
        }

        _signedRequestJson = SignedRequest.verifyAndDecodeAsJson(_signedRequestParam, _consumerSecret);
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Chatter Talk .NET Example</title>
    <link rel="stylesheet" type="text/css" href="Content/talk.css" />

    <script type="text/javascript" src="Scripts/canvas.js"></script>
    <script type="text/javascript" src="Scripts/cookies.js"></script>
    <script type="text/javascript" src="Scripts/oauth.js"></script>
    <script type="text/javascript" src="Scripts/xd.js"></script>
    <script type="text/javascript" src="Scripts/client.js"></script>
    <script type="text/javascript" src="Scripts/json2.js"></script>
    <script type="text/javascript" src="Scripts/chatter-talk.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="slide device-access" id="speech-input">
            <section>
                <div id="stylized" class="flex hbox boxcenter">
                    <div style="height:50px;text-align:center">
                        <p>
                            <strong>Chatter Talk</strong><br/>
                        </p>
                    </div>
                    <div style="height:100px;text-align:center">
                        <input id="speech-input-field" type="text" x-webkit-speech />
                        <p style="display:none">Speech input is not enabled in your browser.<br/>Try running Google Chrome with the <code>--enable-speech-input</code> flag.</p>
                    </div>
                    <div style="height:50px;text-align:center">
                        <button id="chatter-submit" type="submit"></button>
                    </div>
                    <div style="height:50px;text-align:center">
                        <span id="status" style="color:green"></span>
                    </div>
                </div>
                <script>

                    if (!('webkitSpeech' in document.createElement('input'))) {
                        document.querySelector('#speech-input p').style.display = 'block';
                    }

                    var sr = JSON.parse('<%=_signedRequestJson%>');
                    chatterTalk.init(sr, "chatter-submit", "speech-input-field", function (data) {
                        Sfdc.canvas.byId('status').innerHTML = data.statusText;
                    });

                </script>
            </section>
        </div>
    </form>
</body>
</html>